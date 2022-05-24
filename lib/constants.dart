import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(255, 104, 97, 1);
const kSecondaryColor = Color.fromRGBO(47, 46, 65, 1);
const kThirdColor = Color.fromRGBO(255, 255, 255, 1);

const kPrimaryGradient = LinearGradient(
  colors: [Color.fromRGBO(174, 125, 70, 1), Color.fromRGBO(140, 0, 255, 1)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

bool warnaListNews(String data1, String data2) {
  if (data1 == data2) {
    return true;
  }
  return false;
}

var listNews = [
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

List<String> listSource = [
    "antara",
    "cnbc",
    "cnn",
    "jpnn",
    "kumparan",
    "merdeka",
    "okezone",
    "republika",
    "sindonews",
    "suara",
    "tempo",
    "tribun",
  ];