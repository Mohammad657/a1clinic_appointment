/*
 * Copyright (c) 2020 .
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/payment_method_model.dart';
import '../controllers/checkout_controller.dart';

class PaymentMethodItemWidget extends GetWidget<CheckoutController> {
  PaymentMethodItemWidget({
    required PaymentMethod paymentMethod,
  }) : _paymentMethod = paymentMethod;

  final PaymentMethod _paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ThemeData theme = ThemeData();
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: Ui.getBoxDecoration(color: controller.getColor(_paymentMethod)),
        child: Theme(
          data: theme.copyWith(
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return null;
                    }
                    if (states.contains(MaterialState.selected)) {
                      return Get.theme.primaryColor;
                    }
                    return null;
                  }),
              trackColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return null;
                    }
                    if (states.contains(MaterialState.selected)) {
                      return Get.theme.primaryColor;
                    }
                    return null;
                  }),
            ),
            radioTheme: RadioThemeData(
              fillColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return null;
                    }
                    if (states.contains(MaterialState.selected)) {
                      return Get.theme.primaryColor;
                    }
                    return null;
                  }),
            ),
            checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return null;
                    }
                    if (states.contains(MaterialState.selected)) {
                      return Get.theme.primaryColor;
                    }
                    return null;
                  }),
            ),
          ),
          child: RadioListTile(
              value: _paymentMethod,
              groupValue: controller.selectedPaymentMethod.value,
              activeColor: Get.theme.colorScheme.secondary,
              onChanged: (PaymentMethod? value) {
                if (value?.wallet == null || (value?.wallet?.balance ?? 0) >= controller.appointment.value.getTotal()) {
                  controller.selectPaymentMethod(value!);
                }
              },
              title: Text(_paymentMethod.name, style: controller.getTitleTheme(_paymentMethod)).paddingOnly(bottom: 5),
              subtitle: _paymentMethod.wallet == null
                  ? Text(_paymentMethod.description, style: controller.getSubTitleTheme(_paymentMethod))
                  : Ui.getPrice(double.parse(_paymentMethod.description), style: controller.getSubTitleTheme(_paymentMethod)),
              secondary: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  imageUrl: _paymentMethod.logo.thumb,
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 60,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                ),
              )),
        ),
      );
    });
  }
}
