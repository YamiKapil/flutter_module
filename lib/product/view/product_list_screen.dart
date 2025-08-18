import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_module/product/controller/product_controller.dart';
import 'package:flutter_ui_module/product/model/product_model.dart';

import 'product_detail_screen.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Consumer(
            builder: (context, ref, child) {
              return ref.watch(getProductListFutureProvider).when(
                    data: (data) {
                      if (data.isNotEmpty) {
                        return ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            ProductModel items = data[index];
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                      id: items.id ?? 1,
                                    ),
                                  ),
                                );
                              },
                              leading: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: items.image ?? "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                placeholder:
                                    (BuildContext context, String url) =>
                                        const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              title: Text(
                                items.title ?? "",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              subtitle: Text(
                                items.description ?? "",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          },
                        );
                      } else {}
                      return const Text("Something went wrong");
                    },
                    error: (err, _) {
                      return const Text("Something went wrong");
                    },
                    loading: () => const CircularProgressIndicator.adaptive(),
                  );
            },
          ),
        ),
      ),
    );
  }
}
