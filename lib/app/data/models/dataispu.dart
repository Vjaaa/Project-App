import 'dart:convert';

class DataIspu {
  final DateTime? tanggal;
  final int? pm10;
  final int? pm25;
  final int? so2;
  final int? co;
  final int? o3;
  final int? no2;
  final int? hc;
  final int? max;
  final String? categori;
  final String? critical;

  DataIspu({
    required this.tanggal,
    required this.pm10,
    required this.pm25,
    required this.so2,
    required this.co,
    required this.o3,
    required this.no2,
    required this.hc,
    required this.max,
    required this.categori,
    required this.critical,
  });

  factory DataIspu.fromMap(Map<String, dynamic> data) {
    return DataIspu(
      tanggal: DateTime.parse(data['tanggal']),
      pm10: data['pm10'],
      pm25: data['pm25'],
      so2: data['so2'],
      co: data['co'],
      o3: data['o3'],
      no2: data['no2'],
      hc: data['hc'],
      max: data['max'],
      categori: data['categori'],
      critical: data['critical'],
    );
  }

  factory DataIspu.fromJson(String json) => DataIspu.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap(DataIspu dataIspu) {
    return {
      'tanggal': dataIspu.tanggal,
      'pm10': dataIspu.pm10,
      'pm25': dataIspu.pm25,
      'so2': dataIspu.so2,
      'co': dataIspu.co,
      'o3': dataIspu.o3,
      'no2': dataIspu.no2,
      'hc': dataIspu.hc,
      'max': dataIspu.max,
      'categori': dataIspu.categori,
      'critical': dataIspu.critical,
    };
  }

  String toJson(DataIspu dataIspu) => jsonEncode(toMap(dataIspu));
}
