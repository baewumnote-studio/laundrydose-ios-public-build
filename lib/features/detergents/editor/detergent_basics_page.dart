import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/providers.dart';
import '../../../app/theme/design_tokens.dart';
import '../../../core/domain/detergent_draft.dart';
import '../../../core/domain/enums.dart';
import '../../../core/domain/models.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/localization/labels.dart';
import '../../../core/units/unit_preferences.dart';
import '../../../widgets/app_scaffold_body.dart';
import 'dose_setup_page.dart';

class DetergentBasicsPage extends ConsumerStatefulWidget {
  const DetergentBasicsPage({super.key, this.bundle});
  final DetergentBundle? bundle;
  @override
  ConsumerState<DetergentBasicsPage> createState() => _State();
}

class _State extends ConsumerState<DetergentBasicsPage> {
  late final DetergentDraft draft;
  late final TextEditingController nameController;
  late final TextEditingController brandController;
  late String _initialSignature;
  final Set<String> _temporaryPhotoPaths = {};
  UnitSystemChoice _newUnitSystem = UnitSystemChoice.metric;
  bool _saved = false,
      _busy = false,
      _allowPop = false,
      _discardDialogOpen = false;

  @override
  void initState() {
    super.initState();
    draft = widget.bundle == null
        ? DetergentDraft.newDraft()
        : DetergentDraft.fromBundle(widget.bundle!);
    nameController = TextEditingController(text: draft.name);
    brandController = TextEditingController(text: draft.brand);
    _initialSignature = draft.changeSignature;
    if (widget.bundle == null) Future.microtask(_loadUnitPreference);
  }

  @override
  void dispose() {
    nameController.dispose();
    brandController.dispose();
    if (!_saved) {
      for (final path in _temporaryPhotoPaths) {
        ref.read(photoServiceProvider).delete(path);
      }
    }
    super.dispose();
  }

  Future<void> _loadUnitPreference() async {
    final settings = await ref.read(settingsRepositoryProvider).get();
    if (!mounted || widget.bundle != null) return;
    final before = draft.changeSignature;
    _newUnitSystem = settings.unitSystem;
    setState(() => _applyPreferredUnit(draft.type));
    if (_initialSignature == before) _initialSignature = draft.changeSignature;
  }

