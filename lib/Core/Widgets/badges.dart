import 'package:badges/badges.dart' as badges;
import 'package:blog_app/Core/Theme/Palatte.dart';
import 'package:flutter/material.dart';
Widget badge()
{
  return badges.Badge(
    position: badges.BadgePosition.topEnd(top: -10, end: -12),
    showBadge: true,
    ignorePointer: false,
    onTap: () {},
    badgeContent:Text('1'),
    badgeStyle: badges.BadgeStyle(
      shape: badges.BadgeShape.circle,
      badgeColor: AppPallete.backgroundColor,
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Colors.white, width: 2),

      elevation: 0,
    ),
    child: const Icon(Icons.notifications, color: Colors.white, size: 20),
  );
}
