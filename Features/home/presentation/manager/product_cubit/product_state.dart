abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  ProductLoaded({required this.products});

  final List<Map<String, dynamic>> products;
}

class ProductError extends ProductState {
  ProductError(this.message);

  final String message;
}

class ProductEmpty extends ProductState {}
class ProductLoadingMore extends ProductState {
  ProductLoadingMore({required this.products});

  final List<Map<String, dynamic>> products;
}
class ProductSuccessState extends ProductState {
  ProductSuccessState({required this.products});

  final List<Map<String, dynamic>> products;
}
