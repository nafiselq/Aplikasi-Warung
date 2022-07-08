import 'package:get/get.dart';

import '../modules/detail_warung/bindings/detail_warung_binding.dart';
import '../modules/detail_warung/views/detail_warung_view.dart';
import '../modules/edit_warung/bindings/edit_warung_binding.dart';
import '../modules/edit_warung/views/edit_warung_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/register_user/bindings/register_user_binding.dart';
import '../modules/register_user/views/register_user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.REGISTER_USER,
      page: () => const RegisterUserView(),
      binding: RegisterUserBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_WARUNG,
      page: () => DetailWarungView(),
      binding: DetailWarungBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_WARUNG,
      page: () => EditWarungView(),
      binding: EditWarungBinding(),
    ),
  ];
}
