import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/main_drawer_widget.dart';
import "../../root/controllers/root_controller.dart";
import '../controllers/checkout_controller.dart';

class RejectionView extends GetView<CheckoutController> {
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments ?? {};
    return Scaffold(
      drawer: MainDrawerWidget(),
      appBar: AppBar(
        title: Text(
          arguments['title'] ?? "Rejection".tr,
          style: context.textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Get.theme.hintColor),
          onPressed: () => {Scaffold.of(context).openDrawer()},
        ),
        elevation: 0,
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                        Colors.red.withOpacity(1),
                        Colors.red.withOpacity(0.2),
                      ])),
                  child: Icon(
                    Icons.error_outline,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 90,
                  ),
                ),
                Positioned(
                  right: -30,
                  bottom: -50,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(150),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  top: -50,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(150),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            Text(
              arguments['short_message'] ?? "Sorry an error occurred".tr,
              textAlign: TextAlign.center,
              style: Get.textTheme.displaySmall,
            ),
            SizedBox(height: 10),
            Opacity(
              opacity: 0.3,
              child: Text(
                arguments['long_message'] ?? "Your appointment has been successfully submitted, you will receive a confirmation soon".tr,
                textAlign: TextAlign.center,
                style: Get.textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBlockButtonWidget(),
    );
  }

  Widget buildBlockButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5)),
        ],
      ),
      child: BlockButtonWidget(
          text: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "My Appointments".tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.titleLarge?.merge(
                    TextStyle(color: Get.theme.primaryColor),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Get.theme.primaryColor, size: 20)
            ],
          ),
          color: Get.theme.colorScheme.secondary,
          onPressed: () {
            Get.find<RootController>().changePage(1);
          }).paddingOnly(bottom: 20, right: 20, left: 20),
    );
  }
}
