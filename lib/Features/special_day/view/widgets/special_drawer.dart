import 'package:flutter/material.dart';
import 'package:sv_craft/constant/color.dart';

Widget buildDrawer() {
  return Drawer(
    backgroundColor: Colors.white,
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Appcolor.primaryColor,
          ),
          child: Row(
            children: const [
              Text(
                'Header',
                style: TextStyle(fontSize: 30, color: Appcolor.uperTextColor),
              )
            ],
          ),
        ),
        ListTile(
          leading: Text(
            'PRODUCTS'.toUpperCase(),
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
          trailing: const Icon(
            Icons.add,
            size: 20,
          ),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Text(
            'FLOWERS'.toUpperCase(),
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          trailing: const Icon(
            Icons.add,
            size: 20,
          ),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Text(
            'GIFTS'.toUpperCase(),
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
          trailing: const Icon(
            Icons.add,
            size: 20,
          ),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Text(
            'OCCATIONS'.toUpperCase(),
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          trailing: const Icon(
            Icons.add,
            size: 20,
          ),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Text(
            'SPECIAL OCCATIONS'.toUpperCase(),
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          trailing: const Icon(
            Icons.add,
            size: 20,
          ),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.phone,
            size: 20,
          ),
          title: const Text(
            'Call Us',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.contact_phone,
            size: 20,
          ),
          title: const Text(
            'Contact',
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.star,
            size: 20,
          ),
          title: const Text(
            'Rate App',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.share,
            size: 20,
          ),
          title: const Text(
            'Share App',
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
