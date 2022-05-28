import 'package:flutter/material.dart';
import 'package:news_info/constants.dart';
import 'package:news_info/screen/page_home.dart';
import 'package:news_info/screen/page_profil.dart';

class Bookmark extends StatelessWidget {
  final String kataKunci;
  final int _selectedIndex = 1;

  const Bookmark({Key? key, required this.kataKunci}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CNN',
          style: TextStyle(
              color: kSecondaryColor,
              fontSize: 28.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Text(kataKunci),
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
              ),
            ),
            label: '',
            backgroundColor: kSecondaryColor),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: IconButton(
              icon: const Icon(Icons.person_outlined),
              highlightColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
            ),
          ),
          label: '',
          backgroundColor: kSecondaryColor,
        ),
      ],
      type: BottomNavigationBarType.fixed,
      backgroundColor: kSecondaryColor,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: kPrimaryColor,
    );
  }
}