  void _applyPreferredUnit(DetergentType type) {
    draft.preferredDisplayUnit = preferredDisplayUnitForNewProfile(
      type: type,
      unitSystem: _newUnitSystem,
      countryCode:
          WidgetsBinding.instance.platformDispatcher.locale.countryCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final dirty = draft.changeSignature != _initialSignature;
    return PopScope<Object?>(
      canPop: _saved || _allowPop || !dirty,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmDiscard();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.bundle == null ? l.addDetergentTitle : l.editDetergentTitle,
          ),
        ),
        body: SafeArea(
          child: AppScaffoldBody(
            child: ListView(
              padding: const EdgeInsets.only(top: 12, bottom: 24),
              children: [
                TextField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  maxLength: 60,
                  decoration: InputDecoration(
                    labelText: l.name,
                    hintText: l.detergentNamePlaceholder,
                  ),
                  onChanged: (v) => draft.name = v,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: brandController,
                  textCapitalization: TextCapitalization.words,
                  maxLength: 60,
                  decoration: InputDecoration(
                    labelText: l.brandOptional,
                    hintText: l.brandPlaceholder,
                  ),
                  onChanged: (v) => draft.brand = v,
                ),
                const SizedBox(height: AppMetrics.sectionGap),
                Text(l.type, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
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
                    selected: {draft.type},
                    showSelectedIcon: false,
                    onSelectionChanged: (s) {
                      if (s.isEmpty || s.first == draft.type) return;
                      setState(() {
                        draft.setType(s.first);
                        _applyPreferredUnit(s.first);
                      });
                    },
                  ),
                ),
                const SizedBox(height: AppMetrics.sectionGap),
                Text(
                  l.labelPhoto,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                _photoCard(),
                const SizedBox(height: 8),
                Text(
                  l.photoStoredLocally,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppMetrics.sectionGap),
                FilledButton(
                  onPressed: _busy ? null : _next,
                  child: Text(l.continueLabel),
                ),
                if (widget.bundle != null) ...[
                  const SizedBox(height: 12),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: _busy ? null : _delete,
                    icon: const Icon(Icons.delete_outline),
                    label: Text(l.deleteDetergentConfirm),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDiscard() async {
    if (_allowPop || _saved || _discardDialogOpen) return;
    _discardDialogOpen = true;
    final l = context.l10n;
    final discard =
        await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: Text(l.unsavedChangesTitle),
            content: Text(l.unsavedChangesBody),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c, false),
                child: Text(l.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(c, true),
                child: Text(l.discard),
              ),
            ],
          ),
        ) ??
        false;
    _discardDialogOpen = false;
    if (!discard || !mounted) return;
    setState(() => _allowPop = true);
    Navigator.of(context).pop(false);
  }

  Widget _photoCard() {
    final l = context.l10n;
    final path = draft.photoRelativePath;
    if (path == null) {
      return OutlinedButton.icon(
        onPressed: _busy ? null : _choosePhoto,
        icon: const Icon(Icons.add_photo_alternate_outlined),
        label: Text(l.addPhoto),
      );
    }
    return FutureBuilder<File?>(
      future: ref.read(photoServiceProvider).resolve(path),
      builder: (c, s) => Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              if (s.connectionState == ConnectionState.waiting)
                const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator.adaptive()),
                )
              else if (s.data != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    s.data!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const SizedBox(
                      height: 120,
                      child: Center(
                        child: Icon(Icons.broken_image_outlined, size: 40),
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(
                  height: 120,
                  child: Center(
                    child: Icon(Icons.broken_image_outlined, size: 40),
                  ),
                ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _busy ? null : _choosePhoto,
                      child: Text(l.replacePhoto),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: l.removePhoto,
                    onPressed: _busy ? null : _removePhoto,
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _removePhoto() async {
    final previous = draft.photoRelativePath;
    setState(() => draft.photoRelativePath = null);
    if (previous != null && _temporaryPhotoPaths.remove(previous)) {
      await ref.read(photoServiceProvider).delete(previous);
    }
  }

  Future<void> _choosePhoto() async {
    final l = context.l10n;
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (c) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(l.camera),
              onTap: () => Navigator.pop(c, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l.photoLibrary),
              onTap: () => Navigator.pop(c, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null || !mounted) return;
    try {
      setState(() => _busy = true);
      final path = await ref.read(photoServiceProvider).pickAndStore(source);
      if (path == null || !mounted) return;
      final previous = draft.photoRelativePath;
      _temporaryPhotoPaths.add(path);
      if (previous != null && _temporaryPhotoPaths.remove(previous)) {
        await ref.read(photoServiceProvider).delete(previous);
      }
      if (mounted) setState(() => draft.photoRelativePath = path);
    } on PlatformException catch (error) {
      if (!mounted) return;
      if (error.code.contains('denied') || error.code.contains('access')) {
        await _showPhotoPermissionGuidance();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.errorPhotoTitle)));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.errorPhotoTitle)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _showPhotoPermissionGuidance() async {
    final l = context.l10n;
    final open =
        await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(l.photoPermissionTitle),
            content: Text(l.photoPermissionBody),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(l.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(l.openSettings),
              ),
            ],
          ),
        ) ??
        false;
    if (!mounted || !open) return;
    await launchUrl(
      Uri.parse('app-settings:'),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> _next() async {
    final l = context.l10n;
    draft.name = nameController.text;
    draft.brand = brandController.text;
    if (draft.name.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.validationRequired)));
      return;
    }
    if (draft.name.trim().runes.length > 60) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.validationNameTooLong)));
      return;
    }
    final ok = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => DoseSetupPage(draft: draft)),
    );
    if (ok == true && mounted) {
      _saved = true;
      Navigator.pop(context, true);
    }
  }

  Future<void> _delete() async {
    final l = context.l10n;
    final yes =
        await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: Text(l.deleteDetergentTitle),
            content: Text(l.deleteDetergentBody),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c, false),
                child: Text(l.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(c, true),
                child: Text(l.deleteDetergentConfirm),
              ),
            ],
          ),
        ) ??
        false;
    if (!yes || !mounted) return;
    setState(() => _busy = true);
    try {
      await ref.read(detergentRepositoryProvider).deleteProfile(draft.id);
      await ref
          .read(photoServiceProvider)
          .delete(draft.originalPhotoRelativePath);
      for (final path in _temporaryPhotoPaths) {
        await ref.read(photoServiceProvider).delete(path);
      }
      _temporaryPhotoPaths.clear();
      _saved = true;
      if (mounted) Navigator.pop(context, true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}
