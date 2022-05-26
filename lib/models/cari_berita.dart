class CountriesModel {
  List<Countries>? countries;
  CountriesModel({this.countries});
  CountriesModel.fromJson(Map<String, dynamic> json) {
    if (json['post'] != null) {
      countries = <Countries>[];
      json['post'].forEach((v) {
        countries!.add(Countries.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (countries != null) {
      data['post'] = countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  String? judul;
  String? link;
  String? poster;
  String? tipe;
  Countries({this.judul, this.link, this.poster, this.tipe});
  Countries.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    link = json['link'];
    poster = json['poster'];
    tipe = json['tipe'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['judul'] = judul;
    data['link'] = link;
    data['poster'] = poster;
    data['tipe'] = tipe;
    return data;
  }
}
