// spring의 api문서를 확인하고 제작할 것
import 'dart:convert';
import 'package:data_app/domain/http_connector.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final productHttpRepository = Provider<ProductHttpRepository>((ref) {
  return ProductHttpRepository(ref);
});

class ProductHttpRepository {
  Ref _ref;
  ProductHttpRepository(this._ref);

  // Product findById(int id) {
  //   // http 통신 코드 (api문서 보고 작성하기)
  //   // 통신용 스레드를 만들어서 findById를 하게끔 구현해야 함
  //   // 메인 스레드는 통신을 시켜놓고 밑으로 내려 옴
  //   // 그래서 보통 통신을 할 때 약속이 담긴 Future<>를 리턴해서 (null을 가진 상자)
  //   // provider가 FutureBox에 값이 담기면 확인하고(Watch하고 있음) view를 리빌드 한다.
  //   Product product = list.singleWhere((product) => product.id == id);
  //   return product;
  // }

  //void findAll ()

  Future<Product> findById(int id) async {
    Response response =
        await _ref.read(httpConnector).get("/api/product/${id}");
    Product product = Product.fromJson(jsonDecode(response.body));
    return product;
  }

  Future<List<Product>> findAll() async {
    // http 통신 코드 (api문서 보고 작성하기)
    Response response = await _ref.read(httpConnector).get("/api/product");
    List<dynamic> dataList = jsonDecode(response.body)["data"];

    // 오브젝트로 변경해서 리턴
    return dataList.map((productMap) => Product.fromJson(productMap)).toList();
  }

  // name, price만 들어옴
  // 외부통신때 사용함
  Future<Product> insert(Product productReqDto) async {
    String body = jsonEncode(productReqDto.toJson());
    Response response =
        await _ref.read(httpConnector).post("/api/product", body);
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    return product;
  }

  Future<int> deleteById(int id) async {
    Response response =
        await _ref.read(httpConnector).delete("/api/product/${id}");
    return jsonDecode(response.body)["code"];
  }

  Future<Product> updateById(int id, Product productReqDto) async {
    String body = jsonEncode(productReqDto.toJson());
    Response response =
        await _ref.read(httpConnector).put("/api/product/${id}", body);
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    return product;
  }
}
