import 'package:bike_shop_2/app/app_state.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:bike_shop_2/landing/landing_page.dart';
import 'package:bike_shop_2/bikes/presentation/routes.dart';
import 'package:provider/provider.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart' show EmailAuthProvider;

GoRouter appRouter(ApplicationState appState) => GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/sign-in',
      name: 'sign-in',
      builder: (context, state) => SignInScreen(
        providers: [EmailAuthProvider()],
        actions: [
          AuthStateChangeAction<SignedIn>((context, authState) {
            final from = state.uri.queryParameters['from'];
            context.go(from ?? '/');
          }),
        ],
      ),
    ),
    GoRoute(
      path: "/",
      name: "landing",
      builder: (context, state) => const LandingPage(),
    ),
    ...bikesRoutes,
  ],
  refreshListenable: appState, // triggers re-eval on auth changes
  redirect: (context, state) {
    if (!appState.ready) return null; // don’t bounce during startup

    final signingIn = state.matchedLocation == '/sign-in';

    if (!appState.loggedIn) {
      // only allow /sign-in when logged out
      return signingIn
          ? null
          : '/sign-in?from=${Uri.encodeComponent(state.uri.toString())}';
    }

    // logged-in users shouldn’t sit on /sign-in
    if (signingIn) {
      final from = state.uri.queryParameters['from'];
      return from ?? '/';
    }

    return null;
  },
);
