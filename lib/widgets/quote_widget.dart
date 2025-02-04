import 'package:flutter/material.dart';

import '../core/utils/text_styles.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({
    super.key,
    required this.joke,
  });

  final String joke;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"',
              style: TextStyles.titleText,
            ),
            Expanded(
              child: Text(joke, style: TextStyles.bodyText),
            ),
          ],
        ),
      ),
    );
  }
}
