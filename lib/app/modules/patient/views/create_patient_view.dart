import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../models/media_model.dart';
import '../../global_widgets/gender_field_widget.dart';
import '../../global_widgets/images_field_widget.dart';
import '../../global_widgets/phone_field_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/create_patient_controller.dart';

class CreatePatientView extends GetView<CreatePatientController> {

  @override
  Widget build(BuildContext context) {
    controller.patientForm = new GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Patient".tr,
            style: context.textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () => Get.back()
          ),
          elevation: 0,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5)),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    controller.createPatientForm();
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Get.theme.colorScheme.secondary,
                  child: Text("Create".tr, style: Get.textTheme.bodyMedium?.merge(TextStyle(color: Get.theme.primaryColor))),
                  elevation: 0,
                  highlightElevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                ),
              ),
              SizedBox(width: 10),
              MaterialButton(
                onPressed: () {
                  controller.resetPatientForm();
                },
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Get.theme.hintColor.withOpacity(0.1),
                child: Text("Reset".tr, style: Get.textTheme.bodyMedium),
                elevation: 0,
                highlightElevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
              ),
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 20),
        ),
        body: Form(
          key: controller.patientForm,
          child: SingleChildScrollView(
            primary: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Patient details".tr, style: Get.textTheme.headlineSmall).paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
                Text("Change the following details and save them".tr, style: Get.textTheme.bodySmall).paddingSymmetric(horizontal: 22, vertical: 5),
                Obx(() {
                  return ImagesFieldWidget(
                    label: "Images".tr,
                    field: 'image',
                    tag: controller.patientForm.hashCode.toString(),
                    initialImages: controller.patient.value.images,
                    uploadCompleted: (uuid) {
                      controller.patient.update((val) {
                        val?.images = val.images ?? [];
                        val?.images.add(new Media(id: uuid));
                      });
                    },
                    reset: (uuids) {
                      controller.patient.update((val) {
                        val?.images.clear();
                      });
                    },
                  );
                }),
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.first_name = input!,
                  // onChanged: (input) => controller.patient.value.first_name = input,
                  validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                  initialValue: controller.patient.value.first_name,
                  hintText: "ahmed".tr,
                  labelText: "First Name".tr,
                  iconData: Icons.person_outline,
                ),
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.last_name = input!,
                  // onChanged: (input) => controller.patient.value.last_name = input,
                  validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                  initialValue: controller.patient.value.last_name,
                  hintText: "naji".tr,
                  labelText: "Last Name".tr,
                  iconData: Icons.person_outline,
                ),
                PhoneFieldWidget(
                  labelText: "Phone Number".tr,
                  hintText: "0593166156".tr,
                  initialCountryCode: Helper.getPhoneNumber(controller.patient.value.phone_number).countryISOCode,
                  initialValue: Helper.getPhoneNumber(controller.patient.value.phone_number).number,
                  onSaved: (phone) {
                    controller.patient.value.phone_number = phone!.completeNumber;
                  },
                ),
              /*  PhoneFieldWidget(
                  labelText: "Mobile Number".tr,
                  hintText: "0593166156".tr,
                  initialCountryCode: Helper.getPhoneNumber(controller.patient.value.mobile_number).countryISOCode,
                  initialValue: Helper.getPhoneNumber(controller.patient.value.mobile_number).number,
                  onSaved: (phone) {
                    controller.patient.value.mobile_number = phone!.completeNumber;
                  },
                ),*/
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.age = input!,
                  validator: (input) => input!.length < 1 ? "Should be more than 1 number".tr : null,
                  initialValue: controller.patient.value.age,
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: "55".tr,
                  labelText: "Age".tr,
                  iconData: Icons.account_box,
                ),
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.height = input!,
                  validator: (input){
                    if (input!.length < 2) {
                      return "Should be more than 2 numbers".tr;
                    }
                    else if (double.parse(input) < 3) {
                      return "Enter Your Height on CM".tr;
                    } else {
                      return null;
                    }
                  },
                  initialValue: controller.patient.value.height,
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: "180".tr,
                  labelText: "Height".tr,
                  iconData: Icons.height,
                  suffixIcon: Text(
                      "CM".tr,
                      style: Get.textTheme.bodySmall,
                  ).marginOnly(top: 14),
                ),
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.weight = input!,
                  validator: (input) => input!.length < 1 ? "Should be more than 1 number".tr : null,
                  initialValue: controller.patient.value.weight,
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: "60".tr,
                  labelText: "Weight".tr,
                  iconData: Icons.monitor_weight_outlined,
                  suffixIcon: Text(
                    "KG".tr,
                    style: Get.textTheme.bodySmall,
                  ),
                ),
                Obx((){
                 return GenderFieldWidget(
                   items: controller.getSelectGenderItem(),
                   iconData: Icons.male_rounded,
                   onChanged: (selectedValue) {
                     controller.selectedGender.value = selectedValue.toString();
                   },
                   onSaved: (selectedValue) {
                     controller.patient.value.gender = selectedValue.toString();
                   },
                   value: controller.selectedGender.value,
                   labelText:"Gender".tr,
                 );
               }),
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.medical_history = input ?? '',
                  initialValue: Html(data: controller.patient.value.medical_history ?? '').data,
                  hintText: "Your medical history".tr,
                  labelText: "Medical history".tr,
                  iconData: Icons.medical_information_outlined,
                ),
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.notes = input ?? '',
                  initialValue: Html(data: controller.patient.value.notes ?? '').data,
                  hintText: "Your notes".tr,
                  labelText: "Notes".tr,
                  iconData: Icons.article_outlined,
                ),

              ],
            ),

          ),
        ));
  }
}
