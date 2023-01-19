import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CategoriesFilter extends StatefulWidget {
  CategoriesFilter({required this.GetCategories, Key? key}) : super(key: key);
  dynamic GetCategories;
  @override
  State<CategoriesFilter> createState() => _CategoriesFilterState();
}

class _CategoriesFilterState extends State<CategoriesFilter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  unCheckallboxs() {
    for (var x = 0; x < widget.GetCategories.length; x++) {
      widget.GetCategories[x]["selected"] = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar:
              AppBarW.appBarW("تصنيفات العروض", context, null, unCheckallboxs),
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
                  margin: EdgeInsets.all(10),
                  child: widget.GetCategories == null
                      ? Center(
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "لا يوجد تصنيفات",
                                  style: subtitleTx(secondryColorText),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            ...widget.GetCategories.map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    e["selected"] = e["selected"] == null
                                        ? true
                                        : !e["selected"];
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    decoration:
                                        containerdecoration(BackGWhiteColor),
                                    child: Row(
                                      children: [
                                        Text(
                                          e['CategoryName'].toString(),
                                          style: titleTx(baseColor),
                                        ),
                                        Spacer(),
                                        Checkbox(
                                          checkColor: Colors.white,
                                          value: e["selected"] == true
                                              ? true
                                              : false,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              e["selected"] = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            sizeBox(),
                          ],
                        ),
                ),
              ),
            ],
          )),
    );
  }
}
