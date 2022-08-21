import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AddContact extends StatefulWidget {
  Function addNewContact;
  AddContact(this.addNewContact);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _eamail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إضافة جهة إتصال جديدة", context, null),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Image.asset(
                imageBG,
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: BackGWhiteColor,
                      border: Border.all(color: bordercolor)),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _firstName,
                        style: TextStyle(
                          color: baseColorText,
                        ),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: formlabel1("الاسم الأول"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _lastName,
                        style: TextStyle(
                          color: baseColorText,
                        ),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: formlabel1("الاسم الأخير"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _phone,
                        style: TextStyle(
                          color: baseColorText,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: formlabel1("رقم الجوال"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لابد من إدخال رقم الجوال';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _eamail,
                        style: TextStyle(
                          color: baseColorText,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: formlabel1("البريد الإلكتروني"),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 100,
                        child: widgetsUni.actionbutton(
                          'حفظ',
                          Icons.save,
                          () async {
                            widget.addNewContact(_firstName.text,
                                _lastName.text, _phone.text, _eamail.text);
                            final contact =
                                await FlutterContacts.openExternalInsert();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
