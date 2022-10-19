import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/QrCode/scannQrcode.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/dropDownCss.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart' as format;
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class getusrtInfo extends StatefulWidget {
  @override
  State<getusrtInfo> createState() => _getusrtInfoState();
}

class _getusrtInfoState extends State<getusrtInfo> {
  TextEditingController NID = new TextEditingController();
  TextEditingController mobileNo = new TextEditingController();
  TextEditingController Email = new TextEditingController();
  TextEditingController DateText = new TextEditingController();

  List servicesList = [];
  List deptsList = [];
  String? selectedItemdepts;
  String? name;
  String? selectedItemservices;
  int? deptID;
  int? servicesId;
  List appointments_time_List = [];
  DateTime? pickedDate;
  bool showNoApp = false;
  String? DepartName;
  String? time;
  String? Dow;
  DateTime? DOB;
  bool showDOB = false;
  bool showListOfwidgets = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(20),
        decoration: containerdecoration(BackGColor),
        child: Column(
          children: [
            TextField(
              controller: NID,
              style: TextStyle(
                color: baseColorText,
              ),
              keyboardType: TextInputType.number,
              decoration: formlabel1("رقم الهوية", Icons.qr_code, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => scanQrcode("حجز موعد")),
                ).then((value) {
                  print(value);
                  NID.text = value;

                  print("uuuuuuuuuuuuu = " + value);
                  setState(() {});
                  getUSersInfo();
                });
              }),
            ),
            SizedBox(
              height: 10,
            ),
            if (showDOB)
              TextField(
                style: TextStyle(
                  color: baseColorText,
                ),
                controller: TextEditingController(
                    text: DOB == null
                        ? ""
                        : format.DateFormat('dd/MM/yyyy')
                            .format(DOB!)
                            .toString()),
                keyboardType: TextInputType.text,
                decoration:
                    formlabel1("تاريخ الميلاد", Icons.remove_circle, () {
                  showDOB = false;
                  setState(() {});
                }),
                onTap: () async {
                  DOB = await showDatePicker(
                    context: context,
                    initialDatePickerMode: DatePickerMode.year,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1700),
                    lastDate: DateTime(2040),
                  );
                  setState(() {});
                },
              ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 100,
                child: widgetsUni.actionbutton("تحقق", Icons.search, () async {
                  getUSersInfo();
                })),
            //List of user info
            if (showListOfwidgets) ...userifoWidgets(),
          ],
        ),
      ),
    );
  }

  DropDownsDepts() {
    return deptsList.length == 0
        ? Container()
        : Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              onTap: () async {},
              child: DropdownSearch<dynamic>(
                  onChanged: (v) async {
                    try {
                      pickedDate = null;
                      DateText.text = "";
                      selectedItemdepts = v["Dept"];
                      deptID = v["ID"];
                      getAppoTime(deptID ?? 0);
                      setState(() {});
                    } catch (e) {
                      pickedDate = null;
                      selectedItemdepts = null;
                      deptID = null;
                      showNoApp = false;
                      Dow = null;
                      print("ed2wedwed");
                      setState(() {});
                    }
                  },
                  key: UniqueKey(),
                  popupBackgroundColor: BackGWhiteColor,
                  items: deptsList,
                  dropdownBuilderSupportsNullItem: true,
                  selectedItem:
                      selectedItemdepts == null ? null : selectedItemdepts,
                  showSelectedItems: false,
                  showClearButton: true,
                  mode: Mode.BOTTOM_SHEET,
                  maxHeight: 400,
                  showAsSuffixIcons: true,
                  showSearchBox: true,
                  popupItemBuilder: (context, rr, isSelected) =>
                      (dropDownCss.popupItemBuilder(rr["Dept"])),
                  dropdownBuilder: (context, selectedItem2) => dropDownCss
                      .dropdownBuilder(selectedItem2, selectedItemdepts),
                  itemAsString: (item) => item["Dept"] ?? "",
                  dropdownSearchDecoration:
                      dropDownCss.inputdecoration("الموقع"),
                  popupTitle: dropDownCss.popupTitle("الموقع"),
                  popupShape: dropDownCss.popupShape(),
                  emptyBuilder: (context, searchEntry) => dropDownCss.noData(),
                  searchFieldProps: dropDownCss.searchFieldProps(),
                  clearButton: dropDownCss.clearButton(),
                  dropDownButton: dropDownCss.dropDownButton()),
            ),
          );
  }

  DropDownsservicesList() {
    return servicesList.length == 0
        ? Container()
        : Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              onTap: () async {},
              child: DropdownSearch<dynamic>(
                  onChanged: (v) async {
                    try {
                      Dow = null;
                      DateText.text = "";
                      pickedDate = null;
                      selectedItemservices = v["ServiceName"];
                      servicesId = v["ServiceID"];
                      DepartName = v["DeptName"];
                      deptID = v["DeptID"];
                      if (servicesId != 0) {
                        getAppoTime(v["DeptID"] ?? 1);
                      }
                      setState(() {});
                    } catch (e) {
                      print("object");
                      selectedItemservices = null;
                      servicesId = null;
                      pickedDate = null;
                      showNoApp = false;
                      Dow = null;
                      setState(() {});
                      print("object");
                    }
                  },
                  key: UniqueKey(),
                  popupBackgroundColor: BackGWhiteColor,
                  items: servicesList,
                  dropdownBuilderSupportsNullItem: true,
                  selectedItem: selectedItemservices == null
                      ? null
                      : selectedItemservices,
                  showSelectedItems: false,
                  showClearButton: true,
                  mode: Mode.BOTTOM_SHEET,
                  maxHeight: 400,
                  showAsSuffixIcons: true,
                  showSearchBox: true,
                  popupItemBuilder: (context, rr, isSelected) =>
                      (dropDownCss.popupItemBuilder(rr["ServiceName"])),
                  dropdownBuilder: (context, selectedItem2) => dropDownCss
                      .dropdownBuilder(selectedItem2, selectedItemservices),
                  itemAsString: (item) => item["ServiceName"] ?? "",
                  dropdownSearchDecoration:
                      dropDownCss.inputdecoration("نوع الخدمة"),
                  popupTitle: dropDownCss.popupTitle("نوع الخدمة"),
                  popupShape: dropDownCss.popupShape(),
                  emptyBuilder: (context, searchEntry) => dropDownCss.noData(),
                  searchFieldProps: dropDownCss.searchFieldProps(),
                  clearButton: dropDownCss.clearButton(),
                  dropDownButton: dropDownCss.dropDownButton()),
            ),
          );
  }

  getAppoTime(int id) async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/create_appintment_mobile/get_appointments_time.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "email": sharedPref.getString("Email"),
          "depID": id
        }));
    print(respose);
    appointments_time_List = jsonDecode(respose.body);
    setState(() {});
    EasyLoading.dismiss();
  }

  showTime() async {
    var firstdate = appointments_time_List[0]["date"].toString().split("-");
    var lastdate = appointments_time_List[appointments_time_List.length - 1]
            ["date"]
        .toString()
        .split("-");
    pickedDate = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.day,
        initialDate: DateTime(int.parse(firstdate[0]), int.parse(firstdate[1]),
            int.parse(firstdate[2])),
        //get today's date
        firstDate: DateTime(int.parse(firstdate[0]), int.parse(firstdate[1]),
            int.parse(firstdate[2])),
        lastDate: DateTime(int.parse(lastdate[0]), int.parse(lastdate[1]),
            int.parse(lastdate[2])));

    DateText.text =
        pickedDate == null ? "" : pickedDate.toString().split(" ")[0];
    var res = appointments_time_List.where(
        (element) => element["date"] == pickedDate.toString().split(" ")[0]);

    showNoApp = res.isEmpty ? true : false;
    Dow = null;
    setState(() {});
  }

  getUSersInfo() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/create_appintment_mobile/get_user_info.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "email": sharedPref.getString("Email"),
          "id": NID.text,
          "dob": showDOB == false || DOB == null
              ? ""
              : DOB.toString() == ""
                  ? ""
                  : format.DateFormat('dd/MM/yyyy').format(DOB!).toString()
        }));
    Dow = null;
    selectedItemdepts = null;
    selectedItemservices = null;
    DepartName = "";
    deptsList.clear();
    servicesList.clear();
    appointments_time_List.clear();
    DateText.clear();
    setState(() {
      var respose2 = jsonDecode(respose.body);
      if (respose2["userinfo"]["userName"] != null) {
        showListOfwidgets = true;
        name = respose2["userinfo"]["userName"];
        Email.text = respose2["userinfo"]["userEmail"] ?? "";
        mobileNo.text = respose2["userinfo"]["userMobile"] ?? "";
        deptsList = respose2["agendaservices"]["depts"];
        servicesList = respose2["agendaservices"]["services"];
        showDOB = false;
        setState(() {});
      } else {
        if (DOB == null || DOB.toString() == "") {
          Alerts.errorAlert(context, "خطأ", "الرجاء إدخال تاريخ الميلاد")
              .show();
        } else {
          Alerts.errorAlert(context, "خطأ", "رقم الهوية أو تاريخ الميلاد خطأ")
              .show();
        }
        setState(() {
          showDOB = true;
          showListOfwidgets = false;
        });
      }
    });
    EasyLoading.dismiss();
  }

  insertApp() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );

    print({
      "token": sharedPref.getString("AccessToken"),
      "emailemp": sharedPref.getString("Email"),
      "bn": name,
      "idn": NID.text,
      "mobile": mobileNo.text,
      "Dept": deptID,
      "title": "حجز موعد",
      "desc": "",
      "date": pickedDate,
      "time": time,
      "dow": Dow,
      "ServiceID": servicesId,
      "RefNumber": ""
    });
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/create_appintment_mobile/createRequest.php"),
        body: jsonEncode({
          "emailemp": sharedPref.getString("Email"),
          "bn": name,
          "idn": NID.text,
          "mobile": mobileNo.text,
          "email": Email.text,
          "Dept": deptID,
          "title": "حجز موعد",
          "desc": "حجز من رقمي",
          "date": pickedDate.toString().split(" ")[0],
          "time": time,
          "dow": Dow,
          "ServiceID": servicesId,
          "RefNumber": ""
        }));
    EasyLoading.dismiss();
    print(respose);
    if (jsonDecode(respose.body)["eid"] == null) {
      Alerts.errorAlert(context, "خطأ", jsonDecode(respose.body)["status"])
          .show();
    } else {
      Alerts.successAlert(context, "", "تم إضافة الموعد").show();
    }
  }

  List<Widget> userifoWidgets() {
    return [
      SizedBox(
        height: 10,
      ),
      Card(
        elevation: 3,
        color: BackGWhiteColor,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: 90.w,
          child: Column(
            children: [
              Text(
                "إسم المستفيد",
                style: subtitleTx(baseColorText),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                name ?? "",
                style: descTx1(secondryColorText),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      TextField(
        controller: mobileNo,
        keyboardType: TextInputType.number,
        decoration: formlabel1("رقم الجوال"),
        style: TextStyle(
          color: baseColorText,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      TextField(
        controller: Email,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: baseColorText,
        ),
        decoration: formlabel1("البريد الإلكتروني"),
      ),
      SizedBox(
        height: 10,
      ),
      DropDownsservicesList(),
      SizedBox(
        height: 10,
      ),
      if (servicesId == 0) DropDownsDepts(),
      if (servicesId != 0 && servicesId != null)
        TextField(
          style: TextStyle(
            color: baseColorText,
          ),
          decoration: formlabel1("إسم الإدارة"),
          controller: TextEditingController(text: DepartName),
          enabled: false,
        ),
      SizedBox(
        height: 10,
      ),
      if (appointments_time_List.length != 0)
        TextFormField(
          controller: DateText,
          keyboardType: TextInputType.text,
          maxLines: 1,
          style: TextStyle(color: baseColorText),
          decoration: formlabel1("التاريخ"),
          onTap: () async {
            showTime();
          },
        ),
      if (pickedDate != "" && pickedDate != null) widgetsUni.divider(),
      if (showNoApp)
        Text(
          "لايوجد موعيد",
          style: subtitleTx(baseColorText),
        ),
      if (pickedDate != "" || pickedDate != null)
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Wrap(
            children: [
              ...appointments_time_List
                  .where((element) =>
                      element["date"] == pickedDate.toString().split(" ")[0])
                  .map((e) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: e["color"] == null
                              ? BackGWhiteColor
                              : e["color"] as Color,
                          padding: EdgeInsets.all(4)),
                      onPressed: () {
                        for (var list in appointments_time_List)
                          list["color"] = BackGWhiteColor;
                        e["color"] = secondryColor;
                        time = e["Time"];
                        Dow = e["dow"];
                        setState(() {});
                      },
                      child: Text(
                        e["Time"],
                        style: descTx1(baseColor),
                      )),
                );
              })
            ],
          ),
        ),
      SizedBox(
        height: 10,
      ),
      if (Dow != null)
        Container(
            width: 100,
            child: widgetsUni.actionbutton("حفظ", Icons.send, () {
              insertApp();
            }))
    ];
  }
}
