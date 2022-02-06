import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class InfoCard extends StatelessWidget {
  final Widget info;
  final String title;
  final Function()? onPressed;

  const InfoCard({
    Key? key,
    required this.info,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                info,
                const SizedBox(height: 6),
                Text(
                  title,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            const Icon(Ionicons.chevron_forward),
          ],
        ),
      ),
    );
  }
}
