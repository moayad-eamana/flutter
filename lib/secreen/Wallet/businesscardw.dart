import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/Wallet/AndroidWallet.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vcard_maintained/vcard_maintained.dart';

class businesscardw extends StatefulWidget {
  Function? function;
  String lang;
  businesscardw(this.function, this.lang);

  @override
  State<businesscardw> createState() => _businesscardwState();
}

class _businesscardwState extends State<businesscardw> {
  String vcarddate = "";
  var vCard = VCard();
  void setvcard() {
    vCard.firstName = sharedPref.getString("FirstName").toString();
    vCard.lastName = sharedPref.getString("LastName").toString();
    vCard.cellPhone = sharedPref.getString("MobileNumber").toString();
    vCard.email = sharedPref.getString("Email").toString() + "@eamana.gov.sa";
    vCard.organization = "أمانة المنطقة الشرقية";
    vCard.jobTitle = sharedPref.getString("Title") == "" ||
            sharedPref.getString("Title") == null
        ? sharedPref.getString("JobName")
        : sharedPref.getString("Title");

    setState(() {
      vcarddate = vCard.getFormattedString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setvcard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //   height: 100.h,
      width: 100.w,
      child: Column(
        children: [
          InkWell(
            onTap: widget.function != null
                ? () {
                    widget.function!();
                  }
                : null,
            child: Card(
                color: Colors.grey[200],
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.5,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        textDirection: widget.lang == "en"
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.lang == "en"
                                ? "Eastern Province Municipality"
                                : "  أمانة المنطقة الشرقية  ",
                            style: TextStyle(
                                color: baseColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Image.asset(
                            "assets/SVGs/amanah-v.png",
                            width: 80,
                            height: 80,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: widget.lang == "en"
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        children: [
                          CachedNetworkImage(
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://archive.eamana.gov.sa/TransactFileUpload" +
                                    sharedPref.getString("ImageURL").toString(),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/image/blank-profile.png",
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.lang == "en" ? "Name" : "الإسم",
                                  style: subtitleTx(baseColorText),
                                ),
                                Text(
                                  widget.lang == "en"
                                      ? sharedPref.getString("FullNameEN") ?? ""
                                      : sharedPref.getString("EmployeeName") ??
                                          "",
                                  style: titleTx(baseColor),
                                  maxLines: 4,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: widget.lang == "en"
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Text(
                          widget.lang == "en" ? "Position" : "المنصب",
                          style: subtitleTx(baseColorText),
                        ),
                      ),
                      Align(
                        alignment: widget.lang == "en"
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Text(
                          jobNameOrTitleEnOrAr(widget.lang),
                          style: TextStyle(
                            color: baseColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.lang == "en"
                                ? "Job Number"
                                : "الرقم الوظيفي",
                            style: subtitleTx(baseColorText),
                          ),
                          Text(
                            widget.lang == "en"
                                ? "Mobile Number"
                                : 'رقم الجوال',
                            style: subtitleTx(baseColorText),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            EmployeeProfile.getEmployeeNumber(),
                            style: subtitleTx(baseColor),
                          ),
                          Text(
                            sharedPref.getString("MobileNumber") ?? "",
                            style: subtitleTx(baseColor),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(right: 18),
                          width: 100,
                          height: 100,
                          color: Colors.white,
                          padding: EdgeInsets.all(3),
                          child: BarcodeWidget(
                            barcode:
                                Barcode.qrCode(), // Barcode type and settings
                            data: vcarddate,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  String jobNameOrTitleEnOrAr(String lang1) {
    if (lang1 == "en") {
      return sharedPref.getString("TitleEN").toString() == ""
          ? sharedPref.getString("JobName") ?? ""
          : sharedPref.getString("TitleEN") ?? "";
    } else {
      return sharedPref.getString("Title").toString() == ""
          ? sharedPref.getString("JobName") ?? ""
          : sharedPref.getString("Title").toString();
    }
  }
}
