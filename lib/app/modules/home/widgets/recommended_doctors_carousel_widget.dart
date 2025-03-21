import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../routes/app_routes.dart';
import '../controllers/home_controller.dart';

class RecommendedDoctorsCarouselWidget extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      //color: Get.theme.primaryColor,
      child: Obx(() {
        return ListView.builder(
            padding: EdgeInsets.only(bottom: 10),
            primary: false,
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemCount: controller.doctors.length,
            itemBuilder: (_, index) {
              var _doctor = controller.doctors.elementAt(index);
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.DOCTOR, arguments: {'doctor': _doctor, 'heroTag': 'recommended_carousel'});
                },
                child: Container(
                  width: 180,
                  margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 20, bottom: 10),
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
                    ],
                  ),
                  child: Column(
                    //alignment: AlignmentDirectional.topStart,
                    children: [
                      Hero(
                        tag: 'recommended_carousel' + _doctor.id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          child: CachedNetworkImage(
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: _doctor.firstImageUrl,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 100,
                            ),
                            // errorWidget: (context, url, error) => Icon(Icons.error_outline),
                            errorWidget: (context, url, error) => Image.asset('assets/icon/no_image.png' ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 90,
                                  child: Text(
                                    _doctor.name ?? '',
                                    maxLines: 2,
                                    style: Get.textTheme.bodyMedium?.merge(TextStyle(color: Get.theme.hintColor)),
                                  ),
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 5,
                                  children: [
                                    SizedBox(
                                      height: 32,
                                      child: Chip(
                                        elevation: 0,

                                        padding: EdgeInsets.all(0),
                                        label: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.star,
                                              color: Color(0xFFFFB24D),
                                              size: 18,
                                            ),
                                            Text(_doctor.rate.toString(),
                                                style: Get.textTheme.bodyMedium
                                                    ?.merge(TextStyle(color: Color(0xFFFFB24D),
                                                    height: 1.4))),
                                          ],
                                        ),
                                        backgroundColor: Color(0xFFFFB24D).withOpacity(0.15),
                                        shape: StadiumBorder(side: BorderSide(color: Colors.transparent))
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                           // السعر
                           /* Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Start from".tr,
                                  style: Get.textTheme.bodySmall,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (_doctor.getOldPrice > 0)
                                      Ui.getPrice(
                                        _doctor.getOldPrice,
                                        style: Get.textTheme.bodyLarge?.merge(TextStyle(color: Get.theme.focusColor, decoration: TextDecoration.lineThrough)),
                                      ),
                                    Ui.getPrice(
                                      _doctor.getPrice,
                                      style: Get.textTheme.bodyMedium?.merge(TextStyle(color: Get.theme.colorScheme.secondary)),
                                    ),
                                  ],
                                ),
                              ],
                            )*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
