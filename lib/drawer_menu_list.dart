import 'package:flutter/material.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/categories/categories.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/dashboard.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/logout.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/orders/orders.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/products/products.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/reviews.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/users/users.dart';

List<Map<dynamic, dynamic>> drawerMenus = [
  {
    "title": "Dashboard",
    "body": Dashboard(),
    "icon": Icon(Icons.dashboard),
  },
  {
    "title": "Products",
    "body": Products(),
    "icon": Icon(Icons.shopping_bag),
  },
  {
    "title": "Categories",
    "body": Categories(),
    "icon": Icon(Icons.category),
  },
  {
    "title": "Orders",
    "body": Orders(),
    "icon": Icon(Icons.notification_important),
  },
  {
    "title": "Users",
    "body": Users(),
    "icon": Icon(Icons.people),
  },
  {
    "title": "Reviews",
    "body": Reviews(),
    "icon": Icon(Icons.comment),
  },
  {
    "title": "Logout",
    "body": Logout(),
    "icon": Icon(Icons.logout),
  }
];
