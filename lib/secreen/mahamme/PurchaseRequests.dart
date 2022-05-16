import 'package:eamanaapp/provider/mahamme/PurchaseRequestsProvider.dart';
import 'package:eamanaapp/secreen/mahamme/PurchaseRequestsDetails.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:url_launcher/url_launcher.dart';

class PurchaseRequests extends StatefulWidget {
  int id;
  PurchaseRequests(this.id);
  @override
  State<PurchaseRequests> createState() => _PurchaseRequestsState();
}

class _PurchaseRequestsState extends State<PurchaseRequests> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      Provider.of<PurchaseRequestsProvider>(context, listen: false)
          .fetchPurchaseRequests(widget.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _provider =
        Provider.of<PurchaseRequestsProvider>(context, listen: true);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إعتماد شراء", context, null),
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider.value(
                                        value: _provider,
                                        child: PurchaseRequestsDetails(
                                            index, widget.id)),
                              ),
                            );
                          },
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
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.call,
                                              color: baseColor,
                                            ),
                                            onPressed: () {
                                              launch("tel://" +
                                                  _provider
                                                      .PurchaseRequestsList[
                                                          index]
                                                      .MobileNumber
                                                      .toString());
                                            },
                                          ),
                                          IconButton(
                                              icon: FaIcon(
                                                FontAwesomeIcons.whatsapp,
                                                color: baseColor,
                                                size: 24.0,
                                              ),
                                              onPressed: () {
                                                launch("https://wa.me/+966" +
                                                    _provider
                                                        .PurchaseRequestsList[
                                                            index]
                                                        .MobileNumber +
                                                    "/");
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                  widgetsUni.divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
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
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "حالة الطلب",
                                                style:
                                                    subtitleTx(secondryColor),
                                              ),
                                              Text(
                                                _provider
                                                    .PurchaseRequestsList[index]
                                                    .RequestStatus,
                                                style:
                                                    descTx1(secondryColorText),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15,
                                          )
                                        ],
                                      ),
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
                                        _provider.PurchaseRequestsList[index]
                                            .Subject,
                                    style: descTx1(secondryColorText),
                                  )
                                ],
                              ),
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
    return Text.rich(
        TextSpan(text: tex1, style: descTx1(secondryColorText), children: [
      TextSpan(
        style: subtitleTx(baseColorText),
        text: text2,
      )
    ]));
  }
}
