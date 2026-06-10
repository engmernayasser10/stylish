import 'package:stylish/Features/home/data/repos/product_repo.dart';

class ProductRepoImplementation implements ProductRepo {
  @override
  Future<List<Map<String, dynamic>>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return <Map<String, dynamic>>[
      {
        'title': 'Classic Sneakers',
        'price': 99,
        'images': <String>['https://via.placeholder.com/400x400.png?text=Sneakers'],
      },
      {
        'title': 'Denim Jacket',
        'price': 129,
        'images': <String>['https://via.placeholder.com/400x400.png?text=Jacket'],
      },
      {
        'title': 'Leather Bag',
        'price': 149,
        'images': <String>['https://via.placeholder.com/400x400.png?text=Bag'],
      },
      {
        'title': 'Summer Hat',
        'price': 29,
        'images': <String>['https://via.placeholder.com/400x400.png?text=Hat'],
      },
    ];
  }
}
