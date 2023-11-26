import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),],
        currentIndex: 0,
        selectedItemColor: Colors.green,
        onTap: (index) => onTap(context, index)
    );
  }

  void onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/new_post');
        break;
      case 1:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }
}
