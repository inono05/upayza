import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/features/Authentications/presentation/views/authentication_view.dart';
import 'package:upayza/src/features/Authentications/presentation/views/email_verification_view.dart';
import 'package:upayza/src/features/Authentications/presentation/views/password_forgot_view.dart';
import 'package:upayza/src/features/Cards/presentation/views/add_card_view.dart';
import 'package:upayza/src/features/Cards/presentation/views/card_view.dart';
import 'package:upayza/src/features/Countries/presentation/views/country_view.dart';
import 'package:upayza/src/features/Dashboard/presentation/views/dashboard_view.dart';
import 'package:upayza/src/features/HistoryTransactions/presentation/views/history_view.dart';
import 'package:upayza/src/features/HomeNavigation/presentation/views/home_nested_navigation_view.dart';
import 'package:upayza/src/features/Idioms/presentation/views/idiom_view.dart';
import 'package:upayza/src/features/Onboarding/presentation/views/onboarding_view.dart';
import 'package:upayza/src/features/Onboarding/repository/onboarding_repository.dart';
import 'package:upayza/src/features/Otp/presentation/views/otp_view.dart';
import 'package:upayza/src/features/Parameters/presentation/views/parameter_view.dart';
import 'package:upayza/src/features/Profile/presentation/views/profile_view.dart';
import 'package:upayza/src/features/Profile/presentation/views/update_profile_view.dart';
import 'package:upayza/src/features/Recipients/presentations/views/add_recipient_view.dart';
import 'package:upayza/src/features/Recipients/presentations/views/recipient_view.dart';
import 'package:upayza/src/features/Splash/presentation/views/splash_view.dart';
import 'package:upayza/src/features/Transactions/presentation/views/transaction_details_view.dart';
import 'package:upayza/src/features/Transactions/presentation/views/transaction_momo_view.dart';
import 'package:upayza/src/features/Transactions/presentation/views/transaction_stepper_view.dart';
import 'package:upayza/src/features/Transactions/presentation/views/transaction_view.dart';
import 'package:upayza/src/features/status/presentations/views/status_view.dart';

part 'app_router.g.dart';

//privates navigators keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _dashboardNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "dashboard");
final _cardsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'cards');
final _transactionsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'transactions');
final _historiesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'histories');
final _moreNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'more');

enum AppRoutes {
  country,
  splash,
  onboarding,
  authenticate,
  emailVerify,
  home,
  dashboard,
  cards,
  addCard,
  transactions,
  histories,
  more,
  profile,
  profileUpdate,
  otp,
  forgotPassword,
  idiom,
  transactionDetails,
  transactionStepper,
  transactionMomo,
  recipients,
  addRecipients,
  status,
}

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final onboardRepoProvider = onboardingRepositoryProvider;
  final onboarding = ref.watch(onboardRepoProvider).requireValue;
  return GoRouter(
    initialLocation: '/splash',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isOnboardingCompleted = onboarding.isOnboardingComplete();
      final path = state.uri.path;
      log("isOnBoarding ===> $isOnboardingCompleted");
      log("path ===> $path");
      if (!isOnboardingCompleted) {
        if (path != '/onboarding') {
          return '/onboarding';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: AppRoutes.splash.name,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: SplashView());
        },
      ),
      GoRoute(
        path: '/idiom',
        name: AppRoutes.idiom.name,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: IdiomView());
        },
      ),
      GoRoute(
        path: '/country',
        name: AppRoutes.country.name,
        pageBuilder: (context, state) {
          return NoTransitionPage(child: CountryView());
        },
      ),
      GoRoute(
        path: '/onboarding',
        name: AppRoutes.onboarding.name,
        pageBuilder: (context, state) {
          return NoTransitionPage(child: OnboardingView());
        },
      ),
      GoRoute(
        path: '/authenticate',
        name: AppRoutes.authenticate.name,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AuthenticationView());
        },
      ),
      GoRoute(
        path: '/email-verify',
        name: AppRoutes.emailVerify.name,
        pageBuilder: (context, state) {
          return NoTransitionPage(child: EmailVerificationView());
        },
      ),
      GoRoute(
        path: '/forgot-password',
        name: AppRoutes.forgotPassword.name,
        pageBuilder: (context, state) {
          return NoTransitionPage(child: PasswordForgotView());
        },
      ),
      GoRoute(
        path: '/otp/:from/:email',
        name: AppRoutes.otp.name,
        pageBuilder: (context, state) {
          final String from = state.pathParameters['from']!;
          final String email = state.pathParameters['email']!;
          return NoTransitionPage(
            child: OtpView(
              from: from,
              email: email,
            ),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (
          context,
          state,
          navigationShell,
        ) {
          return HomeNestedNavigationView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _dashboardNavigatorKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                name: AppRoutes.dashboard.name,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: DashboardView());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _cardsNavigatorKey,
            routes: [
              GoRoute(
                  path: '/cards',
                  name: AppRoutes.cards.name,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(child: CardView());
                  },
                  routes: [
                    GoRoute(
                      path: 'add-card',
                      name: AppRoutes.addCard.name,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                          child: AddCardView(),
                        );
                      },
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(navigatorKey: _transactionsNavigatorKey, routes: [
            GoRoute(
              path: '/transactions',
              name: AppRoutes.transactions.name,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: TransactionView());
              },
              routes: [
                GoRoute(
                  path: 'transaction-stepper',
                  name: AppRoutes.transactionStepper.name,
                  pageBuilder: (context, state) {
                    return const NoTransitionPage(
                      child: TransactionStepperView(),
                    );
                  },
                ),
                GoRoute(
                  path: 'transaction-momo',
                  name: AppRoutes.transactionMomo.name,
                  pageBuilder: (context, state) {
                    return const NoTransitionPage(
                      child: TransactionMomoView(),
                    );
                  },
                ),
                GoRoute(
                  path: 'transaction-details',
                  name: AppRoutes.transactionDetails.name,
                  pageBuilder: (context, state) {
                    return const NoTransitionPage(
                        child: TransactionDetailsView());
                  },
                ),
              ],
            ),
          ]),
          StatefulShellBranch(
            navigatorKey: _historiesNavigatorKey,
            routes: [
              GoRoute(
                path: '/histories',
                name: AppRoutes.histories.name,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: HistoryView());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _moreNavigatorKey,
            routes: [
              GoRoute(
                path: '/more',
                name: AppRoutes.more.name,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: ParameterView());
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        name: AppRoutes.profile.name,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: ProfileView());
        },
        routes: [
          GoRoute(
            path: 'update',
            name: AppRoutes.profileUpdate.name,
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: UpdateProfileView());
            },
          ),
          GoRoute(
            path: 'recipients',
            name: AppRoutes.recipients.name,
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: RecipientView());
            },
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoutes.addRecipients.name,
                pageBuilder: (context, state) {
                  return NoTransitionPage(child: AddRecipientView());
                },
              )
            ]
          ),
        ],
      ),
      GoRoute(
        path: '/status',
        name: AppRoutes.status.name,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: StatusView());
        },
      ),
    ],
  );
}
