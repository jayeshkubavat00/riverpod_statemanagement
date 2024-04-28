import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statemanagement/repo/products_repo.dart';

import '../repo/product2_repo.dart';

final productProvider =
    FutureProvider((ref) => ref.read(productRepositoryProvider).getProducts());

final product2Provider =
    FutureProvider((ref) => ref.read(product2RepositoryProvider).getProducts());