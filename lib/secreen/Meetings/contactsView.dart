import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactsView extends StatefulWidget {
  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  @override
  Widget build(BuildContext context) {
    dynamic contact = ModalRoute.of(context)!.settings.arguments;
    print(contact);
    print(contact);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Image.asset(
                imageBG,
                fit: BoxFit.fill,
              ),
            ),
            ListView.builder(
              itemCount: contact.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(contact[index].phones.first.number);
                    Navigator.pop(context, {
                      "name": contact[index].displayName ?? "",
                      "No": contact[index].phones.first.number
                    });
                  },
                  child: Card(
                    color: BackGWhiteColor,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text(
                        contact[index].displayName ?? "",
                        style: titleTx(secondryColor),
                      ),
                      subtitle: Text(
                        contact[index].phones.first.number,
                        style: descTx1(baseColorText),
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
