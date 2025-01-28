import 'package:auto_route/auto_route.dart';
import 'package:supabase_flutter/supabase_flutter.dart';  // Import Supabase package
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: HistoryRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: ProfileRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        // Check if user is authenticated using Supabase
        Supabase.instance.client.auth.currentUser == null
            ? CustomRoute(
                page: SignInRoute.page,
                transitionsBuilder: TransitionsBuilders.slideRight,
                path: '/',
              )
            : CustomRoute(
                page: SignInRoute.page,
                transitionsBuilder: TransitionsBuilders.slideRight,
              ),
        CustomRoute(
          page: SignUpRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        // Check if user is authenticated using Supabase
        Supabase.instance.client.auth.currentUser == null
            ? AutoRoute(page: ChatRoute.page)
            : AutoRoute(page: ChatRoute.page, path: '/'),
      ];
}
