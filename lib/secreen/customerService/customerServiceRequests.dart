import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'customerServiceRequestsDetails.dart';

class customerServiceRrequests extends StatefulWidget {
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
  String deptsID = "0";
  String? selectedItem;

  String Meetingsurl =
      'https://crm.eamana.gov.sa/agenda_dev/api/Agenda_dashboard/get_request.php';

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

    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await http.post(Uri.parse(Meetingsurl),
        body: jsonEncode({
          "token": "",
          "email": "ajalarfaj",
          "deptsID": deptsID,
          "statusID": "",
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
    var respose2 = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/Agenda_dashboard/get_depts_list.php"),
        body: jsonEncode({"token": "", "email": "ajalarfaj"}));

    deptList = jsonDecode(respose2.body)["depts"];
    setState(() {});
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text('بحث'),
              content: Container(
                height: 150,
                child: Column(
                  children: [
                    TextField(
                      controller: reqID,
                      decoration: formlabel1("رقم الطلب"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropDown()
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
                      var respose = await http.post(Uri.parse(Meetingsurl),
                          body: jsonEncode({
                            "token": "",
                            "email": "ajalarfaj",
                            "deptsID": deptsID,
                            "statusID": "",
                            "allowEdit": "",
                            "reqID": reqID.text,
                            "page": "1"
                          }));

                      var res = jsonDecode(respose.body);
                      customerServiceRrequestsList = res;
                      Navigator.pop(context);
                      setState(() {});
                      EasyLoading.dismiss();
                    },
                    child: Text("بحث")),
                ElevatedButton(
                    onPressed: () {
                      reqID.text = "";
                      Navigator.pop(context);
                      getData(true);
                      setState(() {});
                    },
                    child: Text("تصفية"))
              ],
            ),
          );
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
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Image.asset(
                imageBG,
                fit: BoxFit.fill,
              ),
            ),
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
                                        customerServiceRrequestsList[index])),
                          ).then((value) {
                            if (value == true) {
                              getData(true);
                            }
                          });
                        },
                        child: Card(
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
    return Directionality(
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
              children: [Text(rr["name"], style: subtitleTx(baseColorText))],
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
              deptsID = v["ID"];
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
}
