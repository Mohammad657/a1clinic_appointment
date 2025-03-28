/*
 * Copyright (c) 2020 .
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/doctor_model.dart';
import '../../../routes/app_routes.dart';

class SearchServicesListItemWidget extends StatelessWidget {
  const SearchServicesListItemWidget({
    Key? key,
    required Doctor doctor,
  })  : _doctor = doctor,
        super(key: key);

  final Doctor _doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DOCTOR, arguments: {'doctor': _doctor, 'heroTag': 'search_list'});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: Ui.getBoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Hero(
                  tag: 'search_list' + _doctor.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      imageUrl: _doctor.firstImageUrl,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 80,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error_outline),
                    ),
                  ),
                ),
                if (_doctor.available)
                  Container(
                    width: 80,
                    child: Text("Available".tr,
                        maxLines: 1,
                        style: Get.textTheme.bodyMedium?.merge(
                          TextStyle(color: Colors.green, height: 1.4, fontSize: 10),
                        ),
                        softWrap: false,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                  ),
              /*  if (!_doctor.available)
                  Container(
                    width: 80,
                    child: Text("Offline".tr,
                        maxLines: 1,
                        style: Get.textTheme.bodyMedium?.merge(
                          TextStyle(color: Colors.grey, height: 1.4, fontSize: 10),
                        ),
                        softWrap: false,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                  ),*/
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Wrap(
                runSpacing: 10,
                alignment: WrapAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        _doctor.name ?? '',
                        style: Get.textTheme.bodyMedium,
                        maxLines: 3,
                        // textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1, color: Get.theme.dividerColor,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 5,
                        children: [
                          SizedBox(
                            height: 32,
                            child: Chip(
                              padding: EdgeInsets.all(0),
                              label: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Get.theme.colorScheme.secondary,
                                    size: 18,
                                  ),
                                  Text(_doctor.rate.toString(), style: Get.textTheme.bodyMedium?.merge(TextStyle(color: Get.theme.colorScheme.secondary, height: 1.4))),
                                ],
                              ),
                              backgroundColor: Get.theme.colorScheme.secondary.withOpacity(0.15),
                              shape: StadiumBorder(side: BorderSide(color: Colors.transparent)),
                            ),
                          ),
                          Text(
                            "From (%s)".trArgs([_doctor.totalReviews.toString()]),
                            style: Get.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Column(
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
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.build_circle_outlined,
                        size: 18,
                        color: Get.theme.focusColor,
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          _doctor.clinic.name,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 18,
                        color: Get.theme.focusColor,
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          _doctor.clinic.address?.address ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1, color: Get.theme.dividerColor,),
                  Wrap(
                    spacing: 5,
                    children: List.generate(_doctor.subSpecialities.length, (index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Text(_doctor.subSpecialities.elementAt(index).name, style: Get.textTheme.bodySmall?.merge(TextStyle(fontSize: 10))),
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            border: Border.all(
                              color: Get.theme.focusColor.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      );
                    }),
                    runSpacing: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
