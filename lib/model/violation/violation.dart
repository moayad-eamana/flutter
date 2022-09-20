import 'package:flutter/widgets.dart';

class IndividualUserInfoModel {
  //بينات رئيسية
  //رقم الهوية او رقم سجل
  TextEditingController identityOrCommericalNumber = TextEditingController();
  //إسم الفرد أو سم اشركة
  TextEditingController IndividualNameOrCompanyName = TextEditingController();
  //رقم الجوال
  TextEditingController mobile = TextEditingController();
  //البلدية التابعة
  TextEditingController baldea = TextEditingController();
  //إسم الحي
  TextEditingController Neighborhoodname = TextEditingController();
  //إسم الشارع
  TextEditingController Streetname = TextEditingController();
  //الوصف المختصر
  TextEditingController ShortDescription = TextEditingController();
  //ملاحظات الموظف
  TextEditingController employeeDescription = TextEditingController();

  //مخالفة رخصة البناء
  //رقم الرخصة
  TextEditingController licensenumber = TextEditingController();
  //اسم المالك
  // TextEditingController IndividualNameOrCompanyName = TextEditingController();
  //رقم الهوية / سجل
  // TextEditingController identityOrCommericalNumber = TextEditingController();
  //اسم المكتب الهندسي
  TextEditingController companyEngName = TextEditingController();
  //مساحة
  TextEditingController space = TextEditingController();
  //نوع الرخصة
  TextEditingController licensetype = TextEditingController();

  //مخالفة لسجل تجاري
  //سجل تجاري
  // TextEditingController identityORcommercialnumber = TextEditingController();
  //اسم المؤسسة /الشركة
  // TextEditingController IndividualNameOrCompanyName = TextEditingController();

  //مخالفات الحفريات
  //رقم الطلب
  TextEditingController ordernumber = TextEditingController();
  //إسم المنشأة
  // TextEditingController IndividualNameOrCompanyName = TextEditingController();
  //رقم السجل
  // TextEditingController identityOrCommericalNumber = TextEditingController();
  //الجهة المستفيدة
  TextEditingController beneficiary = TextEditingController();
  //مساحة الحفر
  TextEditingController spacehafreat = TextEditingController();
  //وصف الموقع
  TextEditingController sitedescription = TextEditingController();

  //مخالفة رخص المحلات
  //رخصة محل
  TextEditingController shoplicenses = TextEditingController();
  //إسم المنشأة
  // TextEditingController IndividualNameOrCompanyName = TextEditingController();
  //رقم السجل أو الهوية
  // TextEditingController identityOrCommericalNumber = TextEditingController();
  //تاريخ انتهاء الرخصة
  TextEditingController LicenseExpirDate = TextEditingController();
  //مساحة المحل
  TextEditingController shopespace = TextEditingController();
  //النشاط
  TextEditingController activity = TextEditingController();

  //مخالفة سكن جماعي
//رخصة سكن جماعي
  TextEditingController licenseskn = TextEditingController();
  //اسم المنشأة
  // TextEditingController IndividualNameOrCompanyName = TextEditingController();
  //رقم السجل أو الهوية
  // TextEditingController identityOrCommericalNumber = TextEditingController();
  //تاريخ إنتهاء الرخصة
  // TextEditingController DormitoryLicenseExpireDate = TextEditingController();
  //مساحة
  TextEditingController dormitoryArea = TextEditingController();
  //نوع العقار
  TextEditingController eqartype = TextEditingController();

  //مخالفة رخص اللوحات الاعلانية
//اسم البلدية
  TextEditingController baladeaname = TextEditingController();
  //رخصة لوحة إعلانية
  TextEditingController addslicenses = TextEditingController();
  //رقم السجل أو الهوية
  // TextEditingController identityOrCommericalNumber = TextEditingController();
  //عنوان اللوحة
  // TextEditingController IndividualNameOrCompanyName = TextEditingController();
  //مساحة اللوحة
  TextEditingController advDistance = TextEditingController();
  //تاريخ إنتهاء الرخصة
  // TextEditingController LicenseExpirDate = TextEditingController();

  //for set
  void settestdata() {
    //json body
    var json = ({
      "violationDate": "",
      "violationType": "",
      "violationTypeID": "",
      "commercialNumber": "",
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
