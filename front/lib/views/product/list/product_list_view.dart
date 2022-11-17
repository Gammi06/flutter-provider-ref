import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListView extends ConsumerWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pm = ref.watch(productListViewStore); // view모델을 바라봄
    final pc = ref.read(productController);

    // 빌드 내부에 메서드 호출 사용X

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          pc.insert(Product(id: 0, name: "복숭아", price: 1200));
        },
      ),
      appBar: AppBar(title: Text("product_list_page")),
      body: _buildListView(pm, pc),
    );
  }

  Widget _buildListView(List<Product> pm, ProductController pc) {
    if (!(pm.length > 0)) {
      return Center(
        child: Image.asset(
          "assets/image/loading.gif",
          width: 100,
          height: 100,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: pm.length,
        itemBuilder: (context, index) => ListTile(
          // key = id값
          key: ValueKey(pm[index].id),
          onTap: () {
            pc.deleteById(pm[index].id);
          },
          onLongPress: () {
            pc.updateById(
                pm[index].id, Product(id: 99, name: '고구마', price: 9999));
          },
          leading: Icon(Icons.wallet_travel),
          title: Text(
            "${pm[index].name}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${pm[index].price}"),
        ),
      );
    }
  }
}
