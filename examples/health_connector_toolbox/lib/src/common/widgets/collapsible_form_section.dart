import 'package:flutter/material.dart';

/// A collapsible section widget for grouping related form fields.
///
/// Provides a title header that can be tapped to expand/collapse the
/// content.
/// Useful for reducing cognitive load in long forms by hiding
/// less-critical fields.
@immutable
final class CollapsibleFormSection extends StatefulWidget {
  const CollapsibleFormSection({
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    this.subtitle,
    super.key,
  });

  /// The title displayed in the section header.
  final String title;

  /// Optional subtitle for additional context.
  final String? subtitle;

  /// The form fields contained in this section.
  final List<Widget> children;

  /// Whether the section starts expanded. Defaults to false.
  final bool initiallyExpanded;

  @override
  State<CollapsibleFormSection> createState() => _CollapsibleFormSectionState();
}

class _CollapsibleFormSectionState extends State<CollapsibleFormSection> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: _isExpanded ? 2 : 1,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _isExpanded
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        if (widget.subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.subtitle!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.expand_more,
                      color: _isExpanded
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: widget.children,
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
