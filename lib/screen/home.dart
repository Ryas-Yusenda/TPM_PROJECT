// ignore_for_file: unused_element, unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:news_info/screen/onbording_screnn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_info/constants.dart';
import 'package:news_info/services/api.dart';
import 'package:news_info/models/news_get.dart';
import 'package:news_info/screen/bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listNews = [
    "Terbaru",
    "Politik",
    "Hukum",
    "Ekonomi",
    "Bola",
    "Olahraga",
    "Humaniora",
    "Lifestyle",
    "Hiburan",
    "Dunia",
    "Tekno",
    "Otomotif",
  ];
  var statuslistnews = 'Terbaru';

  bool warnaListNews(String data) {
    if (statuslistnews == data) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Berita',
            style: TextStyle(
                color: kSecondaryColor,
                fontSize: 28.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: kPrimaryColor),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHomePage', false);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const OnBordingScreen()));
              },
            )
          ],
        ),
        // body: _buildDetailCountriesBody(4),
        body: _temaNews(),
        bottomSheet: const BottomSheetMain());
  }

  Widget _temaNews() {
    return SafeArea(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Align(
                  alignment: const AlignmentDirectional(1, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                    child: TextButton(
                      onPressed: () {
                        print('TODO:');
                      },
                      style: TextButton.styleFrom(
                        primary: kPrimaryColor,
                      ),
                      child: const Text(
                        'Lihat Semua',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ))
              ],
            ),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    for (var item in listNews) _listTemaBerita(item),
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  Widget _buildDetailCountriesBody(int nomorBerita) {
    return FutureBuilder(
      future: CovidDataSource.instance
          .loadCountries(listNews[nomorBerita].toLowerCase()),
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snapshot,
      ) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          BeritaPost countriesModel = BeritaPost.fromJson(snapshot.data);
          return _buildSuccessSection(countriesModel, nomorBerita);
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _listTemaBerita(String name) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 12),
      child: SizedBox(
        width: 130.0,
        height: 32.0,
        child: ElevatedButton(
          autofocus: true,
          onPressed: () {
            setState(() {
              statuslistnews = name;
            });

            print('TODO:' + name);
          },
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: warnaListNews(name) ? Colors.white : kPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: warnaListNews(name) ? kPrimaryColor : Colors.white,
            shadowColor: kSecondaryColor,
            side: const BorderSide(
              color: kPrimaryColor,
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorSection() {
    return const Text("Error");
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(BeritaPost data, int nomor) {
    return ListView.builder(
      itemCount: data.data.posts.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          background: Container(
            color: kPrimaryColor,
          ),
          key: UniqueKey(),
          child: _newsInfo(
            data.data.posts[index].thumbnail,
            data.data.posts[index].title,
            data.data.posts[index].description,
            nomor,
          ),
        );
      },
    );
  }

  Widget _newsInfo(String image, String title, String detail, int nomorBerita) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 10, 10),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(12),
              topRight: Radius.circular(0),
            ),
            child: Image.network(
              image,
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 15, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 35),
                width: 230,
                child: Column(
                  children: <Widget>[
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: kSecondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/f/fb/Cnn_logo_red_background.png',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Text(
                      'CNN',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: kSecondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: SizedBox(
                      height: 25.0,
                      child: ElevatedButton(
                        onPressed: () {
                          print('TODO:');
                        },
                        child: Text(
                          listNews[nomorBerita],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shadowColor: kSecondaryColor,
                          side: const BorderSide(
                            color: kPrimaryColor,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

