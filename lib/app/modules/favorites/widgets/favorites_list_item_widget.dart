/*
 * Copyright (c) 2020 .
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/favorite_model.dart';
import '../../../routes/app_routes.dart';

class FavoritesListItemWidget extends StatelessWidget {
  const FavoritesListItemWidget({
    Key? key,
    required Favorite favorite,
  })  : _favorite = favorite,
        super(key: key);

  final Favorite _favorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DOCTOR, arguments: {'doctor': _favorite.doctor, 'heroTag': 'favorite_list_item_carousel' + _favorite.id});
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
                  tag: 'favorite_list_item_carousel' + _favorite.id + _favorite.doctor.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      imageUrl: _favorite.doctor.firstImageUrl,
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
                if (_favorite.doctor.clinic.available)
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
               /* if (!_favorite.doctor.clinic.available)
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
                        _favorite.doctor.name ?? '',
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
                                  Text(_favorite.doctor.rate.toString(), style: Get.textTheme.bodyMedium?.merge(TextStyle(color: Get.theme.colorScheme.secondary, height: 1.4))),
                                ],
                              ),
                              backgroundColor: Get.theme.colorScheme.secondary.withOpacity(0.15),
                              shape: StadiumBorder(side: BorderSide(color: Colors.transparent)),
                            ),
                          ),
                          Text(
                            "From (%s)".trArgs([_favorite.doctor.totalReviews.toString()]),
                            style: Get.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (_favorite.doctor.getOldPrice > 0)
                            Ui.getPrice(
                              _favorite.doctor.getOldPrice,
                              style: Get.textTheme.bodyMedium?.merge(TextStyle(color: Get.theme.focusColor, decoration: TextDecoration.lineThrough)),
                            ),
                          Ui.getPrice(
                            _favorite.doctor.getPrice,
                            style: Get.textTheme.titleLarge,
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
                          _favorite.doctor.clinic.name,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1, color: Get.theme.dividerColor,),
                  // Wrap(
                  //   spacing: 5,
                  //   children: List.generate(_favorite.options.length, (index) {
                  //     return Container(
                  //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  //       child: Text(_favorite.options.elementAt(index).name, style: Get.textTheme.bodySmall?.merge(TextStyle(fontSize: 10))),
                  //       decoration: BoxDecoration(
                  //           color: Get.theme.primaryColor,
                  //           border: Border.all(
                  //             color: Get.theme.focusColor.withOpacity(0.2),
                  //           ),
                  //           borderRadius: BorderRadius.all(Radius.circular(20))),
                  //     );
                  //   }),
                  //   runSpacing: 5,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
