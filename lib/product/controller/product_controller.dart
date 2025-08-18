import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_module/constants/urls.dart';
import 'package:flutter_ui_module/product/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/request_type.dart';
import '../../util/network_client.dart';

final getProductList =
    StateNotifierProvider<GetProductController, List<ProductModel>>((ref) {
  return GetProductController();
});

// final getProductListFutureProvider =
//     FutureProvider.autoDispose.family<ProductModel?, int>((ref, id) async {
//   final provider = ref.watch(getProductList.notifier);
//   await provider.getProductList(id);
//   return ref.read(getProductList);
// });
final getProductListFutureProvider =
    FutureProvider<List<ProductModel>>((ref) async {
  final provider = ref.watch(getProductList.notifier);
  await provider.getProductList();
  return ref.read(getProductList);
});

class GetProductController extends StateNotifier<List<ProductModel>> {
  GetProductController() : super([]);

  DioClient dioClient = DioClient();

  Future getProductList() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString("product_list");
    try {
      if (cachedData != null && cachedData.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(cachedData);
        state = decoded
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        final response = await dioClient.request(
          requestType: RequestType.get,
          url: Urls.productList,
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          if (response.data != null) {
            state = (response.data as List<dynamic>)
                .map((item) => ProductModel.fromJson(item))
                .toList();
            prefs.setString(
              "product_list",
              jsonEncode(state.map((e) => e.toJson()).toList()),
            );
          }
        }
      }
    } catch (ex) {
      log(ex.toString());
    }
  }
}
