import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:stylish/Features/auth/presentation/manager/login/api_services.dart';
import 'package:stylish/Features/home/data/repos/product_repo.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.productRepo}) : super(ProductInitial());
  final int _offset = 0;
  int _limit = 20;
  bool _isLoading = true;
  List<Map<String, dynamic>> _products = [];
  final ProductRepo productRepo;

  Future<void> loadProducts() async {
    if (!_isLoading) return;
    try {
      final products = await ApiServices()
          .fetchProducts(offset: _offset, limit: _limit)
          .cast<Map<String, dynamic>>();
      if (products.isEmpty) {
        _isLoading = false;
      } else {
        _products.addAll(products);
        _limit += 20;
      }
      emit(ProductSuccessState(products: products));
    } catch (error) {
      emit(ProductError(error.toString()));
    }
  }
}
