import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/providers.dart';
import '../../../core/domain/detergent_draft.dart';
import '../../../core/domain/enums.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/localization/labels.dart';
import '../../../core/scan/label_parser.dart';
import '../../../services/photo_service.dart';
import '../../../widgets/app_scaffold_body.dart';
import '../../../widgets/laundry_art.dart';
import '../editor/detergent_basics_page.dart';
import '../editor/dose_setup_page.dart';

class LabelScanPage extends ConsumerStatefulWidget {
  const LabelScanPage({super.key});
  @override
  ConsumerState<LabelScanPage> createState() => _ScanState();
}

class _ScanState extends ConsumerState<LabelScanPage> {
  late final PhotoService _photos;
  final _name = TextEditingController();
  DetergentType _type = DetergentType.liquid;
  List<LabelTextLine>? _lines;
  List<LabelDoseCandidate> _candidates = [];
  final Set<int> _confirmed = {};
  String? _relative;
  File? _file;
  bool _busy = false, _saved = false, _failed = false;

  @override
  void initState() {
    super.initState();
    _photos = ref.read(photoServiceProvider);
  }

  @override
  void dispose() {
    _name.dispose();
    if (!_saved) {
      unawaited(_photos.delete(_relative).catchError((_) {}));
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final supported = ref.watch(labelScanServiceProvider).isSupported;
    final reviewed = _lines != null;
    return Scaffold(
      appBar: AppBar(title: Text(reviewed ? l.reviewScan : l.scanLabel)),
      body: SafeArea(
        child: AppScaffoldBody(
          child: ListView(
            padding: const EdgeInsets.only(top: 16, bottom: 32),
            children: [
              if (!reviewed) ...[
                const LaundryArt(height: 205),
                const SizedBox(height: 20),
                Text(
                  l.scanTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 14),
                Text(l.scanBody),
                const SizedBox(height: 22),
              ] else ...[
                if (_file != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: _openPhoto,
                      child: Image.file(
                        _file!,
                        height: 145,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(l.scanReviewBody),
                const SizedBox(height: 18),
                TextField(
                  controller: _name,
                  maxLength: 60,
                  decoration: InputDecoration(
                    labelText: l.name,
                    hintText: l.detergentNamePlaceholder,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SegmentedButton<DetergentType>(
                    segments: [
                      for (final t in DetergentType.values)
                        ButtonSegment(
                          value: t,
                          label: Text(detergentTypeLabel(context, t)),
                        ),
                    ],
                    selected: {_type},
                    showSelectedIcon: false,
                    onSelectionChanged: (values) => setState(() {
                      _type = values.single;
                      _candidates = LabelParser().parse(_lines!, _type);
                      _confirmed.clear();
                    }),
                  ),
                ),
                const SizedBox(height: 18),
                if (_candidates.isEmpty)
                  Text(l.scanNoValues)
                else ...[
                  Text(
                    l.scanEvidence,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  for (var i = 0; i < _candidates.length; i++)
                    Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: CheckboxListTile(
                        value: _confirmed.contains(i),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(_candidates[i].evidence),
                        onChanged: (v) => setState(() {
                          if (v == true) {
                            _confirmed.add(i);
                          } else {
                            _confirmed.remove(i);
                          }
                        }),
                      ),
                    ),
                  Text(
                    l.scanUnitNote,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                const SizedBox(height: 14),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(l.readText),
                  children: [
                    SelectableText(_lines!.map((x) => x.text).join('\n')),
                  ],
                ),
                const SizedBox(height: 16),
                if (_candidates.isNotEmpty)
                  FilledButton(
                    onPressed:
                        _confirmed.isNotEmpty && _name.text.trim().isNotEmpty
                        ? _continue
                        : null,
                    child: Text(l.continueReview),
                  ),
                const SizedBox(height: 12),
              ],
              if (!supported) Text(l.scanUnavailable),
              if (_failed)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Text(l.scanFailed),
                ),
              if (_busy)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Text(l.readingLabel)),
                    ],
                  ),
                )
              else if (supported) ...[
                FilledButton.icon(
                  onPressed: () => _pick(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: Text(l.takePhoto),
                ),
                TextButton.icon(
                  onPressed: () => _pick(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: Text(l.choosePhoto),
                ),
              ],
              OutlinedButton(
                onPressed: _busy ? null : _manual,
                child: Text(l.enterManually),
              ),
              const SizedBox(height: 18),
              Text(
                l.localScanNote,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openPhoto() {
    if (_file == null) {
      return;
    }
    showDialog<void>(
      context: context,
      builder: (c) => Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            title: Text(c.l10n.labelPhoto),
            leading: IconButton(
              tooltip: c.l10n.close,
              onPressed: () => Navigator.pop(c),
              icon: const Icon(Icons.close),
            ),
          ),
          body: SafeArea(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 5,
              child: Center(child: Image.file(_file!, fit: BoxFit.contain)),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pick(ImageSource source) async {
    setState(() {
      _busy = true;
      _failed = false;
    });
    String? picked;
    try {
      picked = await _photos.pickAndStore(source);
      if (picked == null) {
        return;
      }
      final file = await _photos.resolve(picked);
      if (file == null) {
        throw StateError('Photo missing');
      }
      final lines = await ref.read(labelScanServiceProvider).read(file.path);
      if (!mounted) {
        await _photos.delete(picked);
        return;
      }
      await _photos.delete(_relative);
      if (!mounted) {
        await _photos.delete(picked);
        return;
      }
      setState(() {
        _relative = picked;
        _file = file;
        _lines = lines;
        _candidates = LabelParser().parse(lines, _type);
        _confirmed.clear();
      });
    } catch (_) {
      if (picked != null && picked != _relative) {
        await _photos.delete(picked);
      }
      if (mounted) {
        setState(() => _failed = true);
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _manual() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const DetergentBasicsPage()),
    );
    if (result == true && mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<void> _continue() async {
    final values = [for (final i in _confirmed) _candidates[i]];
    final hasLoads = values.any((x) => x.load != null);
    final d = DetergentDraft.newDraft()..setType(_type);
    d.name = _name.text.trim();
    d.photoRelativePath = _relative;
    d.doseBasis = hasLoads ? DoseBasis.loadSize : DoseBasis.standard;
    d.includeXl = values.any((x) => x.load == LoadLevel.xl);
    d.preferredDisplayUnit = values.first.unit;
    for (final value in values) {
      if (hasLoads && value.load == null) {
        continue;
      }
      d.baseValues[DetergentDraft.baseKey(value.load)] = value.canonical;
    }
    final result = await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute(builder: (_) => DoseSetupPage(draft: d)));
    if (result == true && mounted) {
      _saved = true;
      Navigator.pop(context, true);
    }
  }
}
