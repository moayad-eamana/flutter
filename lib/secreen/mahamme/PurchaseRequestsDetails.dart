import 'package:eamanaapp/provider/mahamme/PurchaseRequestsProvider.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
      Provider.of<PurchaseRequestsProvider>(context, listen: false)
          .fetchPurchaseRequestItemst(
              _provider.PurchaseRequestsList[widget.index].RequestNumber);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider =
        Provider.of<PurchaseRequestsProvider>(context, listen: true);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("إعتماد طلب مشتريات", context, null),
          body: Stack(
            children: [
              Image.asset(
                imageBG,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _provider.PurchaseRequestItemsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              // margin:
                              //     EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 1,
                                    child: Container(
                                      color: BackGWhiteColor,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
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
                                                color: Colors.black,
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
                      SizedBox(
                        height: 10,
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
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: bordercolor)),
                                filled: true,
                                fillColor: BackGWhiteColor,
                                labelText: "ملاحظات",
                                alignLabelWithHint: true,
                              ),
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
                              if (_formKey.currentState!.validate()) {
                                dynamic res =
                                    await _provider.ApprovePurchasesRequest(
                                        widget.index,
                                        _note.text,
                                        true,
                                        widget.id);

                                if (res == true) {
                                  Alerts.successAlert(
                                          context, "", "تم الإعتماد ")
                                      .show()
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                } else {
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
                              if (_formKey.currentState!.validate()) {
                                if (_formKey.currentState!.validate()) {
                                  dynamic res =
                                      await _provider.ApprovePurchasesRequest(
                                          widget.index,
                                          _note.text,
                                          false,
                                          widget.id);

                                  if (res == true) {
                                    Alerts.successAlert(
                                            context, "", "تم الرفض ")
                                        .show()
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  } else {
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
              )
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
