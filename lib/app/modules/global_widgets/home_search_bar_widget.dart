import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../search/controllers/search_controller.dart' as searchController;
import 'filter_bottom_sheet_widget.dart';

class HomeSearchBarWidget extends StatelessWidget implements PreferredSize {
  final controller = Get.find<searchController.SearchController>();

  Widget buildSearchBar() {
    controller.heroTag.value = UniqueKey().toString();
    return Hero(
      tag: controller.heroTag.value,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            border: Border.all(
              color: Get.theme.focusColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.SEARCH, arguments: controller.heroTag.value);
          },
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 0),
                child: Icon(Icons.search, color: Get.theme.colorScheme.secondary),
              ),
              Expanded(
                child: Text(
                  "Search for doctors...".tr,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: Get.textTheme.bodyLarge,
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    FilterBottomSheetWidget(),
                    isScrollControlled: true,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Get.theme.focusColor.withOpacity(0.1),
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    children: [
                      Text("Filter".tr, style: Get.textTheme.bodyMedium),
                      Icon(
                        Icons.filter_list,
                        color: Get.theme.hintColor,
                        size: 21,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSearchBar();
  }

  @override
  Widget get child => buildSearchBar();

  @override
  Size get preferredSize => new Size(Get.width, 80);
}
