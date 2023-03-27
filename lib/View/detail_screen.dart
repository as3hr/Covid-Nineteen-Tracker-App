import 'package:covid_nineteen/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name, image;
  int? totalCases, totalDeaths, totalRecovered, active, critical, test;

  DetailScreen({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(widget.name),
          )),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        ReusableRow(
                            title: 'Cases',
                            value: widget.totalCases.toString()),
                        ReusableRow(
                            title: 'Deaths',
                            value: widget.totalDeaths.toString()),
                        ReusableRow(
                            title: 'Recovered',
                            value: widget.totalRecovered.toString()),
                        ReusableRow(
                            title: 'Critical',
                            value: widget.critical.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ]),
    );
  }
}
