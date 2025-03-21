import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/setting_model.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../settings/controllers/language_controller.dart';
import '../controllers/auth_controller.dart';

class PhoneVerificationView extends StatefulWidget {
  @override
  State<PhoneVerificationView> createState() => _PhoneVerificationViewState();
}

class _PhoneVerificationViewState extends State<PhoneVerificationView> {
  final Setting _settings = Get.find<SettingsService>().setting.value;
  var controller = Get.find<AuthController>();

  late Timer _timer;


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (controller.time == 0) {
          setState(() {
            timer.cancel();
            controller.time=60;
          });
        } else {
          setState(() {
            controller.time--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Phone Verification".tr,
              style: Get.textTheme.titleLarge
                  ?.merge(TextStyle(color: context.theme.primaryColor)),
            ),
            centerTitle: true,
            backgroundColor: Get.theme.colorScheme.secondary,
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: new IconButton(
              icon:
              new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
              onPressed: () => {Get.back()},
            ),
          ),
          body: ListView(
            primary: true,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 180,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.secondary,
                      borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Get.theme.focusColor.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5)),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            _settings.appName ?? "",
                            style: Get.textTheme.titleLarge?.merge(TextStyle(
                                color: Get.theme.primaryColor, fontSize: 24)),
                          ),
                          SizedBox(height: 5),
                          /* Text(
                            "Welcome to the best doctor provider system!".tr,
                            style: Get.textTheme.bodySmall?.merge(TextStyle(color: Get.theme.primaryColor)),
                            textAlign: TextAlign.center,
                          ),*/
                          // Text("Fill the following credentials to login your account", style: Get.textTheme.bodySmall?.merge(TextStyle(color: Get.theme.primaryColor))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: Ui.getBoxDecoration(
                      radius: 14,
                      border:
                      Border.all(width: 5, color: Get.theme.primaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/icon/icon.png',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (controller.loading.isTrue) {
                  return CircularLoadingWidget(height: 300);
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "We sent the OTP code to your phone, please check it and enter below"
                            .tr,
                        style: Get.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ).paddingSymmetric(horizontal: 20, vertical: 20),
                      TextFieldWidget(
                        labelText: "OTP Code".tr,
                        hintText: "- - - -".tr,

                        style: Get.textTheme.headlineMedium!
                            .merge(TextStyle(letterSpacing: 8)),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (input) => controller.smsSent.value = input,
                        maxLength: 4,

                        // iconData: Icons.add_to_home_screen_outlined,
                      ),
                      BlockButtonWidget(
                        onPressed: () async {
                          await controller.verifyPhone();
                        },
                        color: Get.theme.colorScheme.secondary,
                        text: Text(
                          "Verify".tr,
                          style: Get.textTheme.titleLarge
                              ?.merge(TextStyle(color: Get.theme.primaryColor)),
                        ),
                      ).paddingSymmetric(vertical: 30, horizontal: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {

                              controller.resendOTPCode();
                            },
                            child: Text("Resend the OTP Code Again After".tr),
                          ),Text(controller.time==10?" ":"${controller.time.toString()}")
                        ],
                      )
                    ],
                  );
                }
              })
            ],
          )),
    );
  }
}
