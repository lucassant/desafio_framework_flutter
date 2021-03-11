import 'package:desafio_flutter/app_controller.dart';
import 'package:desafio_flutter/main.dart';
import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageViewController = getIt<AppController>().pageViewController;

    return AnimatedBuilder(
        animation: pageViewController,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            onTap: (index) {
              pageViewController.jumpToPage(index);
            },
            currentIndex: pageViewController?.page?.round() ?? 0,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.album), label: "Albums"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.post_add), label: "Posts"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "To-Dos"),
            ],
            type: BottomNavigationBarType.fixed,
          );
        });
  }
}
