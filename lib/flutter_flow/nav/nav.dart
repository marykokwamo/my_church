import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/notifications/notifications_widget.dart';
import '/checkin/checkin_widget.dart';
import '/prayer_requests/prayer_requests_widget.dart';
import '/devotions/devotions_widget.dart';
import '/events_calendar/events_calendar_widget.dart';
import '/my_events_qr/my_events_qr_widget.dart';
import '/shop/shop_widget.dart';
import '/announcements/announcements_widget.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => appStateNotifier.showSplashImage
          ? Builder(
              builder: (context) => Container(
                color: Colors.transparent,
                child: Image.asset(
                  'assets/images/bg-2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : HomePageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.showSplashImage
              ? Builder(
                  builder: (context) => Container(
                    color: Colors.transparent,
                    child: Image.asset(
                      'assets/images/bg-2.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : HomePageWidget(),
          routes: [
            FFRoute(
              name: 'HomePage',
              path: 'homePage',
              builder: (context, params) => HomePageWidget(),
            ),
            FFRoute(
              name: 'jobs',
              path: 'jobs',
              builder: (context, params) => JobsWidget(),
            ),
            FFRoute(
              name: 'sermons',
              path: 'sermons',
              builder: (context, params) => BaseLayoutWidget(
                showAppBar: true,
                initialIndex: 2,
              ),
            ),
            FFRoute(
              name: 'jobDetail',
              path: 'jobDetail',
              builder: (context, params) => JobDetailWidget(),
            ),
            FFRoute(
              name: 'join-request',
              path: 'joinRequest',
              builder: (context, params) => JoinRequestWidget(),
            ),
            FFRoute(
              name: 'Register',
              path: 'register',
              builder: (context, params) => RegisterWidget(),
            ),
            FFRoute(
              name: 'sign-in',
              path: 'signIn',
              builder: (context, params) => SignInWidget(),
            ),
            FFRoute(
              name: 'otp',
              path: 'otp',
              builder: (context, params) => OtpWidget(),
            ),
            FFRoute(
              name: 'landing',
              path: 'landing',
              builder: (context, params) => BaseLayoutWidget(
                showAppBar: true,
                initialIndex: 0,
              ),
            ),
            FFRoute(
              name: 'notifications',
              path: 'notifications',
              builder: (context, params) => NotificationsWidget(),
            ),
            FFRoute(
              name: 'chooseachurch',
              path: 'chooseachurch',
              builder: (context, params) => ChooseachurchWidget(),
            ),
            FFRoute(
              name: 'jobsfilter',
              path: 'jobsfilter',
              builder: (context, params) => JobsfilterWidget(),
            ),
            FFRoute(
              name: 'give',
              path: 'give',
              builder: (context, params) => BaseLayoutWidget(
                showAppBar: true,
                initialIndex: 1,
              ),
            ),
            FFRoute(
              name: 'offering',
              path: 'offering',
              builder: (context, params) => OfferingWidget(),
            ),
            FFRoute(
              name: 'Tithe',
              path: 'tithe',
              builder: (context, params) => TitheWidget(),
            ),
            FFRoute(
              name: 'otheraccounts',
              path: 'otheraccounts',
              builder: (context, params) => OtheraccountsWidget(),
            ),
            FFRoute(
              name: 'pledges',
              path: 'pledges',
              builder: (context, params) => PledgesWidget(),
            ),
            FFRoute(
              name: 'makeapledge',
              path: 'makeapledge',
              builder: (context, params) => MakeapledgeWidget(),
            ),
            FFRoute(
              name: 'updatepledge',
              path: 'updatepledge',
              builder: (context, params) => UpdatepledgeWidget(),
            ),
            FFRoute(
              name: 'paypledge',
              path: 'paypledge',
              builder: (context, params) => PaypledgeWidget(),
            ),
            FFRoute(
              name: 'passwordreset',
              path: 'passwordreset',
              builder: (context, params) => PasswordresetWidget(),
            ),
            FFRoute(
              name: 'profile',
              path: 'profile',
              builder: (context, params) => ProfileWidget(),
            ),
            FFRoute(
              name: 'checkin',
              path: 'checkin',
              builder: (context, params) => CheckinWidget(),
            ),
            FFRoute(
              name: 'prayer-requests',
              path: 'prayer-requests',
              builder: (context, params) => PrayerRequestsWidget(),
            ),
            FFRoute(
              name: 'devotions',
              path: 'devotions',
              builder: (context, params) => DevotionsWidget(),
            ),
            FFRoute(
              name: 'events',
              path: 'events-calendar',
              builder: (context, params) => EventsCalendarWidget(),
            ),
            FFRoute(
              name: 'my-events-qr',
              path: 'my-events-qr',
              builder: (context, params) => MyEventsQRWidget(),
            ),
            FFRoute(
              name: 'shop',
              path: 'shop',
              builder: (context, params) => ShopWidget(),
            ),
            FFRoute(
              name: 'announcements',
              path: 'announcements',
              builder: (context, params) => AnnouncementsWidget(),
            ),
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.fade,
        duration: Duration(milliseconds: 300),
      );
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
