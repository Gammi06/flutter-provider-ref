import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
    StateNotifierProvider<ProductListViewStore, List<Product>>((ref) {
  //최초 데이터 초기화하기 [빈배열], ref <창고접근
  return ProductListViewStore([], ref)..initViewStore();
});

// 페이지의 필요한 데이터만 관리함
// 한개 이상의 레파지토리를 조합해서 사용됨
class ProductListViewStore extends StateNotifier<List<Product>> {
  Ref _ref; // 레파지토리 사용하려고
  ProductListViewStore(super.state, this._ref);

  void initViewStore() async {
    // 뷰 모델은 레파지토리에 따악 한번은 의존해야한다.
    // 하지만 컨트롤러를 호출하면 X
    List<Product> products = await _ref.read(productHttpRepository).findAll();
    state = products;
  }

  void onRefresh(List<Product> product) {
    state = product;
  }

  void addProduct(Product productRespDto) {
    // 무조건 깊은 복사로
    state = [...state, productRespDto];
  }

  void removeProduct(int id) {
    state = state.where((product) => product.id != id).toList();
  }

  void updateProduct(Product productRespDto) {
    state = state.map((product) {
      if (product.id == productRespDto.id) {
        return productRespDto;
      } else {
        return product;
      }
    }).toList();
  }
}
