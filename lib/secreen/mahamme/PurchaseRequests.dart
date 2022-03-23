import 'package:eamanaapp/provider/mahamme/PurchaseRequestsProvider.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class PurchaseRequests extends StatefulWidget {
  @override
  State<PurchaseRequests> createState() => _PurchaseRequestsState();
}

class _PurchaseRequestsState extends State<PurchaseRequests> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      Provider.of<PurchaseRequestsProvider>(context, listen: false)
          .fetchPurchaseRequests();
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
        appBar: AppBarW.appBarW("طلب شراء", context, null),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            _provider.PurchaseRequestsList.length == 0
                ? Center(
                    child: Text("لايوجد بيانات"),
                  )
                : ListView.builder(
                    itemCount: _provider.PurchaseRequestsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            color: BackGWhiteColor,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _provider.PurchaseRequestsList[index]
                                          .EmployeeName,
                                      style: descTx1(baseColor),
                                      textAlign: TextAlign.right,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.call,
                                        color: baseColor,
                                      ),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                                widgetsUni.divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getText(
                                            "رقم الطلب :",
                                            _provider
                                                .PurchaseRequestsList[index]
                                                .RequestNumber
                                                .toString()),
                                        getText(
                                            "تاريخ الطلب :",
                                            _provider
                                                .PurchaseRequestsList[index]
                                                .RequestDate
                                                .split("T")[0]),
                                        getText(
                                            "نوع الطلب :",
                                            _provider
                                                .PurchaseRequestsList[index]
                                                .RequestType),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "حالة الطلب",
                                          style: subtitleTx(secondryColor),
                                        ),
                                        Text(
                                          _provider.PurchaseRequestsList[index]
                                              .RequestStatus,
                                          style: descTx1(secondryColorText),
                                        )
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    )
                                  ],
                                ),
                                Text(
                                  "التابع لادارة : " +
                                      _provider.PurchaseRequestsList[index]
                                          .Department,
                                  style: descTx1(secondryColorText),
                                ),
                                widgetsUni.divider(),
                                Text(
                                  "موضوع الطلب : " +
                                      _provider
                                          .PurchaseRequestsList[index].Subject,
                                  style: descTx1(secondryColorText),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }

  Widget getText(String tex1, String text2) {
    return RichText(
        //     textAlign: TextAlign.right,

        text:
            TextSpan(text: tex1, style: descTx1(secondryColorText), children: [
      TextSpan(
        style: subtitleTx(baseColorText),
        text: text2,
      )
    ]));
  }
}
