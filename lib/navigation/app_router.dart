import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/auth/auth.dart';
import 'package:pau_sosyal/pages/event_detail_page.dart';
import 'package:pau_sosyal/pages/event_page.dart';
import 'package:pau_sosyal/pages/favorites_page.dart';
import 'package:pau_sosyal/pages/job_detail_page.dart';
import 'package:pau_sosyal/pages/job_page.dart';
import 'package:pau_sosyal/pages/login_page.dart';
import 'package:pau_sosyal/pages/noti_page.dart';
import 'package:pau_sosyal/pages/onboard_page.dart';
import 'package:pau_sosyal/pages/project_detail_page.dart';
import 'package:pau_sosyal/pages/project_page.dart';
import 'package:pau_sosyal/pages/register_page.dart';
import 'package:pau_sosyal/pages/search_page.dart';
import 'package:pau_sosyal/pages/settings_page.dart';
import 'package:pau_sosyal/pages/splash_page.dart';
import 'package:pau_sosyal/pages/tab_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: AppRouter._replaceInRouteName)
final class AppRouter extends _$AppRouter {
  static const _replaceInRouteName = 'Page,Route';
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: SplashRoute.page,
        ),
        AutoRoute(
          page: OnBoardRoute.page,
        ),
        AutoRoute(
          page: AuthRoute.page,
        ),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: TabRoute.page,
          children: [
            AutoRoute(
              initial: true,
              page: EventRoute.page,
            ),
            AutoRoute(
              page: ProjectRoute.page,
            ),
            AutoRoute(
              page: JobRoute.page,
            ),
            AutoRoute(
              page: SettingsRoute.page,
            ),
          ],
        ),
        AutoRoute(
          page: EventDetailRoute.page,
        ),
        AutoRoute(
          page: ProjectDetailRoute.page,
        ),
        AutoRoute(
          page: JobDetailRoute.page,
        ),
        AutoRoute(
          page: SearchRoute.page,
        ),
        AutoRoute(
          page: NotiRoute.page,
        ),
        AutoRoute(
          page: FavoritesRoute.page,
        ),
      ];
}
