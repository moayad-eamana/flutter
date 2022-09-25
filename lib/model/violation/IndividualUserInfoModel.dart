import 'package:flutter/widgets.dart';

class IndividualUserInfoModel {
  //بينات رئيسية
  //رقم الهوية او رقم سجل
  TextEditingController identityOrCommericalNumber = TextEditingController();
  //إسم الفرد أو سم اشركة
  TextEditingController individualNameOrCompanyName = TextEditingController();

  //for set
  void settestdata() {
    //json body
    var json = ({
      // "violationDate": this.violationDate.text,
      "violationType": "",
      "violationTypeID": "",
      "commercialNumber": this.identityOrCommericalNumber.text,
      "amount": "",
      "userType": "",
      "licenseNumber": "",
      "additionalDesc": "",
      "status": "",
      // "mobileNumber": this.mobile.text,
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
