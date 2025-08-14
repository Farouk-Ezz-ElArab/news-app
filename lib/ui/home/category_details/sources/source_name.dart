import 'package:flutter/material.dart';
import 'package:news_app/model/SourceResponse.dart';

class SourceName extends StatelessWidget {
  Source source;
  bool isSelected;

  SourceName({super.key, required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Text(
      source.name ?? '',
      style: isSelected
          ? Theme.of(context).textTheme.labelLarge
          : Theme.of(context).textTheme.labelMedium,
    );
  }
}
