import 'package:bloc/bloc.dart';
import 'package:stylish/Features/home/data/repos/product_repo.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.productRepo}) : super(ProductInitial());

  final ProductRepo productRepo;

  Future<void> loadProducts() async {
    emit(ProductLoading());
    try {
      final products = await productRepo.getProducts();
      emit(ProductLoaded(products: products));
    } catch (error) {
      emit(ProductError(error.toString()));
    }
  }
}
