import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/user_model.dart';
import '../../../repositories/user_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/firebase_messaging_service.dart';
import '../../../services/settings_service.dart';
import '../../root/controllers/root_controller.dart';
import 'dart:async';

import '../../settings/controllers/language_controller.dart';

class AuthController extends GetxController {
  final Rx<User> currentUser = Get.find<AuthService>().user;
  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<FormState> registerFormKey;
  late GlobalKey<FormState> forgotPasswordFormKey;
  final hidePassword = true.obs;
  final loading = false.obs;
  final smsSent = ''.obs;
  var time=60;
  late UserRepository _userRepository;



  AuthController() {
    loginFormKey = new GlobalKey<FormState>();
    _userRepository = UserRepository();

  }

  /*void login() async {
    Get.focusScope?.unfocus();
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      loading.value = true;
      try {
        await Get.find<FireBaseMessagingService>().setDeviceToken();
        currentUser.value = await _userRepository.login(currentUser.value);
        await _userRepository.signInWithEmailAndPassword(currentUser.value.email, currentUser.value.apiToken);
        await Get.find<RootController>().changePage(0);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }*/

  void loginByPhone() async {
    Get.focusScope?.unfocus();
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      loading.value = true;
      try {
        loading.value = false;
        if (Get.find<SettingsService>().setting.value.enableOtp ?? true) {
          await Get.find<FireBaseMessagingService>().setDeviceToken();

          await _userRepository.checkUser(currentUser.value);

          print(
              "Otp Enable:${Get.find<SettingsService>().setting.value.enableOtp}");
        } else {
          loading.value = false;

          currentUser.value = await _userRepository.loginWithOutOtp(currentUser.value);
          print(
              "Disable  Otp  ahmed :${Get.find<SettingsService>().setting.value.enableOtp}");

        }
        await Get.find<RootController>().changePage(0);

       await _userRepository.signInWithEmailAndPassword(currentUser.value.email, currentUser.value.apiToken);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }

 /* void register() async {
    Get.focusScope?.unfocus();
    if (registerFormKey.currentState!.validate()) {
      registerFormKey.currentState!.save();
      loading.value = true;
      try {
        if (Get.find<SettingsService>().setting.value.enableOtp ?? false ) {
          await _userRepository.sendCodeToPhone();
          loading.value = false;
          await Get.toNamed(Routes.PHONE_VERIFICATION);
        } else {
          await Get.find<FireBaseMessagingService>().setDeviceToken();
          currentUser.value = await _userRepository.register(currentUser.value);
          await _userRepository.signUpWithEmailAndPassword(currentUser.value.email, currentUser.value.apiToken);
          await Get.find<RootController>().changePage(0);
        }
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }*/

  void registerByPhone() async {
    Get.focusScope?.unfocus();
    if (registerFormKey.currentState!.validate()) {
      registerFormKey.currentState!.save();
      loading.value = true;
      try {
        loading.value = false;
        await _userRepository.registerByPhone(currentUser.value);

       // await Get.toNamed(Routes.PHONE_VERIFICATION);

      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }



  Future<void> verifyPhone() async {
    try {
      loading.value = false;
      currentUser.value = await _userRepository.checkOtpAndLogin(currentUser.value,smsSent.value);
      await Get.find<FireBaseMessagingService>().setDeviceToken();
   //   currentUser.value = await _userRepository.register(currentUser.value);
    //  await _userRepository.signUpWithEmailAndPassword(currentUser.value.email, currentUser.value.apiToken);


      await Get.find<RootController>().changePage(0);
    } catch (e) {
    //  Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }


 /* Future<void> verifyPhone() async {// قبل تعديلي
    try {
      loading.value = true;
      await _userRepository.verifyPhone(smsSent.value);
      await Get.find<FireBaseMessagingService>().setDeviceToken();
      currentUser.value = await _userRepository.register(currentUser.value);
      await _userRepository.signUpWithEmailAndPassword(currentUser.value.email, currentUser.value.apiToken);
      await Get.find<RootController>().changePage(0);
    } catch (e) {
      Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }*/

  Future<void> resendOTPCode() async {
    loading.value = false;
    try {

      await _userRepository.resendOTPCode(currentUser.value,smsSent.value);

    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {

      loading.value = false;
    }

  }

  /*Future<void> resendOTPCode() async {
    await _userRepository.sendCodeToPhone();
  }*/



  void sendResetLink() async {
    Get.focusScope?.unfocus();
    if (forgotPasswordFormKey.currentState!.validate()) {
      forgotPasswordFormKey.currentState!.save();
      loading.value = true;
      try {
        await _userRepository.sendResetLinkEmail(currentUser.value);
        loading.value = false;
        Get.showSnackbar(Ui.SuccessSnackBar(message: "The Password reset link has been sent to your email: ".tr + currentUser.value.email));
        Timer(Duration(seconds: 5), () {
          Get.offAndToNamed(Routes.LOGIN);
        });
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }
}
