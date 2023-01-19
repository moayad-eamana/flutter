import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/provider/mahamme/PurchaseRequestsProvider.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class PurchaseRequestsDetails extends StatefulWidget {
  int index;
  int id;
  PurchaseRequestsDetails(this.index, this.id);
  @override
  State<PurchaseRequestsDetails> createState() =>
      _PurchaseRequestsDetailsState();
}

class _PurchaseRequestsDetailsState extends State<PurchaseRequestsDetails> {
  TextEditingController _note = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    var _provider =
        Provider.of<PurchaseRequestsProvider>(context, listen: false);
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await Provider.of<PurchaseRequestsProvider>(context, listen: false)
          .fetchPurchaseRequestItemst(
              _provider.PurchaseRequestsList[widget.index].RequestNumber);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider =
        Provider.of<PurchaseRequestsProvider>(context, listen: true);
    print(_provider.PurchaseRequestsList[0].TransactionTypeID);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("إعتماد طلب مشتريات", context, null),
          body: Stack(
            children: [
              widgetsUni.bacgroundimage(),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Container(
                          child: _provider.PurchaseRequestItemsList.length == 0
                              ? Container()
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  //   primary: false,
                                  itemCount:
                                      _provider.PurchaseRequestItemsList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      // margin:
                                      //     EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Container(
                                            color: BackGWhiteColor,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 20),
                                            child: Card(
                                              color: BackGWhiteColor,
                                              elevation: 1,
                                              child: Column(
                                                children: [
                                                  // Row(
                                                  //   children: [
                                                  //     Text(
                                                  //       "موضوع الطلب : " +
                                                  //           _provider
                                                  //               .PurchaseRequestsList[widget.index]
                                                  //               .Subject,
                                                  //       style: descTx2(secondryColorText),
                                                  //     )
                                                  //   ],
                                                  // ),
                                                  Table(
                                                    //       defaultColumnWidth: FixedColumnWidth(120.0),

                                                    border: TableBorder.all(
                                                        color: bordercolor,
                                                        //  style: BorderStyle.solid,
                                                        width: 0.5),
                                                    children: [
                                                      TableRows(
                                                          "الكمية المطلوبة",
                                                          _provider
                                                              .PurchaseRequestItemsList[
                                                                  index]
                                                              .RequiredQuantity
                                                              .toString()),
                                                      TableRows(
                                                          "إسم الصنف",
                                                          _provider
                                                              .PurchaseRequestItemsList[
                                                                  index]
                                                              .ItemName
                                                              .toString()),
                                                      TableRows(
                                                          "كود الصنف",
                                                          _provider
                                                              .PurchaseRequestItemsList[
                                                                  index]
                                                              .ItemCode),
                                                      TableRows(
                                                          "الوحدة",
                                                          _provider
                                                              .PurchaseRequestItemsList[
                                                                  index]
                                                              .UnitDescription),
                                                      TableRows(
                                                          "المتوفر في المخزون",
                                                          _provider
                                                              .PurchaseRequestItemsList[
                                                                  index]
                                                              .StockAvaliableQuantity
                                                              .toString()),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            elevation: 1,
                            child: Container(
                              color: BackGWhiteColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "فضلا أدخل الملاحظات";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _note,
                                keyboardType: TextInputType.text,
                                maxLines: 3,
                                style: TextStyle(color: baseColorText),
                                decoration: formlabel1("ملاحظات"),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            widgetsUni.actionbutton(
                              "إعتماد",
                              Icons.check,
                              () async {
                                logApiModel logapiO = logApiModel();
                                logapiO.ControllerName = "InboxHRController";
                                logapiO.ClassName = "InboxHRController";
                                logapiO.ActionMethodName = "إعتماد طلب شراء";
                                logapiO.ActionMethodType = 2;
                                if (_formKey.currentState!.validate()) {
                                  dynamic res =
                                      await _provider.ApprovePurchasesRequest(
                                          widget.index,
                                          _note.text,
                                          true,
                                          widget.id);

                                  if (res == true) {
                                    logapiO.StatusCode = 1;
                                    logApi(logapiO);
                                    Alerts.successAlert(
                                            context, "", "تم الإعتماد ")
                                        .show()
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    logapiO.StatusCode = 0;
                                    logapiO.ErrorMessage = res.toString();
                                    logApi(logapiO);
                                    Alerts.errorAlert(
                                            context, "خطأ", res.toString())
                                        .show();
                                  }
                                }
                              },
                            ),
                            widgetsUni.actionbutton(
                              "رفض",
                              Icons.close,
                              () async {
                                logApiModel logapiO = logApiModel();
                                logapiO.ControllerName = "InboxHRController";
                                logapiO.ClassName = "InboxHRController";
                                logapiO.ActionMethodName = "رفض طلب شراء";
                                logapiO.ActionMethodType = 2;
                                if (_formKey.currentState!.validate()) {
                                  if (_formKey.currentState!.validate()) {
                                    dynamic res =
                                        await _provider.ApprovePurchasesRequest(
                                            widget.index,
                                            _note.text,
                                            false,
                                            widget.id);

                                    if (res == true) {
                                      logapiO.StatusCode = 1;
                                      logApi(logapiO);
                                      Alerts.successAlert(
                                              context, "", "تم الرفض ")
                                          .show()
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      logapiO.StatusCode = 0;
                                      logapiO.ErrorMessage = res.toString();
                                      logApi(logapiO);
                                      Alerts.errorAlert(
                                              context, "خطأ", res.toString())
                                          .show();
                                    }
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  TableRow TableRows(String title, String dec) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
            title,
            style: descTx1(baseColor),
          )
        ]),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
            dec,
            style: descTx1(baseColor),
          )
        ]),
      ),
    ]);
  }
}
