import 'package:covid_nineteen/Model/WorldStatsModel.dart';
import 'package:covid_nineteen/Services/Utilities/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'country_list.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 15,
              ),
              FutureBuilder(
                future: statsServices.fetchWorldStatesRecords(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Cases':
                                double.parse(snapshot.data!.cases.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Deaths':
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: const Duration(seconds: 3),
                          chartType: ChartType.ring,
                          colorList: colorlist,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Card(
                          color: Colors.white.withOpacity(0.9),
                          child: Column(children: [
                            ReusableRow(
                                title: 'updated',
                                value: snapshot.data!.updated.toString()),
                            ReusableRow(
                                title: 'cases',
                                value: snapshot.data!.cases.toString()),
                            ReusableRow(
                                title: 'todayCases',
                                value: snapshot.data!.todayCases.toString()),
                            ReusableRow(
                                title: 'deaths',
                                value: snapshot.data!.deaths.toString()),
                            ReusableRow(
                                title: 'todayDeaths',
                                value: snapshot.data!.todayDeaths.toString()),
                            ReusableRow(
                                title: 'recovered',
                                value: snapshot.data!.recovered.toString()),
                            ReusableRow(
                                title: 'todayRecovered',
                                value:
                                    snapshot.data!.todayRecovered.toString()),
                            ReusableRow(
                                title: 'active',
                                value: snapshot.data!.active.toString()),
                            ReusableRow(
                                title: 'critical',
                                value: snapshot.data!.critical.toString()),
                            ReusableRow(
                                title: 'casesPerOneMillion',
                                value: snapshot.data!.casesPerOneMillion
                                    .toString()),
                            ReusableRow(
                                title: 'deathsPerOneMillion',
                                value: snapshot.data!.deathsPerOneMillion
                                    .toString()),
                            ReusableRow(
                                title: 'tests',
                                value: snapshot.data!.tests.toString()),
                            ReusableRow(
                                title: 'testsPerOneMillion',
                                value: snapshot.data!.testsPerOneMillion
                                    .toString()),
                            ReusableRow(
                                title: 'population',
                                value: snapshot.data!.population.toString()),
                            ReusableRow(
                                title: 'affectedCountries',
                                value: snapshot.data!.affectedCountries
                                    .toString()),
                            ReusableRow(
                                title: 'recoveredPerOneMillion',
                                value: snapshot.data!.recoveredPerOneMillion
                                    .toString()),
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CountryList(),
                                ));
                          },
                          child: Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                  )
                                ]),
                            child: const Center(
                              child: Text(
                                'Track Country',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: SpinKitFadingCircle(
                        color: Colors.black,
                        size: 50,
                        controller: controller,
                      ),
                    );
                  }
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        )
      ],
    );
  }
}
