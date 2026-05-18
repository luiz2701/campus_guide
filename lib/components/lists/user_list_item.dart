import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final String name;
  final String image;

  const UserListItem({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Row(
        children: [
          CircleAvatar(radius: 34, backgroundImage: AssetImage(image)),

          const SizedBox(width: 18),

          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
