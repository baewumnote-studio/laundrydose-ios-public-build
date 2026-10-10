import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../app/providers.dart';
import '../../core/domain/models.dart';
import '../../core/localization/l10n.dart';
import '../../core/localization/labels.dart';
import '../../widgets/app_scaffold_body.dart';
import '../../widgets/laundry_art.dart';
import '../../widgets/state_views.dart';
import 'detergent_actions.dart';
import 'editor/detergent_basics_page.dart';

class DetergentsPage extends ConsumerWidget {
  const DetergentsPage({super.key, this.onUse});
  final VoidCallback? onUse;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final async = ref.watch(profilesProvider);
    return SafeArea(
      child: AppScaffoldBody(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 22, bottom: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l.yourShelf,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        IconButton.filledTonal(
                          tooltip: l.addDetergent,
                          onPressed: () => showAddDetergent(context),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(l.shelfSubtitle),
                  ],
                ),
              ),
            ),
            async.when(
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator.adaptive()),
              ),
              error: (_, _) => SliverToBoxAdapter(
                child: AppErrorCard(
                  title: l.errorGenericTitle,
                  body: l.errorGenericBody,
                  retryLabel: l.retry,
                  onRetry: () => ref.invalidate(profilesProvider),
                ),
              ),
              data: (profiles) => profiles.isEmpty
                  ? const SliverToBoxAdapter(child: AddDetergentPanel())
                  : SliverList.list(
                      children: [
                        for (final profile in profiles)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _ProfileCard(profile: profile, onUse: onUse),
                          ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () => showAddDetergent(context),
                          icon: const Icon(Icons.add),
                          label: Text(l.addDetergent),
                        ),
                      ],
                    ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends ConsumerWidget {
  const _ProfileCard({required this.profile, this.onUse});
  final DetergentProfileModel profile;
  final VoidCallback? onUse;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 12, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BottleMark(size: 58, type: profile.detergentType),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        [
                          detergentTypeLabel(context, profile.detergentType),
                          if (profile.brand?.isNotEmpty == true) profile.brand!,
                        ].join(' · '),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (v) => _menu(context, ref, v),
                  itemBuilder: (c) => [
                    PopupMenuItem(value: 'edit', child: Text(l.edit)),
                    if (!profile.isDefault)
                      PopupMenuItem(
                        value: 'default',
                        child: Text(l.setAsDefault),
                      ),
                    PopupMenuItem(value: 'duplicate', child: Text(l.duplicate)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    profile.isDefault
                        ? l.defaultBadge
                        : machineLabel(context, profile.machineVariant),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: TextButton.icon(
                    onPressed: () async {
                      await ref
                          .read(settingsRepositoryProvider)
                          .update(selectedDetergentId: profile.id);
                      if (context.mounted) {
                        onUse?.call();
                      }
                    },
                    icon: const Icon(Icons.arrow_forward, size: 18),
                    label: Text(l.useForWash),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _edit(BuildContext context, WidgetRef ref) async {
    final b = await ref.read(detergentRepositoryProvider).getBundle(profile.id);
    if (b != null && context.mounted) {
      await Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => DetergentBasicsPage(bundle: b)));
    }
  }

  Future<void> _menu(BuildContext context, WidgetRef ref, String value) async {
    if (value == 'edit') {
      await _edit(context, ref);
      return;
    }
    if (value == 'default') {
      await ref.read(detergentRepositoryProvider).setDefault(profile.id);
      await ref
          .read(settingsRepositoryProvider)
          .update(selectedDetergentId: profile.id);
      return;
    }
    if (value == 'duplicate') {
      final repo = ref.read(detergentRepositoryProvider);
      final b = await repo.getBundle(profile.id);
      if (b == null) return;
      String? photo;
      try {
        photo = await ref
            .read(photoServiceProvider)
            .duplicate(b.profile.photoRelativePath);
      } catch (_) {
        photo = null;
      }
      final id = const Uuid().v4();
      try {
        await repo.duplicateProfile(
          profile.id,
          newId: id,
          newName: '${profile.name} 2',
          newPhotoRelativePath: photo,
        );
      } catch (_) {
        if (photo != null) await ref.read(photoServiceProvider).delete(photo);
        rethrow;
      }
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.setupComplete)));
      }
    }
  }
}
