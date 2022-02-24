import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

//
class DropdownSearchW {
  String value = "";
  late BuildContext context;
  DropdownSearch drop(List<Map<dynamic, dynamic>> item, String LableName,
      BuildContext context) {
    //dynamic values = "";

    return DropdownSearch<dynamic>(
      items: item,
      popupItemBuilder: (context, rr, isSelected) => (Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(rr["tt"].toString(), style: subtitleTx(baseColorText))
          ],
        ),
      )),

      showSelectedItems: false,
      mode: Mode.BOTTOM_SHEET,
      showClearButton: true,
      maxHeight: 400,
      showAsSuffixIcons: true,
      itemAsString: (item) => item["tt"],
      // showSelectedItems: true,
      dropdownSearchDecoration: InputDecoration(
        hintText: LableName,
        helperStyle: TextStyle(color: Colors.amber),
        contentPadding: EdgeInsets.symmetric(
            vertical: responsiveMT(10, 30), horizontal: responsiveMT(10, 20)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: bordercolor),
        ),
      ),
      validator: (value) {
        if (value == "" || value == null) {
          return "hgfef";
        } else {
          return null;
        }
      },
      showSearchBox: true,
      onChanged: (v) {
        print('object');
        print(v);

        value = v.toString();
        //value = v ?? "";
      },
      popupTitle: Container(
        height: 60,
        decoration: BoxDecoration(
          color: secondryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            LableName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      popupShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
    );
  }

  Widget _customDropDownExample(
      BuildContext context, List<Map<dynamic, dynamic>> item) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: (item[0]["ee"] == null)
          ? ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(),
              title: Text("No item selected"),
            )
          : ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                  // this does not work - throws 404 error
                  // backgroundImage: NetworkImage(item.avatar ?? ''),
                  ),
              title: Text(item[0]["ee"]),
              subtitle: Text(
                item[0]["ee"].toString(),
              ),
            ),
    );
  }
}
