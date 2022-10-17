import 'dart:convert';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class customerServiceRequestsDetails extends StatefulWidget {
  var List;
  String url;

  customerServiceRequestsDetails(this.List, this.url);

  @override
  State<customerServiceRequestsDetails> createState() =>
      _customerServiceRequestsDetailsState();
}

class _customerServiceRequestsDetailsState
    extends State<customerServiceRequestsDetails> {
  String Meetingsurl = 'https://crm.eamana.gov.sa/agenda_dev/api/';
  TextEditingController DateText = TextEditingController();
  TextEditingController note = TextEditingController();
  String? dow;
  String? Time;
  bool page1 = false;
  bool page2 = false;
  bool page3 = false;
  bool page4 = false;
  DateTime? pickedDate;
  String? selectedItem;
  String? selectedItemDep;
  String? selectedItemMyEmp;
  dynamic MyEmp;
  List MyEmps = [];
  List request_log = [];
  List appointments_time_List = [];
  int? ActionID;
  dynamic ActionsList = [];
  bool showNoApp = false;
  List depIDList = [];
  String? depID;
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
            appBar: AppBarW.appBarW("التفاصل", context, null),
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Image.asset(
                    imageBG,
                    fit: BoxFit.fill,
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    child: ExpansionPanelList(
                      expansionCallback: (panelIndex, isExpanded) async {
                        changePanale(panelIndex, isExpanded);
                      },
                      children: [
                        UserInfo(),
                        RequestInfo(),
                        get_request_log(),
                        Actions()
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  ExpansionPanel Actions() {
    return ExpansionPanel(
        isExpanded: page4,
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: Text("الإجراءات", style: subtitleTx(baseColor)),
          );
        },
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              DropDown(),
              //المواعيد
              if (ActionID == 1 || ActionID == 2)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: DateText,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    style: TextStyle(color: baseColorText),
                    decoration: formlabel1("التاريخ"),
                    onTap: () async {
                      var firstdate = appointments_time_List[0]["date"]
                          .toString()
                          .split("-");
                      var lastdate = appointments_time_List[
                              appointments_time_List.length - 1]["date"]
                          .toString()
                          .split("-");
                      pickedDate = await showDatePicker(
                          context: context,
                          initialDatePickerMode: DatePickerMode.day,
                          initialDate: DateTime(int.parse(firstdate[0]),
                              int.parse(firstdate[1]), int.parse(firstdate[2])),
                          //get today's date
                          firstDate: DateTime(int.parse(firstdate[0]),
                              int.parse(firstdate[1]), int.parse(firstdate[2])),
                          lastDate: DateTime(int.parse(lastdate[0]),
                              int.parse(lastdate[1]), int.parse(lastdate[2])));

                      DateText.text = pickedDate == null
                          ? ""
                          : pickedDate.toString().split(" ")[0];
                      var res = appointments_time_List.where((element) =>
                          element["date"] ==
                          pickedDate.toString().split(" ")[0]);

                      showNoApp = res.isEmpty ? true : false;
                      setState(() {});
                    },
                  ),
                ),
              if (showNoApp && pickedDate != null)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "لايوجد موعيد",
                    style: titleTx(baseColorText),
                  ),
                ),
              if (pickedDate != "" || pickedDate != null)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Wrap(
                    children: [
                      ...appointments_time_List
                          .where((element) =>
                              element["date"] ==
                              pickedDate.toString().split(" ")[0])
                          .map((e) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: e["color"] == null
                                      ? Colors.white
                                      : e["color"] as Color,
                                  padding: EdgeInsets.all(4)),
                              onPressed: () {
                                for (var list in appointments_time_List)
                                  list["color"] = Colors.white;
                                e["color"] = secondryColor;
                                Time = e["Time"];
                                dow = e["dow"];
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
              if (ActionID == 7) Transform(),
              if (ActionID == 10) TransformInternal(),
              if ((pickedDate != "" || pickedDate != null || ActionID == 3) &&
                  (ActionID != 15 && ActionID != 14))
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: note,
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    style: TextStyle(color: baseColorText),
                    decoration:
                        formlabel1(ActionID == 3 ? "سبب الرفض" : "الملاحظات"),
                  ),
                ),
              if (ActionID == 14 || ActionID == 15)
                Column(
                  children: [
                    Text(
                      "الموعد المقترح ",
                      style: subtitleTx(baseColor),
                    ),
                    Text(
                      widget.List[ActionID == 14
                          ? "suggested_appointment"
                          : "appointment"],
                      style: descTx1(baseColorText),
                    ),
                  ],
                ),
              if (ActionID != null)
                Container(
                    width: 100,
                    child: widgetsUni.actionbutton("تحديث", Icons.update, () {
                      if (ActionID == 1 || ActionID == 2) {
                        insert(DateText.text, Time, dow, note.text, null, null);
                      } else if (ActionID == 3 ||
                          ActionID == 4 ||
                          ActionID == 5 ||
                          ActionID == 6 ||
                          ActionID == 8 ||
                          ActionID == 9 ||
                          ActionID == 13 ||
                          ActionID == 11) {
                        insert(null, null, null, note.text, null, null);
                      } else if (ActionID == 7) {
                        insert(null, null, null, note.text, depID, null);
                      } else if (ActionID == 10) {
                        insert(null, null, null, note.text, null, MyEmp);
                      } else if (ActionID == 14 || ActionID == 15) {
                        insert(null, null, null, null, null, null);
                      }
                    })),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }

  DropDown() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownSearch<dynamic>(
        popupBackgroundColor: BackGWhiteColor,
        key: UniqueKey(),
        items: ActionsList,
        popupItemBuilder: (context, rr, isSelected) => (Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Text(rr["actionName"], style: subtitleTx(baseColorText))
            ],
          ),
        )),
        dropdownBuilder: (context, selectedItem) => Container(
          child: selectedItem == null
              ? null
              : Text(
                  selectedItem == null ? "" : selectedItem ?? "",
                  style: TextStyle(fontSize: 16, color: baseColorText),
                ),
        ),
        dropdownBuilderSupportsNullItem: true,
        selectedItem: selectedItem == null ? null : selectedItem,
        showSelectedItems: false,
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
          labelText: "الإجراءات",
        ),
        showSearchBox: true,
        onChanged: (v) async {
          try {
            selectedItem = v["actionName"];
            ActionID = v["actionID"];
            setState(() {});
            pickedDate = null;
            print(ActionID);

            if (ActionID == 1 || ActionID == 2) {
              get_appointments_time();
            } else if (ActionID == 7) {
              getDepList();
            } else if (ActionID == 10) {
              getInternalEmps();
            }

            setState(() {});
          } catch (e) {}
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
              "الإجراءات",
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
    );
  }

  Transform() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownSearch<dynamic>(
        popupBackgroundColor: BackGWhiteColor,
        key: UniqueKey(),
        items: depIDList,
        popupItemBuilder: (context, rr, isSelected) => (Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [Text(rr["name"], style: subtitleTx(baseColorText))],
          ),
        )),
        dropdownBuilder: (context, selectedItem) => Container(
          child: selectedItem == null
              ? null
              : Text(
                  selectedItem == null ? "" : selectedItem ?? "",
                  style: TextStyle(fontSize: 16, color: baseColorText),
                ),
        ),
        dropdownBuilderSupportsNullItem: true,
        selectedItem: selectedItemDep == null ? null : selectedItemDep,
        showSelectedItems: false,
        mode: Mode.BOTTOM_SHEET,
        maxHeight: 400,
        showAsSuffixIcons: true,
        itemAsString: (item) => item["name"] ?? "",
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
          labelText: "إحالة إلى",
        ),
        showSearchBox: true,
        onChanged: (v) async {
          try {
            selectedItemDep = v["name"];
            depID = v["ID"];
            setState(() {});
          } catch (e) {}
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
              "إحالة إلى",
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
    );
  }

  TransformInternal() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownSearch<dynamic>(
        popupBackgroundColor: BackGWhiteColor,
        key: UniqueKey(),
        items: MyEmps,
        popupItemBuilder: (context, rr, isSelected) => (Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [Text(rr["name"], style: subtitleTx(baseColorText))],
          ),
        )),
        dropdownBuilder: (context, selectedItem) => Container(
          child: selectedItem == null
              ? null
              : Text(
                  selectedItem == null ? "" : selectedItemMyEmp ?? "",
                  style: TextStyle(fontSize: 16, color: baseColorText),
                ),
        ),
        dropdownBuilderSupportsNullItem: true,
        selectedItem: selectedItemMyEmp == null ? null : selectedItemMyEmp,
        showSelectedItems: false,
        mode: Mode.BOTTOM_SHEET,
        maxHeight: 400,
        showAsSuffixIcons: true,
        itemAsString: (item) => item["name"] ?? "",
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
          labelText: "الموظف",
        ),
        showSearchBox: true,
        onChanged: (v) async {
          try {
            selectedItemMyEmp = v["name"];
            MyEmp = {"name": v["name"], "user": v["user"]};

            print(MyEmp["user"]);

            setState(() {});
          } catch (e) {}
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
              "الموضف",
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
    );
  }

  getInternalEmps() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await http.post(
        Uri.parse(Meetingsurl + ("Agenda_dashboard/get_dept_emps.php")),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "email": sharedPref.getString("Email")
        }));
    MyEmps = jsonDecode(respose.body);
    print(appointments_time_List);
    setState(() {});
    EasyLoading.dismiss();
  }

  get_appointments_time() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await http.post(
        Uri.parse(Meetingsurl + "Agenda_dashboard/get_appointments_time.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "email": sharedPref.getString("Email"),
          "reqID": widget.List["reqID"]
        }));
    appointments_time_List = jsonDecode(respose.body);
    setState(() {});
    EasyLoading.dismiss();
  }

  getDepList() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await http.post(
        Uri.parse(Meetingsurl + "Agenda_dashboard/get_depts_list.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "email": sharedPref.getString("Email")
        }));
    depIDList = jsonDecode(respose.body)["depts"];
    print(appointments_time_List);
    setState(() {});
    EasyLoading.dismiss();
  }

  ExpansionPanel UserInfo() {
    return ExpansionPanel(
      isExpanded: page1,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text(
            "معلومات مقدم الطلب",
            style: subtitleTx(baseColor),
          ),
        );
      },
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            titleAnddescByCol("رقم الطلب", widget.List["reqID"]),
            titleAnddescByCol("الإسم", widget.List["name"]),
            titleAnddescByCol("رقم الجوال", widget.List["mobile"]),
            titleAnddescByCol("البريد", widget.List["email"]),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  changePanale(int panelIndex, bool isExpanded) async {
    if (panelIndex == 0) {
      if (isExpanded) {
        page1 = false;
      } else {
        page1 = true;
        page2 = false;
        page3 = false;
        page4 = false;
      }
    } else if (panelIndex == 1) {
      if (isExpanded) {
        page2 = false;
      } else {
        page2 = true;
        page3 = false;
        page1 = false;
        page4 = false;
      }
    } else if (panelIndex == 2) {
      if (isExpanded) {
        page3 = false;
      } else {
        if (request_log.isEmpty) {
          EasyLoading.show(
            status: '... جاري المعالجة',
            maskType: EasyLoadingMaskType.black,
          );
          var respose = await http.post(
              Uri.parse(Meetingsurl +
                  (widget.url == "LeaderAppointment_dashboard"
                      ? "LeaderAppointment_dashboard/get_appoinments_request_log.php"
                      : "Agenda_dashboard/get_request_log.php")),
              body: jsonEncode({
                "token": sharedPref.getString("AccessToken"),
                "email": sharedPref.getString("Email"),
                "reqID": widget.List["reqID"]
              }));
          EasyLoading.dismiss();
          request_log = jsonDecode(respose.body);
          setState(() {});
        }
        page3 = true;
        page2 = false;
        page1 = false;
        page4 = false;
      }
    } else if (panelIndex == 3) {
      if (isExpanded) {
        page4 = false;
      } else {
        if (ActionsList.isEmpty) {
          EasyLoading.show(
            status: '... جاري المعالجة',
            maskType: EasyLoadingMaskType.black,
          );
          var respose = await http.post(
              Uri.parse(Meetingsurl +
                  (widget.url == "LeaderAppointment_dashboard"
                      ? "LeaderAppointment_dashboard/get_Actions_list.php"
                      : "Agenda_dashboard/get_Actions_list.php")),
              body: jsonEncode({
                "token": sharedPref.getString("AccessToken"),
                "email": sharedPref.getString("Email"),
                "reqID": widget.List["reqID"]
              }));
          EasyLoading.dismiss();
          ActionsList = jsonDecode(respose.body);

          setState(() {});
        }
        page3 = false;
        page2 = false;
        page1 = false;
        page4 = true;
      }
    }

    setState(() {});
  }

  ExpansionPanel get_request_log() {
    return ExpansionPanel(
      isExpanded: page3,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text("سجل الطلب", style: subtitleTx(baseColor)),
        );
      },
      body: request_log.length == 0
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "لايوجد تحديثات",
                style: titleTx(secondryColor),
              ),
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: request_log.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    decoration: containerdecoration(Colors.white),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        simpleText("تعديل بواسطة" +
                            ": " +
                            request_log[index]["log_by"]),
                        SizedBox(
                          height: 5,
                        ),
                        simpleText("التاريخ" +
                            ": " +
                            request_log[index]["time&date"]
                                .toString()
                                .split(" ")[0]),
                        SizedBox(
                          height: 5,
                        ),
                        simpleText("القسم" + ": " + request_log[index]["dept"]),
                        SizedBox(
                          height: 5,
                        ),
                        simpleText(
                            "الحالة" + ": " + request_log[index]["status"]),
                        SizedBox(
                          height: 5,
                        ),
                        simpleText(
                            "الملاحظات" + ": " + request_log[index]["notes"]),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  ExpansionPanel RequestInfo() {
    return ExpansionPanel(
      isExpanded: page2,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text("معلومات الطلب", style: subtitleTx(baseColor)),
        );
      },
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Container(
              height: 140,
              child: titleAnddescByRow("نوع الخدمة", widget.List["Type"],
                  "الحالة", widget.List["Status"]),
            ),
            if (widget.List["date"] != null)
              titleAnddescByRow("التاريخ", widget.List["date"], "اليوم",
                  widget.List["appDowTxt"] ?? ""),
            if (widget.List["date"] != null)
              titleAnddescByCol("الوقت", widget.List["appTime"] ?? ""),
            titleAnddescByCol("الموضوع", widget.List["title"]),
            titleAnddescByCol("التفاصيل", widget.List["Details"]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.List["attach1"] != "")
                  widgetsUni.actionbutton("مرفق1", Icons.link, () async {
                    if (Platform.isIOS) {
                      if (!await launchUrl(Uri.parse(widget.List["attach1"]))) {
                        throw 'Could not launch $widget.List["attach1"]';
                      }
                    } else {
                      if (!await launchUrl(Uri.parse(widget.List["attach1"]),
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $widget.List["attach1"]';
                      }
                    }
                  }),
                if (widget.List["attach2"] != "")
                  widgetsUni.actionbutton("مرفق2", Icons.link, () async {
                    if (Platform.isIOS) {
                      if (!await launchUrl(Uri.parse(widget.List["attach2"]))) {
                        throw 'Could not launch $widget.List["attach2"]';
                      }
                    } else {
                      if (!await launchUrl(Uri.parse(widget.List["attach2"]),
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $widget.List["attach1"]';
                      }
                    }
                  }),
                if (widget.List["attach3"] != "")
                  widgetsUni.actionbutton("مرفق3", Icons.link, () async {
                    if (Platform.isIOS) {
                      if (!await launchUrl(Uri.parse(widget.List["attach3"]))) {
                        throw 'Could not launch $widget.List["attach3"]';
                      }
                    } else {
                      if (!await launchUrl(Uri.parse(widget.List["attach3"]),
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $widget.List["attach3"]';
                      }
                    }
                  }),
              ],
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget titleAnddescByCol(String title, String desc) {
    return Card(
      elevation: 3,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        width: 100.w,
        child: Column(
          children: [
            Text(
              title,
              style: titleTx(baseColorText),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              desc,
              style: subtitleTx(secondryColorText),
            )
          ],
        ),
      ),
    );
  }

  Widget titleAnddescByRow(
      String title1, String desc1, String title2, String desc2) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 3,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    title1,
                    style: titleTx(baseColorText),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    desc1,
                    style: subtitleTx(secondryColorText),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 3,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    title2,
                    style: titleTx(baseColorText),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    desc2,
                    style: subtitleTx(secondryColorText),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget simpleText(String txt) {
    return Text(
      txt,
      style: descTx2(baseColorText),
    );
  }

  insert(String? date, String? time, String? dow, String? note, String? depID,
      dynamic myEmp) async {
    if (ActionID == 1 || ActionID == 2) {
      if (date == null || date.trim() == "") {
        Alerts.errorAlert(context, "خطأ", "الرجاء إدخال تاريخ").show();
        return;
      }
      if (time == null || time.trim() == "") {
        Alerts.errorAlert(context, "خطأ", "الرجاء إختيار موعد").show();
        return;
      }
    }

    if (ActionID == 3) {
      if (note?.trim() == "") {
        Alerts.errorAlert(context, "خطاء", 'الرجاء إدخال سبب الرفض').show();
        return;
      }
    }
    if (ActionID == 3 ||
        ActionID == 4 ||
        ActionID == 5 ||
        ActionID == 6 ||
        ActionID == 8 ||
        ActionID == 9 ||
        ActionID == 13 ||
        ActionID == 11) {
      if (note?.trim() == "") {
        Alerts.errorAlert(context, "خطاء", 'الرجاء إدخال ملاحظات').show();
        return;
      }
    }
    if (ActionID == 7) {
      if (depID == null || depID == "") {
        Alerts.errorAlert(context, "خطاء", "الرجاء إختيار الادارة").show();
        return;
      }
    }
    if (ActionID == 10) {
      if (MyEmp == null || MyEmp == "") {
        Alerts.errorAlert(context, "خطاء", "الرجاء إختيار الموظف").show();
        return;
      }
    }
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );

    var respose = await http.post(
        Uri.parse(Meetingsurl +
            (widget.url == "LeaderAppointment_dashboard"
                ? "LeaderAppointment_dashboard/set_request_action.php"
                : "Agenda_dashboard/set_request_action.php")),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "email": sharedPref.getString("Email"),
          "reqID": widget.List["reqID"],
          "actionID": ActionID,
          "sid": widget.List["sid"],
          "up_notes": note,
          "date": date,
          "time": time,
          "dow": dow,
          "newdept": depID,
          "newemp": myEmp == null ? null : myEmp["user"],
          "newempName": myEmp == null ? null : myEmp["name"]
        }));

    if (jsonDecode(respose.body)["status"] == true) {
      Alerts.successAlert(context, "", "تم التحديث").show().then((value) {
        Navigator.pop(context, true);
      });
    }

    if (jsonDecode(respose.body)["status"] != true) {
      Alerts.errorAlert(context, "خطأ", jsonDecode(respose.body)["status"])
          .show();
    }
    EasyLoading.dismiss();
  }
}
