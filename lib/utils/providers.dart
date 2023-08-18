import 'package:get_it/get_it.dart';
import 'package:interfone_digital/services/auth_service.dart';

final getIt = GetIt.instance;

setupProviders() {
  getIt.registerSingleton<AuthService>(AuthService());
}
