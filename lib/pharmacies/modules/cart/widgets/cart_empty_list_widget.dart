import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartEmptyListWidget extends StatelessWidget {
  const CartEmptyListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: AlwaysScrollableScrollPhysics(),
      children: [
        Column(
          children: <Widget>[
            SizedBox(height: 60),
            Stack(
              children: <Widget>[
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                        Colors.grey.withOpacity(0.6),
                        Colors.grey.withOpacity(0.2),
                      ])),
                  child: Icon(
                    Icons.assignment_outlined,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 70,
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
            Opacity(
              opacity: 0.3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "You don't have any order inside this status".tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
