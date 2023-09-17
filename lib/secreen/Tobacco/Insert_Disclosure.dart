import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/styles/CSS.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Insert_Disclosure extends StatefulWidget {
  Insert_Disclosure();

  @override
  State<Insert_Disclosure> createState() => _Insert_DisclosureState();
}

class _Insert_DisclosureState extends State<Insert_Disclosure> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController LicenseNo = TextEditingController();
  TextEditingController ShopNo = TextEditingController();
  TextEditingController DisclosureDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBarW.appBarW("التبغ", context, null),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "رقم الرخصه",
                      style: fontsStyle.px14(
                          fontsStyle.thirdColor(), FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //vacation day textform field
                    TextFormField(
                      controller: LicenseNo,
                      decoration: CSS.TextFieldDecoration('رقم الرخصة'),
                      style: fontsStyle.px14(Colors.grey, FontWeight.normal),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال رقم الرخصة';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "رقم المنشأة",
                      style: fontsStyle.px14(
                          fontsStyle.thirdColor(), FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //vacation day textform field
                    TextFormField(
                      controller: ShopNo,
                      decoration: CSS.TextFieldDecoration('رقم المنشأة'),
                      style: fontsStyle.px14(Colors.grey, FontWeight.normal),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال رقم المنشأة';
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "تاريخ الإفصاح",
                      style: fontsStyle.px14(
                          fontsStyle.thirdColor(), FontWeight.bold),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    //vacation day textform field
                    TextFormField(
                      controller: DisclosureDate,
                      decoration: CSS.TextFieldDecoration('تاريخ الإفصاح'),
                      style: fontsStyle.px14(Colors.grey, FontWeight.normal),
                      maxLines: 1,
                      onTap: () async {
                        dynamic dd = await showMonthPicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2040),
                          locale: Locale("ar"),
                          initialDate: DateTime.now(),
                        );
                        DisclosureDate.text = dd.toString().split(" ")[0];
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال تاريخ الإفصاح';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
