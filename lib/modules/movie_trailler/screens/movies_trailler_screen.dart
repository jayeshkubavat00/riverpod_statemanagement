// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_statemanagement/modules/movie_trailler/proviers/movie_trailler_provider.dart';

class MoviesTraillerScreen extends ConsumerWidget {
  const MoviesTraillerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(movieTraillerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Traillers"),
      ),
      body: SafeArea(
        child: data.moviesTraillerEnum == MoviesTraillerEnum.dataLoading ||
                data.moviesTraillerEnum == MoviesTraillerEnum.initial
            ? const Center(child: CircularProgressIndicator())
            : data.moviesTraillerEnum == MoviesTraillerEnum.dataError
                ? const Center(
                    child: Text(
                    "Something is missing",
                    style: TextStyle(color: Colors.red),
                  ))
                : ListView.builder(
                    itemCount: data.moviesTraillerData.length,
                    itemBuilder: (context, index) {
                      final item = data.moviesTraillerData[index];
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.arrow_drop_up,
                                        size: 50,
                                      ),
                                      Text(item.voting.toString()),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        size: 50,
                                      ),
                                      const Text("Voted")
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Image.network(
                                      item.poster.toString(),
                                      height: 150,
                                      width: 90,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        rowTile(
                                            title: "Genre:",
                                            value: item.genre.toString()),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        rowTile(
                                            title: "Director:",
                                            value: item.director.join(", ")),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        rowTile(
                                            title: "Starring:",
                                            value: item.stars.join(", ")),
                                        Text(
                                          '${item.language.name} | ${DateFormat("d, MMM").format(DateTime.parse(item.releasedDate.toString()))}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${item.pageViews} Views | Voted by ${item.voting} Peoples",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                height: 40,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Center(
                                  child: Text(
                                    "Watch Trailler",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(0.70),
                                endIndent: 16,
                                indent: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                   
                    },
                  ),
      ),
    );
  }

  Widget rowTile({required String title, String? value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            value ?? "",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
