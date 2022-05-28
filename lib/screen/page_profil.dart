import 'package:flutter/material.dart';
import 'package:news_info/constants.dart';
import 'package:news_info/screen/page_bookmark.dart';
import 'package:news_info/screen/page_home.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final int _selectedIndex = 2;

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
      body: const Center(
        child: Text("Profile"),
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
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const Bookmark(
                              kataKunci: 'aa',
                            )),
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
              icon: const Icon(Icons.person_outlined),
              highlightColor: Colors.white,
              onPressed: () {},
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
