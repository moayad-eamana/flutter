import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:sizer/sizer.dart';

Future<void> vcardbottomsheet(BuildContext context, String vCard) {
  TextEditingController _fn = TextEditingController();
  TextEditingController _ln = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _workLocation =
      TextEditingController(text: "أمانة المنطقة الشرقية");
  TextEditingController _jobTitle = TextEditingController();
  var contact = Contact.fromVCard(vCard);
  _fn.text = contact.name.first;
  _ln.text = contact.name.last;
  _phone.text = contact.phones.first.number;
  _email.text = contact.emails.first.address;
  _workLocation.text = contact.organizations.first.company;
  _jobTitle.text = contact.organizations.first.title;

  return showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: BackGColor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: 80.h,
              padding: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _fn,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(color: baseColorText),
                        decoration: formlabel1("الاسم الاول"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _ln,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(color: baseColorText),
                        decoration: formlabel1("الاسم الاخير"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _phone,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(color: baseColorText),
                        decoration: formlabel1("رقم الجوال"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(color: baseColorText),
                        decoration: formlabel1("الايميل"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _workLocation,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(color: baseColorText),
                        decoration: formlabel1("جهة العمل"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        enabled: false,
                        controller: _jobTitle,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(color: baseColorText),
                        decoration: formlabel1("جهة العمل"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        child: const Text('حفظ للجهات الاتصال'),
                        onPressed: () async {
                          if (await FlutterContacts.requestPermission()) {
                            final newContact = Contact()
                              ..name.first = _fn.text
                              ..name.last = _ln.text
                              ..phones = [Phone(_phone.text)]
                              ..organizations = [
                                Organization(
                                    company: _workLocation.text,
                                    title: _jobTitle.text)
                              ]
                              ..emails = [Email(_email.text)];

                            await newContact.insert();
                          }

                          Alerts.successAlert(context, "", "تم الحفظ")
                              .show()
                              .then((value) async {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
