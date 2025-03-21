import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../providers/laravel_provider.dart';
import '../../global_widgets/home_search_bar_widget.dart';
import '../controllers/doctors_controller.dart';
import '../widgets/doctors_list_widget.dart';

class ClinicDoctorsView extends GetView<DoctorsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          if (!Get.find<LaravelApiClient>().isLoading(tasks: [
            'getClinicDoctors',
            'getClinicPopularDoctors',
            'getClinicMostRatedDoctors',
            'getClinicAvailableDoctors',
            'getClinicFeaturedDoctors'
          ])) {
            Get.find<LaravelApiClient>().forceRefresh();
            controller.refreshDoctors(showMessage: true);
            Get.find<LaravelApiClient>().unForceRefresh();
          }
        },
        child: CustomScrollView(
          controller: controller.scrollController,
          shrinkWrap: false,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              expandedHeight: 140,
              elevation: 0.5,
              primary: true,
              pinned: false,
              // collapsedHeight: 70,
              floating: true,
              iconTheme: IconThemeData(color: Get.theme.primaryColor),
              title: Text(
                controller.clinic.value.name,
                style: Get.textTheme.titleLarge?.merge(TextStyle(color: Get.theme.primaryColor)),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
                onPressed: () => {Get.back()},
              ),
              bottom: HomeSearchBarWidget(),
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 75),
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [Get.theme.colorScheme.secondary.withOpacity(1), Get.theme.colorScheme.secondary.withOpacity(0.2)],
                          begin: AlignmentDirectional.topStart,
                          //const FractionalOffset(1, 0),
                          end: AlignmentDirectional.bottomEnd,
                          stops: [0.1, 0.9],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                    ),
                  )).marginOnly(bottom: 42),
            ),
            SliverToBoxAdapter(
              child: Wrap(
                children: [
                  Container(
                    height: 60,
                    child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(SpecialityFilter.values.length, (index) {
                          var _filter = SpecialityFilter.values.elementAt(index);
                          return Obx(() {
                            return Padding(
                              padding: const EdgeInsetsDirectional.only(start: 20),
                              child: RawChip(
                                side: BorderSide(color: Colors.transparent),
                                elevation: 0,
                                label: Text(_filter.toString().tr),
                                labelStyle: controller.isSelected(_filter) ? Get.textTheme.bodyMedium?.merge(TextStyle(color: Get.theme.primaryColor)) : Get.textTheme.bodyMedium,
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                backgroundColor: Theme.of(context).focusColor.withOpacity(0.1),
                                selectedColor: Get.theme.colorScheme.secondary,
                                selected: controller.isSelected(_filter),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                showCheckmark: true,
                                checkmarkColor: Get.theme.primaryColor,
                                onSelected: (bool value) {
                                  controller.toggleSelected(_filter);
                                  controller.loadDoctorsOfSpeciality(filter: controller.selected.value);
                                },
                              ),
                            );
                          });
                        })),
                  ),
                  DoctorsListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
