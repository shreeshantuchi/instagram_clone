import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedIconColor;
  final Color unselectedLabelColor;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.selectedColor,
    this.unselectedIconColor = Colors.grey,
    this.unselectedLabelColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color:
                  currentIndex == index ? selectedColor : unselectedIconColor,
            ),
            Text(
              label,
              style: TextStyle(
                color: currentIndex == index
                    ? selectedColor
                    : unselectedLabelColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
