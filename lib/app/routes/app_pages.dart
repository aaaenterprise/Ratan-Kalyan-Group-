import 'package:get/get.dart';
import 'package:gold/app/modules/gali-bid/bindings/gali_bid_binding.dart';
import 'package:gold/app/modules/gali-bid/views/gali_bid_view.dart';
import 'package:gold/app/modules/gali-chart/bindings/gali_chart_binding.dart';
import 'package:gold/app/modules/gali-chart/views/gali_chart_view.dart';
import 'package:gold/app/modules/gali-home/bindings/gali_home_binding.dart';
import 'package:gold/app/modules/gali-home/views/gali_home_view.dart';
import 'package:gold/app/modules/gali-rate/bindings/gali_rate_binding.dart';
import 'package:gold/app/modules/gali-rate/views/gali_rate_view.dart';
import 'package:gold/app/modules/gali-win/bindings/gali_win_binding.dart';
import 'package:gold/app/modules/gali-win/views/gali_win_view.dart';

import '../modules/StarLine/bindings/star_line_binding.dart';
import '../modules/StarLine/views/star_line_view.dart';
import '../modules/StarLineBidHistory/bindings/star_line_bid_history_binding.dart';
import '../modules/StarLineBidHistory/views/star_line_bid_history_view.dart';
import '../modules/StarLineChart/bindings/star_line_chart_binding.dart';
import '../modules/StarLineChart/views/star_line_chart_view.dart';
import '../modules/StarLineGameRate/bindings/star_line_game_rate_binding.dart';
import '../modules/StarLineGameRate/views/star_line_game_rate_view.dart';
import '../modules/StarLineWinHistory/bindings/star_line_win_history_binding.dart';
import '../modules/StarLineWinHistory/views/star_line_win_history_view.dart';
import '../modules/addPoint/bindings/add_point_binding.dart';
import '../modules/addPoint/views/add_point_view.dart';
import '../modules/bidHistory/bindings/bid_history_binding.dart';
import '../modules/bidHistory/views/bid_history_view.dart';
import '../modules/chart/bindings/chart_binding.dart';
import '../modules/chart/views/chart_view.dart';
import '../modules/create_bet/bindings/create_bet_binding.dart';
import '../modules/create_bet/views/create_bet_view.dart';
import '../modules/fund/bindings/fund_binding.dart';
import '../modules/fund/views/fund_view.dart';
import '../modules/gameRate/bindings/game_rate_binding.dart';
import '../modules/gameRate/views/game_rate_view.dart';
import '../modules/game_option/bindings/game_option_binding.dart';
import '../modules/game_option/views/game_option_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/howToPlay/bindings/how_to_play_binding.dart';
import '../modules/howToPlay/views/how_to_play_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splashScreen/bindings/splash_screen_binding.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';
import '../modules/winningHistory/bindings/winning_history_binding.dart';
import '../modules/winningHistory/views/winning_history_view.dart';
import '../modules/withdrawPoint/bindings/withdraw_point_binding.dart';
import '../modules/withdrawPoint/views/withdraw_point_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding(),
        children: [
          GetPage(
              name: _Paths.GAME_OPTION,
              page: () => const GameOptionView(),
              binding: GameOptionBinding(),
              children: [
                GetPage(
                  name: _Paths.CREATE_BET,
                  page: () => const CreateBetView(),
                  binding: CreateBetBinding(),
                ),
              ]),
        ]),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.GAME_RATE,
      page: () => const GameRateView(),
      binding: GameRateBinding(),
    ),
    GetPage(
      name: _Paths.ADD_POINT,
      page: () => AddPointView(),
      binding: AddPointBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_POINT,
      page: () => const WithdrawPointView(),
      binding: WithdrawPointBinding(),
    ),
    GetPage(
      name: _Paths.BID_HISTORY,
      page: () => const BidHistoryView(),
      binding: BidHistoryBinding(),
    ),
    GetPage(
      name: _Paths.WINNING_HISTORY,
      page: () => const WinningHistoryView(),
      binding: WinningHistoryBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.CHART,
      page: () => const ChartView(),
      binding: ChartBinding(),
    ),
    GetPage(
      name: _Paths.HOW_TO_PLAY,
      page: () => const HowToPlayView(),
      binding: HowToPlayBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.STAR_LINE,
      page: () => const StarLineView(),
      binding: StarLineBinding(),
    ),
    GetPage(
      name: _Paths.STAR_LINE_GAME_RATE,
      page: () => const StarLineGameRateView(),
      binding: StarLineGameRateBinding(),
    ),
    GetPage(
      name: _Paths.STAR_LINE_BID_HISTORY,
      page: () => const StarLineBidHistoryView(),
      binding: StarLineBidHistoryBinding(),
    ),
    GetPage(
      name: _Paths.STAR_LINE_WIN_HISTORY,
      page: () => const StarLineWinHistoryView(),
      binding: StarLineWinHistoryBinding(),
    ),
    GetPage(
      name: _Paths.STAR_LINE_CHART,
      page: () => const StarLineChartView(),
      binding: StarLineChartBinding(),
    ),
    GetPage(
      name: _Paths.FUND,
      page: () => const FundView(),
      binding: FundBinding(),
    ),

     GetPage(
      name: _Paths.GALI_RATE,
      page: () => const GaliRateView(),
      binding: GaliRateBinding(),
    ),
    GetPage(
      name: _Paths.GALI_HOME,
      page: () => const GaliHomeView(),
      binding: GaliHomeBinding(),
    ),
    GetPage(
      name: _Paths.GALI_BID,
      page: () => const GaliBidView(),
      binding: GaliBidBinding(),
    ),
    GetPage(
      name: _Paths.GALI_WIN,
      page: () => const GaliWinView(),
      binding: GaliWinBinding(),
    ),
    GetPage(
      name: _Paths.GALI_CHART,
      page: () => const GaliChartView(),
      binding: GaliChartBinding(),
    ),
  ];
}
