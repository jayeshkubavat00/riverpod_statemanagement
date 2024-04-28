import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statemanagement/repo/product2_repo.dart';

import '../models/product2_model.dart';
final product2Provider =
    FutureProvider((ref) => ref.read(product2RepositoryProvider).getProducts());
class HomeShopScreen extends ConsumerWidget {
  const HomeShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Scaffold(
      body: SafeArea(
        child:  Consumer(
          builder: (context, watch, _) {
            final AsyncValue<List<Product2Model>> products =
                ref.watch(product2Provider);

            return products.when(
              data: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 100,
                              child: PageView.builder(
                                itemCount: data[index].images!.length,
                                itemBuilder: (context, i) {
                                  return Image.network(
                                    data[index].images![i].toString(),
                                    
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[index].title.toString()),
                                Text("Price ${data[index].price}"),
                                Text(data[index].category.toString()),
                                Text("Decription: ${data[index].description}"),
                                // Text("Rating ${data[index].rating}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                // log(error.toString());
                return Text(error.toString());
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }
}
