import 'package:flutter/material.dart';

import '../Text/primary_text.dart';

class PrimaryBigAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? bottomContent;

  const PrimaryBigAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.bottomContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,  // tránh đè giờ/pin
        left: 16,
        right: 16,
        bottom: 10,
      ),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              leading ?? const SizedBox(),
              const SizedBox(width: 8),
              Expanded(
                child: PrimaryText(
                  title,
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,

                ),
              ),
              ...?actions,
            ],
          ),
          if (bottomContent != null) ...[
            bottomContent!,
          ]
        ],
      ),
    );
  }
}
