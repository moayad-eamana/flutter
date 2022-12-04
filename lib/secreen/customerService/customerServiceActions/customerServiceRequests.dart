import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'customerServiceRequestsDetails.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class customerServiceRrequests extends StatefulWidget {
  String url;
  customerServiceRrequests(this.url);
  @override
  State<customerServiceRrequests> createState() =>
      _customerServiceRrequestsState();
}

class _customerServiceRrequestsState extends State<customerServiceRrequests> {
  int page = 0;
  late ScrollController controller;
  TextEditingController reqID = new TextEditingController();
  List customerServiceRrequestsList = [];
  List deptList = [];
  String deptsID = sharedPref.getString("deptid") ?? "";
  String leadid = sharedPref.getString("leadid") ?? "";
  String? selectedItem;
  String? selectedItemstatus;
  String statusesID = "";

  List statuslist = [];

  void initState() {
    controller = ScrollController()..addListener(_scrollListener);

    getData();
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      getData();
    }
  }

  getData([bool? clear]) async {
    if (clear == true) {
      customerServiceRrequestsList.clear();
    }

    getDepts();
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await http.post(
        Uri.parse(CRMURL +
            (widget.url == "LeaderAppointment_dashboard"
                ? "LeaderAppointment_dashboard/get_appoinments_request.php"
                : "Agenda_dashboard/get_request.php")),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "email": sharedPref.getString("Email"),
          "deptsID":
              widget.url == "LeaderAppointment_dashboard" ? leadid : deptsID,
          "statusID": statusesID,
          "allowEdit": "",
          "reqID": reqID.text,
          "page": ++page
        }));
    var res = jsonDecode(respose.body);
    for (int i = 0; i <= res.length - 1; i++) {
      // res[i]["name"] =
      //     res[i]["name"].toString().replaceAll(new RegExp(r" "), " ");
      customerServiceRrequestsList.add(res[i]);
    }
    print(customerServiceRrequestsList);

    setState(() {});
    EasyLoading.dismiss();

    print("object");
    print(deptList);
    setState(() {});
  }

  getDepts() async {
    var respose2 = await http.post(
        Uri.parse(CRMURL +
            (widget.url == "LeaderAppointment_dashboard"
                ? "LeaderAppointment_dashboard/get_leaders_list.php"
                : "Agenda_dashboard/get_depts_list.php")),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "email": sharedPref.getString("Email")
        }));

    try {
      deptList = jsonDecode(respose2.body)["depts"];
    } catch (e) {
      deptList = [];
    }
    try {
      statuslist = jsonDecode(respose2.body)["statuslist"];
    } catch (e) {
      statuslist = [];
    }
    setState(() {});
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                backgroundColor: BackGWhiteColor,
                title: Text('بحث', style: subtitleTx(baseColorText)),
                content: Container(
                  height: 200,
                  child: Column(
                    children: [
                      TextField(
                        controller: reqID,
                        style: TextStyle(
                          color: baseColorText,
                        ),
                        decoration: formlabel1("رقم الطلب"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropDown(),
                      SizedBox(
                        height: 15,
                      ),
                      DropDownstatuslist()
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                      onPressed: () async {
                        EasyLoading.show(
                          status: '... جاري المعالجة',
                          maskType: EasyLoadingMaskType.black,
                        );
                        var respose = await http.post(
                            Uri.parse(CRMURL +
                                (widget.url == "LeaderAppointment_dashboard"
                                    ? "LeaderAppointment_dashboard/get_appoinments_request.php"
                                    : "Agenda_dashboard/get_request.php")),
                            body: jsonEncode({
                              "token": sharedPref.getString("AccessToken"),
                              "email": sharedPref.getString("Email"),
                              "deptsID":
                                  widget.url == "LeaderAppointment_dashboard"
                                      ? leadid
                                      : deptsID,
                              "statusID": statusesID,
                              "allowEdit": "",
                              "reqID": reqID.text,
                              "page": "1"
                            }));

                        var res = jsonDecode(respose.body);
                        customerServiceRrequestsList = res;
                        print(customerServiceRrequestsList);
                        setState(() {});
                        Navigator.pop(context);
                        setState(() {});
                        EasyLoading.dismiss();
                      },
                      child: Text("بحث")),
                  ElevatedButton(
                      onPressed: () {
                        reqID.text = "";
                        deptsID = widget.url == "LeaderAppointment_dashboard"
                            ? leadid
                            : sharedPref.getString("deptsID") ?? "";
                        statusesID = "";

                        Navigator.pop(context);
                        getData(true);
                        setState(() {});
                      },
                      child: Text("تصفية"))
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      setState(() {});
    });
  }

  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("عرض الطلبات", context, null, _displayDialog),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            customerServiceRrequestsList.length == 0
                ? Center(
                    child: Text(
                      "لايوحد بيانات",
                      style: titleTx(baseColor),
                    ),
                  )
                : ListView.builder(
                    controller: controller,
                    itemCount: customerServiceRrequestsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    customerServiceRequestsDetails(
                                        customerServiceRrequestsList[index],
                                        widget.url)),
                          ).then((value) {
                            if (value == true) {
                              page = 0;

                              getData(true);
                            }
                          });
                        },
                        child: Card(
                          color: BackGColor,
                          elevation: 5,
                          child: ListTile(
                            leading: Text(
                              customerServiceRrequestsList[index]["reqID"],
                              style: subtitleTx(secondryColor),
                            ),
                            title: Text(
                              customerServiceRrequestsList[index]["name"]
                                  .toString(),
                              style: subtitleTx(baseColorText),
                              textAlign: TextAlign.right,
                            ),
                            subtitle: Text(
                              customerServiceRrequestsList[index]["Type"] +
                                  " - " +
                                  customerServiceRrequestsList[index]["Status"],
                              style: descTx1(secondryColorText),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }

  DropDown() {
    return deptList.length == 0
        ? Container()
        : Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              onTap: () async {},
              child: DropdownSearch<dynamic>(
                popupBackgroundColor: BackGWhiteColor,
                key: UniqueKey(),
                items: deptList,
                popupItemBuilder: (context, rr, isSelected) => (Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Text(rr["name"], style: subtitleTx(baseColorText))
                    ],
                  ),
                )),
                dropdownBuilder: (context, selectedItem2) => Container(
                  child: selectedItem2 == null
                      ? null
                      : Text(
                          selectedItem2 == null ? "" : selectedItem ?? "",
                          style: TextStyle(fontSize: 12, color: baseColorText),
                        ),
                ),
                dropdownBuilderSupportsNullItem: true,
                selectedItem: selectedItem == null ? null : selectedItem,
                showSelectedItems: false,
                showClearButton: true,
                mode: Mode.BOTTOM_SHEET,
                maxHeight: 400,
                showAsSuffixIcons: true,
                itemAsString: (item) => item["actionName"] ?? "",
                dropdownSearchDecoration: InputDecoration(
                  labelStyle: TextStyle(color: secondryColorText),
                  errorStyle: TextStyle(color: redColor),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: responsiveMT(8, 30), horizontal: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: bordercolor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bordercolor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bordercolor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  labelText: "الإدارات",
                ),
                showSearchBox: true,
                onChanged: (v) async {
                  try {
                    selectedItem = v["name"];

                    widget.url == "LeaderAppointment_dashboard"
                        ? leadid = v["ID"]
                        : deptsID = v["ID"];
                    setState(() {});
                  } catch (e) {
                    print(e);
                  }
                },
                popupTitle: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: secondryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "الإدارات",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                popupShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                emptyBuilder: (context, searchEntry) => Center(
                  child: Text(
                    "لا يوجد بيانات",
                    style: TextStyle(
                      color: baseColorText,
                    ),
                  ),
                ),
                searchFieldProps: TextFieldProps(
                  textAlign: TextAlign.right,
                  decoration: formlabel1(""),
                  style: TextStyle(
                    color: baseColorText,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                clearButton: Icon(
                  Icons.clear,
                  color: baseColor,
                ),
                dropDownButton: Icon(
                  Icons.arrow_drop_down,
                  color: baseColor,
                ),
              ),
            ),
          );
  }

  DropDownstatuslist() {
    return statuslist.length == 0
        ? Container()
        : Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              onTap: () async {},
              child: DropdownSearch<dynamic>(
                popupBackgroundColor: BackGWhiteColor,
                key: UniqueKey(),
                items: statuslist,
                popupItemBuilder: (context, rr, isSelected) => (Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Text(rr["statuses"], style: subtitleTx(baseColorText))
                    ],
                  ),
                )),
                dropdownBuilder: (context, selectedItem2) => Container(
                  child: selectedItem2 == null
                      ? null
                      : Text(
                          selectedItem2 == null ? "" : selectedItemstatus ?? "",
                          style: TextStyle(fontSize: 12, color: baseColorText),
                        ),
                ),
                dropdownBuilderSupportsNullItem: true,
                selectedItem:
                    selectedItemstatus == null ? null : selectedItemstatus,
                showSelectedItems: false,
                showClearButton: true,
                mode: Mode.BOTTOM_SHEET,
                maxHeight: 400,
                showAsSuffixIcons: true,
                itemAsString: (item) => item["actionName"] ?? "",
                dropdownSearchDecoration: InputDecoration(
                  labelStyle: TextStyle(color: secondryColorText),
                  errorStyle: TextStyle(color: redColor),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: responsiveMT(8, 30), horizontal: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: bordercolor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bordercolor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bordercolor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  labelText: "حالة الطلب",
                ),
                showSearchBox: true,
                onChanged: (v) async {
                  try {
                    selectedItemstatus = v["statuses"];
                    statusesID = v["statusesID"].toString();
                    setState(() {});
                  } catch (e) {
                    print(e);
                  }
                },
                popupTitle: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: secondryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "حالة الطلب",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                popupShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                emptyBuilder: (context, searchEntry) => Center(
                  child: Text(
                    "لا يوجد بيانات",
                    style: TextStyle(
                      color: baseColorText,
                    ),
                  ),
                ),
                searchFieldProps: TextFieldProps(
                  textAlign: TextAlign.right,
                  decoration: formlabel1(""),
                  style: TextStyle(
                    color: baseColorText,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                clearButton: Icon(
                  Icons.clear,
                  color: baseColor,
                ),
                dropDownButton: Icon(
                  Icons.arrow_drop_down,
                  color: baseColor,
                ),
              ),
            ),
          );
  }
}
