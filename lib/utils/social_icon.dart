import 'package:flutter/material.dart';
import '../utils/launcher_helper.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const SocialIcon({
    super.key,
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => LauncherHelper.openUrl(url),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Icon(
          icon,
          size: 32,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
