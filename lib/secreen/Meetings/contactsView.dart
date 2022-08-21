import 'dart:convert';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsView extends StatefulWidget {
  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  final TextEditingController _queryTextController = TextEditingController();
  dynamic contactd = [];
  dynamic contact = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      contact = ModalRoute.of(context)!.settings.arguments;
      contact = jsonEncode(contact);
      contact = jsonDecode(contact);
      contactd = jsonEncode(contact);
      contactd = jsonDecode(contactd);
      setState(() {});
    });
  }

  addNewContact(String firstName, String lastName, String phone, String email) {
    print(firstName);
    int arrlengt = contact.length;

    contactd.add({
      "displayName": firstName + " " + lastName,
      "phones": [
        {"number": phone}
      ]
    });
    contact.add({
      "displayName": firstName + " " + lastName,
      "phones": [
        {"number": phone}
      ]
    });
    // contact[arrlengt]["displayName"] = firstName + " " + lastName;
    // contactd[arrlengt]["displayName"] = firstName + " " + lastName;
    // contactd[arrlengt]["phones"][0]["number"] = phone;
    // contact[contact]["phones"][0]["number"] = phone;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            dynamic p = await FlutterContacts.openExternalInsert();
            p = jsonEncode(p);
            p = jsonDecode(p);
            contactd.add({
              "displayName": p["displayName"],
              "phones": [
                {"number": p["phones"][0]["number"]}
              ]
            });
            contact.add({
              "displayName": p["displayName"],
              "phones": [
                {"number": p["phones"][0]["number"]}
              ]
            });
            setState(() {});
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => AddContact(addNewContact)),
            // );
          },
          backgroundColor: baseColor,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: baseColorText),
          backgroundColor: BackGColor,
          title: TextField(
            controller: _queryTextController,
            // focusNode: focusNode,
            style: subtitleTx(baseColorText),

            onChanged: (String text) {
              bool isFound = false;
              if (text.isEmpty) {
                setState(() {
                  contactd = jsonEncode(contact);
                  contactd = jsonDecode(contactd);
                });
              } else {
                print(contact.length);
                contactd = [];
                for (int i = 0; i <= contact.length - 1; i++) {
                  // print(i);
                  if (contact[i]["displayName"]
                      .toString()
                      .toUpperCase()
                      .contains(text.toUpperCase())) {
                    isFound = true;
                    setState(() {
                      contactd.add(contact[i]);
                    });
                  }
                }
                setState(() {
                  contactd = contactd;
                });
                if (isFound == false) {
                  contactd = [];
                  setState(() {});
                }
              }

              // print("ssssssssssssssssssssssssssssssssssss");
              // print(contactd);
              // dynamic contactd = contact.where((s) {
              //   return s.displayName.contains(text);
              // });
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "البحث",
                hintStyle: subtitleTx(baseColorText)),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.clear),
              color: baseColorText,
              onPressed: () {
                _queryTextController.clear();
                setState(() {
                  contactd = contact;
                });
                // handle the press
              },
            ),
          ],
          // bottom: widget.delegate.buildBottom(context),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Image.asset(
                imageBG,
                fit: BoxFit.fill,
              ),
            ),
            contactd.length == 0
                ? Center(
                    child: Text(
                      "لا يوجد بيانات",
                      style: subtitleTx(secondryColorText),
                    ),
                  )
                : ListView.builder(
                    itemCount: contactd.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //   print(contactd[index]["phones"].first.number);
                          Navigator.pop(context, {
                            "name": contactd[index]["displayName"] ?? "",
                            "No": contactd[index]["phones"].length == 0
                                ? ""
                                : contactd[index]["phones"][0]["number"]
                                    .toString()
                                    .replaceAll(" ", "")
                                    .toString()
                                    .replaceAll("-", "")
                                    .toString()
                                    .replaceAll("(", "")
                                    .toString()
                                    .replaceAll(")", "")
                                    .toString()
                                    .replaceAll("+", "")
                          });
                        },
                        child: Card(
                          color: BackGWhiteColor,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: ListTile(
                            title: Text(
                              contactd[index]["displayName"] ?? "",
                              style: titleTx(secondryColor),
                            ),
                            subtitle: Text(
                              contactd[index]["phones"].length == 0
                                  ? "لا يوجد رقم"
                                  : contactd[index]["phones"][0]["number"],
                              style: descTx1(baseColorText),
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.right,
                            ),
                            // contentPadding:
                            //     EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          ),
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
