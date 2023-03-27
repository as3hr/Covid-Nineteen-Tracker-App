import 'package:covid_nineteen/Services/Utilities/stats_services.dart';
import 'package:covid_nineteen/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController searchcontroller = TextEditingController();
  StatsServices statsServices = StatsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              cursorColor: Colors.black,
              controller: searchcontroller,
              decoration: InputDecoration(
                hintText: 'Search with Country Name',
                hintStyle: const TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.black)),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: statsServices.countrylist(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: 10,
                                      width: 90,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 90,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];

                            if (searchcontroller.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    test: snapshot.data![index]
                                                        ['test'],
                                                    critical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                  )));
                                    },
                                    child: ListTile(
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  )
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                searchcontroller.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    test: snapshot.data![index]
                                                        ['test'],
                                                    critical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                  )));
                                    },
                                    child: ListTile(
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }))
        ]),
      ),
    );
  }
}
