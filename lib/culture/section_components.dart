import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white)),
          ],
        ));
  }
}

class SectionTile extends StatelessWidget {
  const SectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
