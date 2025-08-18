import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_module/product/controller/product_detail_controller.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final int id;
  const ProductDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Consumer(
            builder: (context, ref, child) {
              return ref.watch(getProductDetailFutureProvider(widget.id)).when(
                    data: (data) {
                      if (data != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Center(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: data.image ?? "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 200,
                                  width: 200,
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
                            ),
                            const SizedBox(height: 30),
                            Text(data.title ?? ""),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Category: ${data.category ?? ""}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  "Price: \$${data.price ?? ""}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Description:",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              data.description ?? "",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  _returnToNativeWithData({
                                    'productId': widget.id,
                                    'productName': data.title.toString(),
                                    'price': data.price.toString(),
                                    'status': 'paymentInitiated',
                                  });
                                },
                                child: const Text("Pay Now"),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text("Something went wrong");
                      }
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

Future<void> _returnToNativeWithData(Map<String, dynamic> data) async {
  try {
    const platform =
        MethodChannel('com.example.flutter_ui_module.host/payment');
    await platform.invokeMethod('payNow', data);
  } on PlatformException catch (e) {
    debugPrint("Failed to return to native: '${e.message}'.");
  }
}
