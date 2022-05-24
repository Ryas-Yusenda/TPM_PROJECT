import 'package:flutter/material.dart';
import 'package:news_info/screen/onbording_screnn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_info/constants.dart';
import 'package:news_info/services/api.dart';
import 'package:news_info/models/newsGet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listNews = [
    "terbaru",
    "politik",
    "hukum",
    "ekonomi",
    "bola",
    "olahraga",
    "humaniora",
    "lifestyle",
    "hiburan",
    "dunia",
    "tekno",
    "otomotif",
  ];

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
      body: _buildDetailCountriesBody(),
    );
  }

  Widget _buildDetailCountriesBody() {
    return FutureBuilder(
      future: CovidDataSource.instance.loadCountries(listNews[0]),
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snapshot,
      ) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          BeritaPost countriesModel = BeritaPost.fromJson(snapshot.data);
          return _buildSuccessSection(countriesModel);
        }
        return _buildLoadingSection();
      },
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

  Widget _buildSuccessSection(BeritaPost data) {
    return ListView.builder(
      // itemCount: data.countries?.length,
      // itemCount: data.data.posts?.length,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          background: Container(
            color: kPrimaryColor,
          ),
          key: UniqueKey(),
          onDismissed: (direction) {},
          child: ListTile(
            title: Text(data.data.posts[index].title),
            subtitle: Text(data.data.posts[index].description),
          ),
        );
      },
    );
  }
}
