import 'package:flutter/material.dart';
import 'package:news_info/constants.dart';
import 'package:news_info/models/news_get.dart';
import 'package:news_info/services/api.dart';
import 'package:news_info/services/string_extension.dart';

class AllNews extends StatelessWidget {
  const AllNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 4,
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (var item in listNews)
                    _listBeritaBuild(item.toLowerCase()),
                ]),
          ),
        ],
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
          nama,
        );
      },
    );
  }

  Widget _listBeritaBuildSuccessDetail(
      String image, String title, String detail, String nama) {
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
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: kSecondaryColor, spreadRadius: 1),
                      ],
                    ),
                    child: Image.network(
                      fit: BoxFit.contain,
                      listThumbnail[2],
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
                        onPressed: () {},
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
            ],
          ),
        ),
      ],
    );
  }
}
