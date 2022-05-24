import 'package:flutter/material.dart';
import 'package:news_info/screen/onbording_screnn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api.dart';
import '../api/json_to_dart.dart';
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
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: ClipOval(
              child: Material(
                color: kPrimaryColor, // Button color
                child: InkWell(
                  splashColor: kPrimaryColor.withOpacity(0.4), // Splash color
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHomePage', false);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const OnBordingScreen()));
                  },
                  child: const SizedBox(
                      width: 40, height: 56, child: Icon(Icons.logout)),
                ),
              ),
            ),
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
