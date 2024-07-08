// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    EventDetailRoute.name: (routeData) {
      final args = routeData.argsAs<EventDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EventDetailPage(
          key: args.key,
          data: args.data,
        ),
      );
    },
    EventRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EventPage(),
      );
    },
    FavoritesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritesPage(),
      );
    },
    JobDetailRoute.name: (routeData) {
      final args = routeData.argsAs<JobDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: JobDetailPage(
          key: args.key,
          data: args.data,
        ),
      );
    },
    JobRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const JobPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginPage(
          key: args.key,
          onTap: args.onTap,
        ),
      );
    },
    NotiRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotiPage(),
      );
    },
    OnBoardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnBoardPage(),
      );
    },
    ProjectDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProjectDetailPage(
          key: args.key,
          data: args.data,
        ),
      );
    },
    ProjectRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProjectPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterPage(
          key: args.key,
          onTap: args.onTap,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    TabRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TabPage(),
      );
    },
  };
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EventDetailPage]
class EventDetailRoute extends PageRouteInfo<EventDetailRouteArgs> {
  EventDetailRoute({
    Key? key,
    required Map<String, dynamic> data,
    List<PageRouteInfo>? children,
  }) : super(
          EventDetailRoute.name,
          args: EventDetailRouteArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'EventDetailRoute';

  static const PageInfo<EventDetailRouteArgs> page =
      PageInfo<EventDetailRouteArgs>(name);
}

class EventDetailRouteArgs {
  const EventDetailRouteArgs({
    this.key,
    required this.data,
  });

  final Key? key;

  final Map<String, dynamic> data;

  @override
  String toString() {
    return 'EventDetailRouteArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [EventPage]
class EventRoute extends PageRouteInfo<void> {
  const EventRoute({List<PageRouteInfo>? children})
      : super(
          EventRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoritesPage]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [JobDetailPage]
class JobDetailRoute extends PageRouteInfo<JobDetailRouteArgs> {
  JobDetailRoute({
    Key? key,
    required Map<String, dynamic> data,
    List<PageRouteInfo>? children,
  }) : super(
          JobDetailRoute.name,
          args: JobDetailRouteArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'JobDetailRoute';

  static const PageInfo<JobDetailRouteArgs> page =
      PageInfo<JobDetailRouteArgs>(name);
}

class JobDetailRouteArgs {
  const JobDetailRouteArgs({
    this.key,
    required this.data,
  });

  final Key? key;

  final Map<String, dynamic> data;

  @override
  String toString() {
    return 'JobDetailRouteArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [JobPage]
class JobRoute extends PageRouteInfo<void> {
  const JobRoute({List<PageRouteInfo>? children})
      : super(
          JobRoute.name,
          initialChildren: children,
        );

  static const String name = 'JobRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    required void Function()? onTap,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onTap: onTap,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onTap,
  });

  final Key? key;

  final void Function()? onTap;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onTap: $onTap}';
  }
}

/// generated route for
/// [NotiPage]
class NotiRoute extends PageRouteInfo<void> {
  const NotiRoute({List<PageRouteInfo>? children})
      : super(
          NotiRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotiRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnBoardPage]
class OnBoardRoute extends PageRouteInfo<void> {
  const OnBoardRoute({List<PageRouteInfo>? children})
      : super(
          OnBoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProjectDetailPage]
class ProjectDetailRoute extends PageRouteInfo<ProjectDetailRouteArgs> {
  ProjectDetailRoute({
    Key? key,
    required Map<String, dynamic> data,
    List<PageRouteInfo>? children,
  }) : super(
          ProjectDetailRoute.name,
          args: ProjectDetailRouteArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'ProjectDetailRoute';

  static const PageInfo<ProjectDetailRouteArgs> page =
      PageInfo<ProjectDetailRouteArgs>(name);
}

class ProjectDetailRouteArgs {
  const ProjectDetailRouteArgs({
    this.key,
    required this.data,
  });

  final Key? key;

  final Map<String, dynamic> data;

  @override
  String toString() {
    return 'ProjectDetailRouteArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [ProjectPage]
class ProjectRoute extends PageRouteInfo<void> {
  const ProjectRoute({List<PageRouteInfo>? children})
      : super(
          ProjectRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProjectRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    Key? key,
    required void Function()? onTap,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(
            key: key,
            onTap: onTap,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<RegisterRouteArgs> page =
      PageInfo<RegisterRouteArgs>(name);
}

class RegisterRouteArgs {
  const RegisterRouteArgs({
    this.key,
    required this.onTap,
  });

  final Key? key;

  final void Function()? onTap;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, onTap: $onTap}';
  }
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TabPage]
class TabRoute extends PageRouteInfo<void> {
  const TabRoute({List<PageRouteInfo>? children})
      : super(
          TabRoute.name,
          initialChildren: children,
        );

  static const String name = 'TabRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
