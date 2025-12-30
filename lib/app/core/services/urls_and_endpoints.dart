class AllEndPoints {
  // static String baseUrl = 'http://192.168.64.154:5050/api/'; //android
  // static String baseUrl = 'http://192.168.122.154:5000/api/'; //android emulator
  // static String baseUrl = 'http://10.0.2.2:3000/api/'; //android emulator

  // static String baseUrl = 'http://10.185.97.154:5055/api/'; // server
  static String baseUrl = 'https://kalkimatka.live/api/'; /// server


  static String userRegister = 'auth/register/';
  static String userLogin = 'auth/login/';
  static String sendOTP = 'auth/send-otp/';
  static String changePassword = 'auth/change-password/';
  static String ressetPassword = 'auth/resset-password/';
  static String deleteData = 'auth/delete-data/';
  static String games = 'game/';
  static String startLineGames = 'starline/game/';
  static String gameRate = 'game/rate/';
  static String starLineGameRate = 'starline/game/rate/';
  static String profile = 'profile/';
  static String transaction = 'transaction/';
  static String addMoney = 'transaction/add/';
  static String withrawModey = 'transaction/withdraw/';
  static String bet = 'bet/';
  static String starLineBet = 'starline/bet/';
  static String winningHistory = 'winning/';
  static String startLineWinningHistory = 'starline/winning/';
  static String starLineResult = 'starline/result/';
  static String setting = 'setting/';
  static String withdraw = 'withdraw/';
  static String result = 'result/';
  static String image = 'image/';
  // gali routes
  static String gamesGali = 'gali/game/';
  static String gameRateGali = 'gali/game/rate/';
  static String betGali = 'gali/bet/';
  static String winningHistoryGali = 'gali/winning/';
  static String resultGali = 'gali/result/';
}

// keytool -genkey -v -keystore ./upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000  -alias upload
// keystore password= keystorePasswordGold
