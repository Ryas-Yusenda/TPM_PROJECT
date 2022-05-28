import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_info/constants.dart';
import 'package:news_info/screen/page_home.dart';
import 'package:news_info/services/page_profil_cek.dart';

class BookmarkIn extends StatelessWidget {
  final int _selectedIndex = 1;

  final controller = TextEditingController();

  BookmarkIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: kPrimaryColor),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: bottomNavMain(context),
    );
  }

  BottomNavigationBar bottomNavMain(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: IconButton(
                icon: const Icon(Icons.home_outlined),
                iconSize: 30,
                highlightColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
            ),
            label: '',
            backgroundColor: kSecondaryColor),
        BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: IconButton(
                icon: const Icon(Icons.bookmark_add_outlined),
                highlightColor: Colors.white,
                onPressed: () {},
                iconSize: 30,
              ),
            ),
            label: '',
            backgroundColor: kSecondaryColor),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: IconButton(
              icon: const Icon(Icons.person_outlined),
              iconSize: 30,
              highlightColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const HomePageLogin()),
                );
              },
            ),
          ),
          label: '',
          backgroundColor: kSecondaryColor,
        ),
      ],
      type: BottomNavigationBarType.fixed,
      backgroundColor: kPrimaryColor,
      currentIndex: _selectedIndex,
      selectedItemColor: kWhite,
      unselectedItemColor: kSecondaryColor,
    );
  }

  
}