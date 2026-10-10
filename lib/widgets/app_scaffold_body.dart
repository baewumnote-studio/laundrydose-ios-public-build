import 'package:flutter/material.dart';
import '../app/theme/design_tokens.dart';

class AppScaffoldBody extends StatelessWidget {
  const AppScaffoldBody({super.key, required this.child, this.padding = true});
  final Widget child;
  final bool padding;
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppMetrics.maxContent),
      child: padding
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppMetrics.screen,
              ),
              child: child,
            )
          : child,
    ),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;
  @override
  Widget build(BuildContext c) => Row(
    children: [
      Expanded(child: Text(text, style: Theme.of(c).textTheme.titleMedium)),
      ?trailing,
    ],
  );
}
