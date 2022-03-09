import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/testbase64.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/old/search.dart';

class CustomSearchDelegate extends SearchDelegate {
  BuildContext context;
  dynamic id;
  CustomSearchDelegate(this.context, this.id);

  final services1 = [
    ////شؤون الموظفين
    {
      "service_name": "طلب إجازة",
      "Navigation": "/VacationRequest",
      "icon": 'assets/SVGs/ejaza.svg',
    },
    {
      "service_name": "طلب خارج دوام",
      "Navigation": "/OutdutyRequest",
      "icon": 'assets/SVGs/kharejdawam.svg',
    },
    {
      "service_name": "رصيد إجازات",
      "Navigation": "",
      "icon": 'assets/SVGs/ejaza.svg'
    },
    {
      "service_name": "طلب إنتداب",
      "Navigation": "/entedab",
      "icon": 'assets/SVGs/entdab.svg',
    },
    //الرواتب
    {
      "service_name": "سجل الرواتب",
      "Navigation": "/SalaryHistory",
      "icon": 'assets/SVGs/sejelalrawatb.svg',
    },
    {
      "service_name": "تعريف بالراتب",
      "Navigation": "/auth_secreen",
      "icon": 'assets/SVGs/ta3refalratb.svg',
    },
    //مهامي

    //خدمات أخرى
    {
      "service_name": "الفعاليات",
      "Navigation": "",
      "icon": 'assets/SVGs/events.svg',
    },
    {
      "service_name": "عروض الموظفين",
      "Navigation": "/EamanaDiscount",
      "icon": 'assets/SVGs/offers.svg',
    },
    {
      "service_name": "دليل الموظفين",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpInfoView(null),
        ),
      ),
      "icon": 'assets/SVGs/dalelalmowzafen.svg',
    },
    {
      "service_name": "بيانات",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpProfile(null),
        ),
      ),
      "icon": 'assets/SVGs/baynaty.svg',
    },
  ];

  final services2 = [
    ////شؤون الموظفين
    ////شؤون الموظفين
    {
      "service_name": "طلب إجازة",
      "Navigation": "/VacationRequest",
      "icon": 'assets/SVGs/ejaza.svg',
    },
    {
      "service_name": "طلب خارج دوام",
      "Navigation": "/OutdutyRequest",
      "icon": 'assets/SVGs/kharejdawam.svg',
    },
    {
      "service_name": "رصيد إجازات",
      "Navigation": "",
      "icon": 'assets/SVGs/ejaza.svg'
    },
    {
      "service_name": "طلب إنتداب",
      "Navigation": "/entedab",
      "icon": 'assets/SVGs/entdab.svg',
    },
    //الرواتب
    {
      "service_name": "سجل الرواتب",
      "Navigation": "/SalaryHistory",
      "icon": 'assets/SVGs/sejelalrawatb.svg',
    },
    {
      "service_name": "تعريف بالراتب",
      "Navigation": "/auth_secreen",
      "icon": 'assets/SVGs/ta3refalratb.svg',
    },
    //مهامي
    {
      "service_name": "إعتماداتي",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EatemadatProvider(),
          // ignore: prefer_const_constructors
          child: InboxHedersView(),
        ),
      ),
      "icon": 'assets/SVGs/e3tmadaty.svg',
    },
    {
      "service_name": "مواعيدي",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => MettingsProvider(),
          // ignore: prefer_const_constructors
          child: MeetingView(),
        ),
      ),
      "icon": 'assets/SVGs/mawa3idi.svg',
    },
    //خدمات أخرى
    {
      "service_name": "الفعاليات",
      "Navigation": "",
      "icon": 'assets/SVGs/events.svg',
    },
    {
      "service_name": "عروض الموظفين",
      "Navigation": "/EamanaDiscount",
      "icon": 'assets/SVGs/offers.svg',
    },
    {
      "service_name": "دليل الموظفين",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpInfoView(null),
        ),
      ),
      "icon": 'assets/SVGs/dalelalmowzafen.svg',
    },
    {
      "service_name": "بيانات",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpProfile(null),
        ),
      ),
      "icon": 'assets/SVGs/baynaty.svg',
    },
  ];
  //did't use
  final rescntservices = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
            showSuggestions(context);
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var services = id == 1 ? services2 : services1;
    final suggestions = query.isEmpty
        ? services // replaced with rescntservices
        : services.where((s) {
            //   print(s["service_name"]);

            return s["service_name"].toString().contains(query);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<dynamic> suggestions) => ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            leading: SvgPicture.asset(
              suggestions[index]["icon"],
              width: responsiveMT(30, 35),
            ),
            // Icon(
            //   suggestions[index]["icon"],
            //   color: baseColor,
            // ),
            title: Text(
              suggestions[index]["service_name"],
              style: descTx1(baseColorText),
            ),
            onTap: () {
              query = suggestions[index]["service_name"];

              var navi = suggestions[index]["Navigation"].toString().isNotEmpty
                  ? suggestions[index]["Navigation"]
                  : '/home';

              print(query == "تعريف بالراتب");

              query == "تعريف بالراتب"
                  ? Navigator.pushNamed(context, "/auth_secreen").then((value) {
                      if (value == true) {
                        ViewFile.open(testbase64Pfd, "pdf");
                      }
                    })
                  : navi.runtimeType == String
                      ? Navigator.pushNamed(context, navi).then((value) {
                          close(this.context, null);
                        })
                      : Navigator.push(context, navi).then((value) {
                          close(this.context, null);
                        });
            },
          ),
        );
      });
}
