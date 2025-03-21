import 'parents/model.dart';

class Setting extends Model {
  String? appName;
  bool? enableStripe;
  String? defaultTax;
  String? defaultCurrency;
  String? fcmKey;
  bool? enablePaypal;
  String? defaultTheme;
  String? mainColor;
  String? mainDarkColor;
  String? secondColor;
  String? secondDarkColor;
  String? accentColor;
  String? accentDarkColor;
  String? scaffoldDarkColor;
  String? scaffoldColor;
  String? googleMapsKey;
  String? mobileLanguage;
  String? defaultCountryCode;
  String? appVersion;
  String? jitsiMeetLink;
  bool? enableVersion;
  bool? currencyRight;
  int? defaultCurrencyDecimalDigits;
  bool? enableRazorpay;
  String? distanceUnit;
  bool? enableOtp;
  List? modules;
  bool? enablePaymentBeforeAppointmentIsCompleted;

  Setting(
      {this.appName,
      this.enableStripe,
      this.defaultTax,
      this.defaultCurrency,
      this.fcmKey,
      this.enablePaypal,
      this.mainColor,
      this.mainDarkColor,
      this.secondColor,
      this.secondDarkColor,
      this.accentColor,
      this.accentDarkColor,
      this.scaffoldDarkColor,
      this.scaffoldColor,
      this.googleMapsKey,
      this.mobileLanguage,
      this.defaultCountryCode,
      this.appVersion,
      this.jitsiMeetLink,
      this.enableVersion,
      this.currencyRight,
      this.defaultCurrencyDecimalDigits,
      this.enableRazorpay,
      this.distanceUnit,
      this.enableOtp,
      this.modules,
      this.enablePaymentBeforeAppointmentIsCompleted
      });

  Setting.fromJson(Map<String, dynamic>? json) {
    appName = json?['app_name'];
    defaultTax = json?['default_tax'];
    defaultCurrency = json?['default_currency'];
    fcmKey = json?['fcm_key'];
    defaultTheme = json?['default_theme'];
    mainColor = json?['main_color'];
    mainDarkColor = json?['main_dark_color'];
    secondColor = json?['second_color'];
    secondDarkColor = json?['second_dark_color'];
    accentColor = json?['accent_color'];
    accentDarkColor = json?['accent_dark_color'];
    scaffoldDarkColor = json?['scaffold_dark_color'];
    scaffoldColor = json?['scaffold_color'];
    googleMapsKey = json?['google_maps_key'];
    mobileLanguage = json?['mobile_language'];
    defaultCountryCode = json?['default_country_code'];
    appVersion = json?['app_version'];
    jitsiMeetLink = stringFromJson(json,'jitsi_meet_link');
    enableVersion = boolFromJson(json, 'enable_version');
    currencyRight = boolFromJson(json, 'currency_right');
    enableRazorpay = boolFromJson(json, 'enable_razorpay');
    enableStripe = boolFromJson(json, 'enable_stripe');
    enablePaypal = boolFromJson(json, 'enable_paypal');
    defaultCurrencyDecimalDigits = int.tryParse(json?['default_currency_decimal_digits'] ?? '2') ?? 2;
    distanceUnit = stringFromJson(json, 'distance_unit');
    enableOtp = boolFromJson(json, 'enable_otp');
    enablePaymentBeforeAppointmentIsCompleted = boolFromJson(json, 'enable_payment_before_appointment_is_completed');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['app_name'] = this.appName;
    data['enable_stripe'] = this.enableStripe;
    data['default_tax'] = this.defaultTax;
    data['default_currency'] = this.defaultCurrency;
    data['fcm_key'] = this.fcmKey;
    data['enable_paypal'] = this.enablePaypal;
    data['main_color'] = this.mainColor;
    data['default_theme'] = this.defaultTheme;
    data['main_dark_color'] = this.mainDarkColor;
    data['second_color'] = this.secondColor;
    data['second_dark_color'] = this.secondDarkColor;
    data['accent_color'] = this.accentColor;
    data['accent_dark_color'] = this.accentDarkColor;
    data['scaffold_dark_color'] = this.scaffoldDarkColor;
    data['scaffold_color'] = this.scaffoldColor;
    data['google_maps_key'] = this.googleMapsKey;
    data['mobile_language'] = this.mobileLanguage;
    data['default_country_code'] = this.defaultCountryCode;
    data['app_version'] = this.appVersion;
    data['jitsi_meet_link'] = this.jitsiMeetLink;
    data['enable_version'] = this.enableVersion;
    data['currency_right'] = this.currencyRight;
    data['default_currency_decimal_digits'] = this.defaultCurrencyDecimalDigits;
    data['enable_razorpay'] = this.enableRazorpay;
    data['distance_unit'] = this.distanceUnit;
    data['enable_otp'] = this.enableOtp;
    data['enable_payment_before_appointment_is_completed'] = this.enablePaymentBeforeAppointmentIsCompleted;
    return data;
  }
}
