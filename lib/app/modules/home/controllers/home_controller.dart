import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:ISPUclassification/app/data/models/dataispu.dart';

class HomeController extends GetxController {
  static const String apiUrl = 'http://10.0.2.2:8000/api';
  DataIspu? dataIspu;
  Color? color;
  String? message;
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();

    isLoading(true);
    dataIspu = DataIspu.fromMap(await fetchData());
    updateColorAndKeterangan(dataIspu?.max ?? 1);
    isLoading(false);
  }

  Future<dynamic> fetchData() async {
    final response = await http.get(Uri.parse('$apiUrl/data-ispu/get'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  void updateColorAndKeterangan(int max) {
    if (max > 0 && max <= 50) {
      color = Color(0xFF33cc33);
      message =
          "Tingkat kualitas udara yang sangat baik, tidak memberikan efek negatif terhadap manusia, hewan, dan tumbuhan";
    } else if (max >= 51 && max <= 100) {
      color = Color(0xFF0070c0);
      message =
          "Tingkat kualitas udara yang masih dapat diterima pada kesehatan manusia, hewan, dan tumbuhan";
    } else if (max >= 101 && max <= 200) {
      color = Color(0xFFffc000);
      message =
          "Tingkat kualitas udara yang bersifat merugikan pada manusia, hewan, dan tumbuhan";
    } else if (max >= 201 && max <= 300) {
      color = Color(0xFFff0000);
      message =
          "Tingkat kualitas udara yang dapat meningkatkan resiko kesehatan pada sejumlah segmen populasi yang terpapar";
    } else {
      color = Color(0xFF000000);
      message =
          "Tingkat kualitas udara yang dapat merugikan kesehatan serius pada populasi dan perlu penanganan cepat";
    }
  }

  String getCriticalAlphabet(String critical) {
    return critical.replaceAll(RegExp(r'\d+'), '');
  }

  String getCriticalNumber(String critical) {
    return critical.replaceAll(RegExp(r'[a-zA-Z]+'), '');
  }
}
