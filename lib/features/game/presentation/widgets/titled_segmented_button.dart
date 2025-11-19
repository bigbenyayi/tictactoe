import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SegmentData<T> {
  const SegmentData({required this.value, required this.label, required this.icon});

  final T value;
  final String label;
  final IconData icon;
}

class TitledSegmentedButton<T extends Object> extends StatelessWidget {
  const TitledSegmentedButton({
    super.key,
    required this.title,
    required this.onSelectionChanged,
    required this.selected,
    required this.segments,
  });

  final String title;
  final void Function(T) onSelectionChanged;
  final T selected;
  final List<SegmentData<T>> segments;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: .stretch,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          SegmentedButton<T>(
            segments: segments
                .map(
                  (SegmentData<T> segment) => ButtonSegment<T>(
                    value: segment.value,
                    icon: selected == segment.value ? FaIcon(segment.icon) : null,
                    label: Text(
                      segment.label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: selected == segment.value ? Colors.white : Colors.black,
                        fontWeight: selected == segment.value ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                )
                .toList(),
            selected: <T>{selected},
            onSelectionChanged: (Set<T> newSelection) {
              if (newSelection.isNotEmpty) {
                onSelectionChanged(newSelection.first);
              }
            },
            style: SegmentedButton.styleFrom(
              fixedSize: const Size.fromHeight(48),
              side: BorderSide.none,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              shape: RoundedRectangleBorder(borderRadius: .circular(15.0)),
            ),
            showSelectedIcon: false,
          ),
        ],
      ),
    );
  }
}
