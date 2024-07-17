import 'package:flutter/material.dart';
import 'package:magic_hat/utils/constants.dart';

class HouseGrid extends StatelessWidget {
  const HouseGrid({
    super.key,
    required this.onTap,
  });

  final void Function(String?) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 6.0,
          mainAxisSpacing: 6.0,
          shrinkWrap: true,
          childAspectRatio: 2.5 / 1,
          children: [
            HouseItem(
              icon: AppImages.gryffindor,
              title: 'Gryffindor',
              onTap: onTap,
            ),
            HouseItem(
              icon: AppImages.slytherin,
              title: 'Slytherin',
              onTap: onTap,
            ),
            HouseItem(
              icon: AppImages.ravenclaw,
              title: 'Ravenclaw',
              onTap: onTap,
            ),
            HouseItem(
              icon: AppImages.hufflepuff,
              title: 'Hufflepuff',
              onTap: onTap,
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: HouseItem(
                icon: '',
                title: 'Not in House',
                onTap: (_) => onTap(null),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HouseItem extends StatelessWidget {
  const HouseItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String title;
  final String icon;
  final void Function(String?) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(title);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon.isNotEmpty) Image.asset(icon, height: 35),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
