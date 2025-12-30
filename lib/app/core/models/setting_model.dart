import 'dart:convert';



class SettingModel  {
  final String? id;
  final String? telegramSupport;
  final String? whatsappSupport;
  final int? minimumDeposit;
  final int? minimumWithdraw;
  final String? paytmUpi;
  final String? phonepayUpi;
  final String? googlepayUpi;
  final String? withdrawOpenTime;
  final String? withdrawCloseTime;
  final bool? autoVerify;
  final String? howToPlay;
  final String? notice;

  const SettingModel({
    this.id,
    this.telegramSupport,
    this.whatsappSupport,
    this.minimumDeposit,
    this.minimumWithdraw,
    this.paytmUpi,
    this.phonepayUpi,
    this.googlepayUpi,
    this.withdrawOpenTime,
    this.withdrawCloseTime,
    this.autoVerify,
    this.howToPlay,
    this.notice,
  });

  factory SettingModel.fromMap(Map<String, dynamic> data) => SettingModel(
        id: data['_id'] as String?,
        telegramSupport: data['telegramSupport'] as String?,
        whatsappSupport: data['whatsappSupport'] as String?,
        minimumDeposit: data['minimumDeposit'] as int?,
        minimumWithdraw: data['minimumWithdraw'] as int?,
        paytmUpi: data['paytmUpi'] as String?,
        phonepayUpi: data['phonepayUpi'] as String?,
        googlepayUpi: data['googlepayUpi'] as String?,
        withdrawOpenTime: data['withdrawOpenTime'] as String?,
        withdrawCloseTime: data['withdrawCloseTime'] as String?,
        howToPlay: data['howToPlay'] as String?,
        notice: data['notice'] as String?,
        autoVerify: data['autoVerify'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'telegramSupport': telegramSupport,
        'whatsappSupport': whatsappSupport,
        'minimumDeposit': minimumDeposit,
        'minimumWithdraw': minimumWithdraw,
        'paytmUpi': paytmUpi,
        'phonepayUpi': phonepayUpi,
        'googlepayUpi': googlepayUpi,
        'withdrawOpenTime': withdrawOpenTime,
        'withdrawCloseTime': withdrawCloseTime,
        'howToPlay': howToPlay,
        'notice': notice,
        'autoVerify': autoVerify,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SettingModel].
  factory SettingModel.fromJson(String data) {
    return SettingModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SettingModel] to a JSON string.
  String toJson() => json.encode(toMap());

  SettingModel copyWith({
    String? id,
    String? telegramSupport,
    String? whatsappSupport,
    int? minimumDeposit,
    int? minimumWithdraw,
    String? paytmUpi,
    String? phonepayUpi,
    String? googlepayUpi,
    String? withdrawOpenTime,
    String? withdrawCloseTime,
    String? howToPlay,
    String? notice,
    bool? autoVerify,
  }) {
    return SettingModel(
      id: id ?? this.id,
      telegramSupport: telegramSupport ?? this.telegramSupport,
      whatsappSupport: whatsappSupport ?? this.whatsappSupport,
      minimumDeposit: minimumDeposit ?? this.minimumDeposit,
      minimumWithdraw: minimumWithdraw ?? this.minimumWithdraw,
      paytmUpi: paytmUpi ?? this.paytmUpi,
      phonepayUpi: phonepayUpi ?? this.phonepayUpi,
      googlepayUpi: googlepayUpi ?? this.googlepayUpi,
      withdrawOpenTime: withdrawOpenTime ?? this.withdrawOpenTime,
      withdrawCloseTime: withdrawCloseTime ?? this.withdrawCloseTime,
      howToPlay: howToPlay ?? this.howToPlay,
      notice: notice ?? this.notice,
      autoVerify: autoVerify ?? this.autoVerify,
    );
  }



  

  bool isCurrentTimeBetweenWithdrawTimes() {
    // final now = DateTime.now();
    // final currentTime = DateFormat('hh:mm a').format(now);
    // print(currentTime);
    // if (withdrawOpenTime != null && withdrawCloseTime != null) {
    //   final openTime = DateFormat('hh:mm a').parse(withdrawOpenTime!);
    //   final closeTime = DateFormat('hh:mm a').parse(withdrawCloseTime!);
    //   print(openTime);
    //   print(closeTime);

    //   return now.isAfter(openTime) && now.isBefore(closeTime);
    // }

    // return false;

    if (withdrawOpenTime != null && withdrawCloseTime != null) {
      String openTime = convert12HourTo24Hour(withdrawOpenTime.toString());
      String closeTime = convert12HourTo24Hour(withdrawCloseTime.toString());
      DateTime currentTime = DateTime.now();
      DateTime targetDateOpenTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        int.parse(openTime.split(':')[0]),
        int.parse(openTime.split(':')[1].split(' ')[0]),
      );
      DateTime targetDateCloseTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        int.parse(closeTime.split(':')[0]),
        int.parse(closeTime.split(':')[1].split(' ')[0]),
      );

      return currentTime.isAfter(targetDateOpenTime) &&
          currentTime.isBefore(targetDateCloseTime);
    }
    return false;
  }
}

String convert12HourTo24Hour(String time12Hour) {
  // Split the time into hours, minutes, and AM/PM
  List<String> parts = time12Hour.split(' ');
  String time = parts[0];
  String period = parts[1];

  // Split hours and minutes
  List<String> timeParts = time.split(':');
  int hours = int.parse(timeParts[0]);
  int minutes = int.parse(timeParts[1]);

  // Convert to 24-hour format
  if (period == 'PM' && hours < 12) {
    hours += 12;
  } else if (period == 'AM' && hours == 12) {
    hours = 0;
  }

  // Format the result
  String hoursStr = hours.toString().padLeft(2, '0');
  String minutesStr = minutes.toString().padLeft(2, '0');

  return '$hoursStr:$minutesStr';
}
