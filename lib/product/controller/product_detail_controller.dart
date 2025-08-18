import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_module/constants/urls.dart';
import 'package:flutter_ui_module/product/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/request_type.dart';
import '../../util/network_client.dart';

final getProductDetail =
    StateNotifierProvider.autoDispose<GetCaseDetailController, ProductModel?>(
        (ref) {
  return GetCaseDetailController();
});

final getProductDetailFutureProvider =
    FutureProvider.autoDispose.family<ProductModel?, int>((ref, id) async {
  final provider = ref.watch(getProductDetail.notifier);
  await provider.getProductDetail(id);
  return ref.read(getProductDetail);
});

class GetCaseDetailController extends StateNotifier<ProductModel?> {
  GetCaseDetailController() : super(null);

  DioClient dioClient = DioClient();

  Future getProductDetail(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString("product_list");
    try {
      if (cachedData != null && cachedData.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(cachedData);
        var data = decoded
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
        state = data.firstWhere(
          (i) => i.id.toString() == id.toString(),
          orElse: () => ProductModel(),
        );
      } else {
        final response = await dioClient.request(
          requestType: RequestType.get,
          url: Urls.productDetail.replaceFirst("{id}", id.toString()),
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          if (response.data != null) {
            state = ProductModel.fromJson(response.data);
          }
        }
      }
    } catch (ex) {
      log(ex.toString());
    }
  }
}
