import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:intl/intl.dart' as format;
import 'package:http/http.dart' as http;
import 'package:eamanaapp/utilities/dropDownCss.dart';

class statistics extends StatefulWidget {
  const statistics({Key? key}) : super(key: key);

  @override
  State<statistics> createState() => _statisticsState();
}

class _statisticsState extends State<statistics> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  List _statistics = [];
  String? allReqs;
  String? closedReqs;
  String? activeReqs;
  String? openActiveReqs;
  String? transferredReqs;
  String? transferredText;
  List depts = [];
  String? deptID = "0";
  String? selectedItemdepts;
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    allReqs = null;
    setState(() {});
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/Agenda_statistics/get_statistics.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "email": sharedPref.getString("Email"),
          "status": null,
          "st_date": startDate.text == "" ? null : startDate.text,
          "end_date": endDate.text == "" ? null : endDate.text,
          "dept": deptID
        }));
    print(respose);
    depts = jsonDecode(respose.body)["deptlist"];
    setState(() {});
    var tem = jsonDecode(respose.body);
    allReqs = tem["allReqs"];
    closedReqs = tem["closedReqs"];
    activeReqs = tem["activeReqs"];
    openActiveReqs = tem["openActiveReqs"];
    transferredReqs = tem["transferredReqs"];
    transferredText = tem["transferredText"];
    setState(() {});
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("الإحصائيات", context, null, filter),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Image.asset(
                  imageBG,
                  fit: BoxFit.fill,
                ),
              ),
              allReqs == null
                  ? Container()
                  : Container(
                      margin: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              color: BackGWhiteColor,
                              elevation: 5,
                              child: ListTile(
                                title: Text(
                                  "جميع الطلبات",
                                  style: descTx1(secondryColorText),
                                ),
                                subtitle: McCountingText(
                                  begin: 0,
                                  end: double.parse(allReqs ?? "0"),
                                  style: titleTx(baseColorText),
                                  duration: Duration(seconds: 1),
                                ),
                                //leading: Text("جميع الطلبات"),
                                trailing: CircleAvatar(
                                    backgroundColor: Color(0XffFA8564),
                                    radius: 30,
                                    child: Icon(
                                      FontAwesomeIcons.download,
                                      size: 25,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Cards(
                                    "طلب تم إغلاقه",
                                    closedReqs ?? "0",
                                    FontAwesomeIcons.checkSquare,
                                    Color(0XffF1FB5AC)),
                                SizedBox(
                                  width: 10,
                                ),
                                Cards("طلب تحت التنفيذ", activeReqs ?? "0",
                                    FontAwesomeIcons.spinner, Color(0XffA48AD4))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Cards(
                                    "طلب مفتوح للتعديل",
                                    openActiveReqs ?? "0",
                                    FontAwesomeIcons.solidEdit,
                                    Color(0XffFA8564)),
                                SizedBox(
                                  width: 10,
                                ),
                                Cards(
                                    transferredText ?? "",
                                    transferredReqs ?? "0",
                                    FontAwesomeIcons.levelUpAlt,
                                    Color(0XffAEC785))
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          )),
    );
  }

  Widget Cards(String Tiltle, String No, dynamic icon, dynamic color) {
    return Expanded(
        child: Card(
      color: BackGWhiteColor,
      elevation: 5,
      child: Container(
        // decoration: containerdecoration(Colors.white),
        height: 170,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: color,
                radius: 30,
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            McCountingText(
              begin: 0,
              end: double.parse(No),
              style: titleTx(baseColorText),
              duration: Duration(seconds: 2),
            ),
            Text(
              Tiltle,
              style: descTx1(secondryColorText),
            ),
          ],
        ),
      ),
    ));
  }

  showDatPic(bool iStartDate) async {
    DateTime? date;

    date = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(),
      firstDate: DateTime(1700),
      lastDate: DateTime(2040),
    );
    if (iStartDate) {
      startDate.text = format.DateFormat('yyyy-MM-dd').format(date!).toString();
    } else {
      endDate.text = format.DateFormat('yyyy-MM-dd').format(date!).toString();
    }
    setState(() {});
  }

  filter() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: Text(""),
                content: Container(
                  height: 200,
                  child: Column(
                    children: [
                      TextField(
                        controller: startDate,
                        decoration: formlabel1("تاريخ البداية"),
                        onTap: () async {
                          await showDatPic(true);
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: endDate,
                        decoration: formlabel1("تاريخ النهاية"),
                        onTap: () {
                          showDatPic(false);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      dropdownDepts()
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      getData();
                      Navigator.pop(context);
                    },
                    child: Text("تطبيق"),
                  ),
                  TextButton(
                    onPressed: () {
                      clearData();
                    },
                    child: Text("تصفية"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  dropdownDepts() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () async {},
        child: DropdownSearch<dynamic>(
            onChanged: (v) async {
              try {
                selectedItemdepts = v["name"];
                deptID = v["ID"];

                setState(() {});
              } catch (e) {
                selectedItemdepts = null;
                deptID = "0";
              }
            },
            key: UniqueKey(),
            popupBackgroundColor: BackGWhiteColor,
            items: depts,
            dropdownBuilderSupportsNullItem: true,
            selectedItem: selectedItemdepts == null ? null : selectedItemdepts,
            showSelectedItems: false,
            showClearButton: true,
            mode: Mode.BOTTOM_SHEET,
            maxHeight: 400,
            showAsSuffixIcons: true,
            showSearchBox: true,
            popupItemBuilder: (context, rr, isSelected) =>
                (dropDownCss.popupItemBuilder(rr["name"])),
            dropdownBuilder: (context, selectedItem2) =>
                dropDownCss.dropdownBuilder("", selectedItemdepts),
            itemAsString: (item) => item is String ? item : item["name"] ?? "",
            dropdownSearchDecoration: dropDownCss.inputdecoration("الإدارة"),
            popupTitle: dropDownCss.popupTitle("الإدارة"),
            popupShape: dropDownCss.popupShape(),
            emptyBuilder: (context, searchEntry) => dropDownCss.noData(),
            searchFieldProps: dropDownCss.searchFieldProps(),
            clearButton: dropDownCss.clearButton(),
            dropDownButton: dropDownCss.dropDownButton()),
      ),
    );
  }

  clearData() {
    startDate.text = "";
    endDate.text = "";
    deptID = null;
    selectedItemdepts = null;
    selectedItemdepts = null;
    getData();
    Navigator.pop(context);
  }
}
