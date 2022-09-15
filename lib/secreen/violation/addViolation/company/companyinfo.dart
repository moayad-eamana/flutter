import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/hafreat.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/violationAdds.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

class companyinfo extends StatefulWidget {
  Function nextPage;
  companyinfo(this.nextPage);

  @override
  State<companyinfo> createState() => _companyinfoState();
}

class _companyinfoState extends State<companyinfo>
    with AutomaticKeepAliveClientMixin {
  var violationTypeID;

  List violationType = [
    {
      'violationTypeID': 1,
      'violationTypeName': 'مخالفة رخص اللوحات الاعلانية',
    },
    {
      'violationTypeID': 2,
      'violationTypeName': "مخالفات الحفريات",
    },
  ];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: BackGWhiteColor,
          border: Border.all(
            color: bordercolor,
          ),
          //color: baseColor,
          borderRadius: BorderRadius.all(
            new Radius.circular(4),
          ),
        ),
        child: Column(
          children: [
            dropdwn(),
            SizedBox(
              height: 10,
            ),
            if (violationTypeID == 1) violationAdds(widget.nextPage),
            if (violationTypeID == 2) hafreat(widget.nextPage)
          ],
        ),
      ),
    );
  }

  dropdwn() {
    return DropdownSearch<dynamic>(
      items: violationType,
      popupBackgroundColor: BackGWhiteColor,
      popupItemBuilder: (context, rr, isSelected) => (Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(rr["violationTypeName"].toString(),
                style: subtitleTx(baseColorText))
          ],
        ),
      )),
      dropdownBuilder: (context, selectedItem) => Container(
        decoration: null,
        child: selectedItem == null
            ? null
            : Text(
                selectedItem == null
                    ? ""
                    : selectedItem["violationTypeName"] ?? "",
                style: TextStyle(fontSize: 16, color: baseColorText)),
      ),
      dropdownBuilderSupportsNullItem: true,
      mode: Mode.BOTTOM_SHEET,
      showClearButton: violationTypeID == null ? false : true,
      maxHeight: 400,
      showAsSuffixIcons: true,
      dropdownSearchDecoration: formlabel1("نوع المخالفة"),
      validator: (value) {
        if (value == "" || value == null) {
          return "يرجى إختيار نوع المخالفة";
        } else {
          return null;
        }
      },
      showSearchBox: true,
      onChanged: (v) {
        try {
          setState(() {
            print(v);
            violationTypeID = v["violationTypeID"];
          });
        } catch (e) {}
      },
      popupTitle: Container(
        height: 60,
        decoration: BoxDecoration(
          color: secondryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            "نوع المخالفة",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      popupShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      emptyBuilder: (context, searchEntry) => Center(
        child: Text(
          "لا يوجد بيانات",
          style: TextStyle(
            color: baseColorText,
          ),
        ),
      ),
      searchFieldProps: TextFieldProps(
        textAlign: TextAlign.right,
        decoration: formlabel1(""),
        style: TextStyle(
          color: baseColorText,
        ),
        textDirection: TextDirection.rtl,
      ),
      clearButton: Icon(
        Icons.clear,
        color: baseColor,
      ),
      dropDownButton: Icon(
        Icons.arrow_drop_down,
        color: baseColor,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
