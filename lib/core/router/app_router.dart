import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
            page: HistoryRoute.page,
            transitionsBuilder: TransitionsBuilders.slideLeft),
        // AutoRoute(
        //   page: ProfileRoute.page,
        // ),
        CustomRoute(
            page: ProfileRoute.page,
            transitionsBuilder: TransitionsBuilders.slideLeft),
        AutoRoute(page: ChatRoute.page, path: '/'),
      ];
}
