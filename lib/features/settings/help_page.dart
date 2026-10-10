import 'package:flutter/material.dart';

import '../../core/localization/l10n.dart';
import '../../widgets/app_scaffold_body.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final rows = [
      (l.scanLabel, '${l.localScanNote}\n\n${l.scanReviewBody}'),
      (l.helpLabelFirstTitle, l.helpLabelFirstBody),
      (l.helpLoadTitle, l.helpLoadBody),
      (l.helpHardnessTitle, l.helpHardnessBody),
      (l.helpMachineTitle, l.helpMachineBody),
      (l.helpPodsTitle, l.helpPodsBody),
      (l.helpMarkersTitle, l.helpMarkersBody),
      (l.helpCostTitle, l.helpCostBody),
      (l.helpOfflineTitle, l.helpOfflineBody),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l.helpTitle)),
      body: SafeArea(
        child: AppScaffoldBody(
          child: ListView(
            padding: const EdgeInsets.only(top: 8, bottom: 28),
            children: [
              for (final row in rows)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            row.$1,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(row.$2),
                        ],
                      ),
                    ),
                  ),
                ),
              Text(l.disclaimer, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
