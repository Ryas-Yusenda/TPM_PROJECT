import 'package:flutter/material.dart';
import 'package:news_info/screen/onbording_screnn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/api.dart';
import '../models/json_to_dart.dart';
import 'package:news_info/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      future: CovidDataSource.instance.loadCountries(),
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snapshot,
      ) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          CountriesModel countriesModel =
              CountriesModel.fromJson(snapshot.data);
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

  Widget _buildSuccessSection(CountriesModel data) {
    return ListView.builder(
      itemCount: data.countries?.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemCountries("${data.countries?[index].name}");
      },
    );
  }

  Widget _buildItemCountries(String value) {
    return Text(value);
  }
}
