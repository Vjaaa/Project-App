import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ISPUclassification/app/data/models/datasource.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      children: [
                        // Title
                        const Center(
                          child: Text(
                            'Indeks Standar Pencemaran Udara (ISPU)',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 15),

                        /// Card ISPU
                        Container(
                          width: double.infinity,
                          height: 235,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat("EEEE, d MMMM yyyy",
                                                      "id_ID")
                                                  .format(controller
                                                          .dataIspu?.tanggal ??
                                                      DateTime.now()),
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 12,
                                              ),
                                              decoration: BoxDecoration(
                                                color: controller.color,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: controller
                                                          .getCriticalAlphabet(
                                                              controller
                                                                      .dataIspu
                                                                      ?.critical ??
                                                                  ''),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 28,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: controller
                                                              .getCriticalNumber(
                                                                  controller
                                                                          .dataIspu
                                                                          ?.critical ??
                                                                      ''),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    width: 2,
                                                    height: 30,
                                                  ),
                                                  Text(
                                                    '${controller.dataIspu?.max}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.air,
                                              color: controller.color,
                                              size: 62,
                                            ),
                                            const Spacer(),
                                            const Text(
                                              'Kualitas Udara',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              controller.dataIspu?.categori ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: controller.color,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: controller.color,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  controller.message ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        /// Grafik ISPU
                        Container(
                          width: double.infinity,
                          height: 275,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            title: ChartTitle(text: 'Parameter ISPU'),
                            series: <ChartSeries<DataSource, String>>[
                              ColumnSeries<DataSource, String>(
                                dataSource: [
                                  DataSource(
                                      'PM10', controller.dataIspu?.pm10 ?? 0),
                                  DataSource(
                                      'PM2.5', controller.dataIspu?.pm25 ?? 0),
                                  DataSource(
                                      'SO2', controller.dataIspu?.so2 ?? 0),
                                  DataSource(
                                      'CO', controller.dataIspu?.co ?? 0),
                                  DataSource(
                                      'O3', controller.dataIspu?.o3 ?? 0),
                                  DataSource(
                                      'NO2', controller.dataIspu?.no2 ?? 0),
                                  DataSource(
                                      'HC', controller.dataIspu?.hc ?? 0),
                                ],
                                xValueMapper: (data, index) => data.parameter,
                                yValueMapper: (data, index) => data.nilai,
                                pointColorMapper: (data, index) {
                                  Color? color;

                                  if (data.nilai > 0 && data.nilai <= 50)
                                    color = Color(0xFF33cc33);
                                  else if (data.nilai >= 51 &&
                                      data.nilai <= 100)
                                    color = Color(0xFF0070c0);
                                  else if (data.nilai >= 101 &&
                                      data.nilai <= 200)
                                    color = Color(0xFFffc000);
                                  else if (data.nilai >= 201 &&
                                      data.nilai <= 300)
                                    color = Color(0xFFff0000);
                                  else
                                    color = Color(0xFF000000);

                                  return color;
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
