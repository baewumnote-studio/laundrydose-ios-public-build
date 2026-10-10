import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../app/providers.dart';
import '../../core/domain/models.dart';
import '../../core/localization/l10n.dart';
import '../../core/localization/labels.dart';
import '../../widgets/app_scaffold_body.dart';
import '../../widgets/state_views.dart';
import '../../widgets/laundry_art.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final async = ref.watch(historyProvider);
    return SafeArea(
      child: AppScaffoldBody(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 18, bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.historyTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(l.historySubtitle),
                    if (async.value?.isNotEmpty == true) ...[
                      const SizedBox(height: 22),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${async.value!.length}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineLarge,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(l.savedWashes),
                                  ],
                                ),
                              ),
                              const BottleMark(size: 58),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            async.when(
              loading: () => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator.adaptive()),
              ),
              error: (_, _) => SliverToBoxAdapter(
                child: AppErrorCard(
                  title: l.errorGenericTitle,
                  body: l.errorGenericBody,
                  retryLabel: l.retry,
                  onRetry: () => ref.invalidate(historyProvider),
                ),
              ),
              data: (logs) => logs.isEmpty
                  ? SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 48),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const LaundryArt(height: 200),
                              const SizedBox(height: 18),
                              Text(
                                l.historyEmptyTitle,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l.historyEmptyBody,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (c, i) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _LogCard(log: logs[i]),
                        ),
                        childCount: logs.length,
                      ),
                    ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _LogCard extends ConsumerWidget {
  const _LogCard({required this.log});
  final WashLogModel log;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final when = DateFormat.yMMMd(
      locale,
    ).add_jm().format(log.loggedAtUtc.toLocal());
    final parts = <String>[
      if (log.loadLevel != null) loadLabel(context, log.loadLevel!),
      if (log.soilLevel != null) soilLabel(context, log.soilLevel!),
      if (log.waterLevel != null) waterLabel(context, log.waterLevel!),
    ];
    return Card(
      child: ListTile(
        onTap: () => _detail(context, ref),
        leading: const Icon(Icons.check_circle_outline),
        title: Text(log.detergentNameSnapshot),
        subtitle: Text(
          [when, if (parts.isNotEmpty) parts.join(' · ')].join('\n'),
        ),
        isThreeLine: parts.isNotEmpty,
        trailing: Text(
          '${log.displayAmountSnapshot}\n${log.displayUnitSnapshot}',
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  Future<void> _detail(BuildContext context, WidgetRef ref) async {
    final l = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final date = DateFormat.yMMMMd(
      locale,
    ).add_jm().format(log.loggedAtUtc.toLocal());
    final cost = _cost(locale);
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (c) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                log.detergentNameSnapshot,
                style: Theme.of(c).textTheme.headlineSmall,
              ),
              const SizedBox(height: 6),
              Text(date),
              const SizedBox(height: 18),
              Text(
                '${log.displayAmountSnapshot} ${log.displayUnitSnapshot}',
                style: Theme.of(c).textTheme.headlineMedium,
              ),
              if (log.loadLevel != null)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.load),
                  trailing: Text(loadLabel(c, log.loadLevel!)),
                ),
              if (log.soilLevel != null)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.soil),
                  trailing: Text(soilLabel(c, log.soilLevel!)),
                ),
              if (log.waterLevel != null)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.water),
                  trailing: Text(waterLabel(c, log.waterLevel!)),
                ),
              if (cost != null)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.costThisWash),
                  trailing: Text(cost),
                ),
              const SizedBox(height: 8),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(c).colorScheme.error,
                ),
                onPressed: () async {
                  final yes =
                      await showDialog<bool>(
                        context: c,
                        builder: (d) => AlertDialog(
                          title: Text(l.deleteLogTitle),
                          content: Text(l.deleteLogBody),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(d, false),
                              child: Text(l.cancel),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(d, true),
                              child: Text(l.deleteLogConfirm),
                            ),
                          ],
                        ),
                      ) ??
                      false;
                  if (yes) {
                    await ref
                        .read(historyRepositoryProvider)
                        .deleteById(log.id);
                    if (c.mounted) Navigator.pop(c);
                  }
                },
                icon: const Icon(Icons.delete_outline),
                label: Text(l.deleteLogConfirm),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _cost(String locale) {
    if (log.costMinorUnits == null || log.currencyCode == null) return null;
    final f = NumberFormat.simpleCurrency(
      name: log.currencyCode,
      locale: locale,
    );
    final digits = f.decimalDigits ?? 2;
    var divisor = 1;
    for (var i = 0; i < digits; i++) {
      divisor *= 10;
    }
    return f.format(log.costMinorUnits! / divisor);
  }
}
