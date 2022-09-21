import 'package:flutter/widgets.dart';

class IndividualUserInfoModel {
  //بينات رئيسية
  //رقم الهوية او رقم سجل
  TextEditingController identityOrCommericalNumber = TextEditingController();
  //إسم الفرد أو سم اشركة
  TextEditingController individualNameOrCompanyName = TextEditingController();
  //رقم الجوال
  TextEditingController mobile = TextEditingController();
  //البلدية التابعة
  TextEditingController baldea = TextEditingController();
  //إسم الحي
  TextEditingController neighborhoodname = TextEditingController();
  //إسم الشارع
  TextEditingController streetname = TextEditingController();
  //الوصف المختصر
  TextEditingController ShortDescription = TextEditingController();
  //ملاحظات الموظف
  TextEditingController employeeDescription = TextEditingController();

  //مخالفة رخصة البناء
  //رقم الرخصة
  TextEditingController buildingLicense = TextEditingController();
  //اسم المالك
  // TextEditingController individualNameOrCompanyName = TextEditingController();
  //رقم الهوية / سجل
  // TextEditingController identityOrCommericalNumber = TextEditingController();
  //اسم المكتب الهندسي
  TextEditingController companyEngName = TextEditingController();
  //مساحة
  TextEditingController areaBuildingLic = TextEditingController();
  //نوع الرخصة locOrPurposeDesc ?
  TextEditingController licensetype = TextEditingController();

  //مخالفة لسجل تجاري
  //سجل تجاري
  // TextEditingController identityORcommercialnumber = TextEditingController();
  //اسم المؤسسة /الشركة
  // TextEditingController individualNameOrCompanyName = TextEditingController();

  //مخالفات الحفريات
  //رقم الطلب
  TextEditingController diggingLicense = TextEditingController();
  //إسم المنشأة
  // TextEditingController individualNameOrCompanyName = TextEditingController();
  //رقم السجل
  // TextEditingController identityOrCommericalNumber = TextEditingController();
  //الجهة المستفيدة
  TextEditingController beneficiary = TextEditingController();
  //مساحة الحفر
  TextEditingController diggingArea = TextEditingController();
  //وصف الموقع
  TextEditingController locOrPurposeDesc = TextEditingController();

  //مخالفة رخص المحلات
  //رخصة محل
  TextEditingController shoplicenses = TextEditingController();
  //إسم المنشأة
  // TextEditingController individualNameOrCompanyName = TextEditingController();
  //رقم السجل أو الهوية
  // TextEditingController identityOrCommericalNumber = TextEditingController();
  //تاريخ انتهاء الرخصة
  TextEditingController licenseExpirDate = TextEditingController();
  //مساحة المحل
  TextEditingController storeDistance = TextEditingController();
  //النشاط
  TextEditingController activity = TextEditingController();

  //مخالفة سكن جماعي
//رخصة سكن جماعي
  TextEditingController dormitoryLicense = TextEditingController();
  //اسم المنشأة
  // TextEditingController individualNameOrCompanyName = TextEditingController();
  //رقم السجل أو الهوية
  // TextEditingController identityOrCommericalNumber = TextEditingController();
  //تاريخ إنتهاء الرخصة
  TextEditingController dormitoryLicenseExpireDate = TextEditingController();
  //مساحة
  TextEditingController dormitoryArea = TextEditingController();
  //نوع العقار
  TextEditingController dormitoryType = TextEditingController();

  //مخالفة رخص اللوحات الاعلانية
//اسم البلدية
  TextEditingController baladeaname = TextEditingController();
  //رخصة لوحة إعلانية
  TextEditingController advboardlicense = TextEditingController();
  //رقم السجل أو الهوية
  // TextEditingController identityOrCommericalNumber = TextEditingController();
  //عنوان اللوحة
  // TextEditingController individualNameOrCompanyName = TextEditingController();
  //مساحة اللوحة
  TextEditingController advboardDistance = TextEditingController();
  //تاريخ إنتهاء الرخصة
  // TextEditingController LicenseExpirDate = TextEditingController();

  String ViolationSelected = "";

  //بنود
  //تاريخ المخالفة
  TextEditingController violationDate = TextEditingController();
  //الوحدة
  TextEditingController unit = TextEditingController();
  //التكرار
  TextEditingController repetition = TextEditingController();
  //القيمة المطبقة
  TextEditingController bunudvalue = TextEditingController();

  //for set
  void settestdata() {
    //json body
    var json = ({
      "violationDate": this.violationDate.text,
      "violationType": "",
      "violationTypeID": "",
      "commercialNumber": this.identityOrCommericalNumber.text,
      "amount": "",
      "userType": "",
      "licenseNumber": "",
      "additionalDesc": "",
      "status": "",
      "mobileNumber": this.mobile.text,
      "CreateType": "",
      "municipalityCode": "",
      "municipalityName": "",
      "author": "",
      "editor": "",
      "transferedDepartment": "",
      "createdDepartment": "",
      "violationRulesAssigned": [
        {
          "violationID": "",
          "ruleID": "",
          "count": "",
          "assignedValue": "",
          "manualAmount": ""
        }
      ],
      "violationAttachment": [
        {"itemID": "", "listId ": "", "fileName": ""}
      ]
    });
    print(json);
  }

  // IndividualUserInfoModel(
  //     this.NID,
  //     this.Name,
  //     this.mobile,
  //     this.baldea,
  //     this.Neighborhoodname,
  //     this.Streetname,
  //     this.ShortDescription,
  //     this.EmployeeDescription);
}
