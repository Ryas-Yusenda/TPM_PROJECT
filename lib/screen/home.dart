// ignore_for_file: unused_element, unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:news_info/models/cari_berita.dart';
import 'package:news_info/screen/all_news.dart';
import 'package:news_info/screen/onbording_screnn.dart';
import 'package:news_info/screen/seach.dart';
import 'package:news_info/screen/web_view.dart';
import 'package:news_info/services/api_seach.dart';
import 'package:news_info/services/string_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_info/constants.dart';
import 'package:news_info/services/api.dart';
import 'package:news_info/models/news_get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var statuslistnews = 'terbaru';
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: kPrimaryColor),
            onPressed: () => setState(() {
              statuslistnews = statuslistnews;
            }),
          )
        ],
      ),
      body: _main(),
      // body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Icon(
                  Icons.home_outlined,
                  size: 28,
                ),
              ),
              label: '',
              backgroundColor: kSecondaryColor),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Icon(
                  Icons.bookmark_add_outlined,
                  size: 28,
                ),
              ),
              label: '',
              backgroundColor: kSecondaryColor),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Icon(
                Icons.person_outlined,
                size: 28,
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
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _main() {
    if (statuslistnews == 'terbaru') {
      return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _cariLihatsemua(),
            _listTemaBuild(),
            _listBeritaBuilds(statuslistnews.toLowerCase()),
          ]);
    } else {
      return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _cariLihatsemua(),
            _listTemaBuild(),
            _listBeritaBuild(statuslistnews.toLowerCase()),
          ]);
    }
  }

  Widget _cariLihatsemua() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const _CariForm(),
        Expanded(
            child: Align(
          alignment: const AlignmentDirectional(1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AllNews()),
                );
                print('//TODO: Tambah Menu Untuk Melihat Semua');
              },
              style: TextButton.styleFrom(
                primary: kPrimaryColor,
              ),
              child: const Text(
                'Semua',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: kPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _listTemaBuild() {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            for (var item in listNews) _listTemaBuildBerita(item),
          ],
        ),
      ),
    );
  }

  Widget _listTemaBuildBerita(String name) {
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
          },
          child: Text(
            name.capitalize(),
            style: TextStyle(
              fontFamily: 'Poppins',
              color: warnaListNews(statuslistnews, name)
                  ? Colors.white
                  : kPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: warnaListNews(statuslistnews, name)
                ? kPrimaryColor
                : Colors.white,
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

  Widget _listBeritaBuild(String namaBerita) {
    return Expanded(
      child: FutureBuilder(
        future: NewsDataSource.instance.loadNews(namaBerita),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.hasData) {
            BeritaPost countriesModel = BeritaPost.fromJson(snapshot.data);
            return _listBeritaBuildSuccess(countriesModel, namaBerita);
          }
          return _listBeritaBuildLoading();
        },
      ),
    );
  }

  Widget _listBeritaBuildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _listBeritaBuildSuccess(BeritaPost data, String nama) {
    return ListView.builder(
      itemCount: data.data.posts.length,
      itemBuilder: (BuildContext context, int index) {
        return _listBeritaBuildSuccessDetail(
          data.data.posts[index].thumbnail,
          data.data.posts[index].title,
          data.data.posts[index].description,
          data.data.posts[index].link,
          nama,
        );
      },
    );
  }

  Widget _listBeritaBuildSuccessDetail(
      String image, String title, String detail, String link, String nama) {
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
              width: 100,
              height: 100,
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
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => WebViewModul(links: link)),
                  );
                }, // Respon ketika button ditekan
                child: Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 20),
                  width: 200,
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
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.white, spreadRadius: 1),
                        ],
                      ),
                      child: Image.network(
                        listThumbnail[2],
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Text(
                        listSource[2],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: kSecondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: SizedBox(
                        height: 25.0,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              statuslistnews = nama;
                            });
                          },
                          child: Text(
                            nama.capitalize(),
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listBeritaBuilds(String namaBerita) {
    return Expanded(
      child: FutureBuilder(
        future: CovidDataSource.instance.loadCountries(),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.hasData) {
            CountriesModel countriesModel =
                CountriesModel.fromJson(snapshot.data);
            return _listBeritaBuildSuccesss(countriesModel);
          }
          return _listBeritaBuildLoading();
        },
      ),
    );
  }

  Widget _listBeritaBuildSuccesss(CountriesModel data) {
    return ListView.builder(
      itemCount: data.countries.length,
      itemBuilder: (BuildContext context, int index) {
        return _listBeritaBuildSuccessDetails(
          context,
          data.countries[index].judul,
          data.countries[index].link,
          data.countries[index].poster,
          data.countries[index].tipe,
        );
      },
    );
  }

  Widget _listBeritaBuildSuccessDetails(BuildContext context, String title,
      String link, String image, String tipe) {
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
              width: 100,
              height: 100,
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
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => WebViewModul(links: link)),
                  );
                }, // Respon ketika button ditekan
                child: Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 20),
                  width: 200,
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
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.white, spreadRadius: 1),
                        ],
                      ),
                      child: Image.network(
                        listThumbnail[2],
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Text(
                        listSource[2],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: kSecondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: SizedBox(
                        height: 25.0,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              statuslistnews = tipe;
                            });
                          },
                          child: Text(
                            tipe.capitalize(),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

@immutable
class _CariForm extends StatelessWidget {
  const _CariForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String kata = "";

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
      child: SizedBox(
        height: 30.0,
        width: 320.0,
        child: TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            icon: IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 20,
                  color: kPrimaryColor,
                ),
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Seacher(
                          kataKunci: kata,
                        );
                      })),
                    }),
            hintText: 'Cari',
            contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
          ),
          onSaved: (String? value) {},
          onChanged: (value) {
            kata = value;
          },
        ),
      ),
    );
  }
}
