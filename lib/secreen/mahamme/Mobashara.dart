import 'package:eamanaapp/provider/mahamme/MobasharaProvider.dart';
import 'package:eamanaapp/secreen/mahamme/MobasharaDetails.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class Mobashara extends StatefulWidget {
  int TypeID;
  Mobashara(this.TypeID);
  @override
  State<Mobashara> createState() => _MobasharaState();
}

class _MobasharaState extends State<Mobashara> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      Provider.of<MobasharaProvider>(context, listen: false)
          .fetchMobashara(widget.TypeID);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement DevTeamdispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<MobasharaProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إعتماد مباشرة عمل", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            _provider.MobasharaList.length == 0
                ? Center(
                    child: Text(
                      "لا يوجد بيانات",
                      style: subtitleTx(baseColorText),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: ListView.builder(
                        itemCount: _provider.MobasharaList.length,
                        itemBuilder: (BuildContext contex, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider.value(
                                              value: _provider,
                                              child: MobasharaDetails(
                                                index,
                                              )),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 1,
                                  child: Container(
                                    color: BackGWhiteColor,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      children: [
                                        Center(
                                            child: Text(
                                          _provider.MobasharaList[index]
                                              .EmployeeName,
                                          style: titleTx(baseColorText),
                                        )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "تاريخ الحركة",
                                                  style: subtitleTx(
                                                      secondryColorText),
                                                ),
                                                Text(
                                                  _provider.MobasharaList[index]
                                                      .StartDate
                                                      .split("T")[0],
                                                  style: descTx1(baseColorText),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "نوع الحركة",
                                                  style: subtitleTx(
                                                      secondryColorText),
                                                ),
                                                Container(
                                                  child: Text(
                                                    _provider
                                                        .MobasharaList[index]
                                                        .OrderType,
                                                    style:
                                                        descTx1(baseColorText),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: Divider(
                                            endIndent: 8,
                                            indent: 8,
                                            thickness: 0.5,
                                            height: 20,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  child: Text("التفاصيل")),
                                              Icon(Icons.arrow_back_ios_new)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              //  color: Colors.white,)
                            ],
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }

  // Card(
  //                             elevation: 2,
  //                             child: Container(
  //                               color: BackGWhiteColor,
  //                               height: 120,
  //                               width: 90.w,
  //                               //margin: EdgeInsets.symmetric(horizontal: 10),
  //                               padding: EdgeInsets.symmetric(vertical: 10),
  //                               child: Column(
  //                                 children: [
  //                                   Text(
  //                                     List[index]["EmployeeName"].toString(),
  //                                     style: titleTx(baseColorText),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 10,
  //                                   ),
  //                                   Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.spaceAround,
  //                                     children: [
  //                                       RichText(
  //                                           text: TextSpan(
  //                                               text: "الرقم الوظيفي : ",
  //                                               style: descTx1(
  //                                                   secondryColorText),
  //                                               children: [
  //                                             TextSpan(
  //                                                 style: subtitleTx(
  //                                                     baseColorText),
  //                                                 text: List[index]
  //                                                         ["EmployeeNumber"]
  //                                                     .toString())
  //                                           ])),
  //                                       RichText(
  //                                           text: TextSpan(
  //                                               text: "تاريخ الحركة : ",
  //                                               style: descTx1(
  //                                                   secondryColorText),
  //                                               children: [
  //                                             TextSpan(
  //                                                 style: subtitleTx(
  //                                                     baseColorText),
  //                                                 text: List[index]
  //                                                         ["StartDate"]
  //                                                     .toString()
  //                                                     .split("T")[0])
  //                                           ])),
  //                                     ],
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           )

}
