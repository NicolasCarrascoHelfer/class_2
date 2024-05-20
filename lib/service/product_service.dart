import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:practica_2/model/product_model.dart';

class ProductService {
  final _productCollection = FirebaseFirestore.instance.collection('products');

  //get my selected  list
  Future<List<Product>> getMyProductList() async {
    try {
      final querySnapshot = await _productCollection.get();
      final selected = querySnapshot.docs.map((doc) {
        var temp = Product.fromJson(doc.data());
        return temp;
      }).toList();
      return selected;
    } catch (e) {
      rethrow;
    }
  }
}
