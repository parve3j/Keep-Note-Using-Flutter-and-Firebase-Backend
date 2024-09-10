import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/registration_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/splash_screen.dart';


final GoRouter goRouter = GoRouter(
  navigatorKey: Get.key,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen(), name: 'splash'),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen(), name: 'login'),
    GoRoute(path: '/register', builder: (context, state) => RegistrationScreen(), name: 'register'),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen(), name: 'home'),
  ],
);
