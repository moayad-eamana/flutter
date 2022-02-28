import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:eamanaapp/utilities/globalcss.dart';

class CustomSearchDelegate extends SearchDelegate {
  BuildContext context;
  dynamic id;
  CustomSearchDelegate(this.context);

  final dynamic services2 = [
    {
      "service_name": "طلب إجازة",
      "Navigation": "/VacationRequest",
      "icon": 'assets/SVGs/tadreb.svg',
    },
    {
      "service_name": "طلب خارج دوام",
      "Navigation": "/OutdutyRequest",
      "icon": 'assets/SVGs/tadreb.svg',
    },
    {
      "service_name": "رصيد إجازات",
      "Navigation": "/entedab",
      "icon": 'assets/SVGs/tadreb.svg'
    },
    {
      "service_name": "طلب إنتداب",
      "Navigation": "",
      "icon": 'assets/SVGs/tadreb.svg',
    },
    {
      "service_name": "طلب إعارة",
      "Navigation": "",
      "icon": 'assets/SVGs/tadreb.svg',
    },
    {
      "service_name": "طلب ترقية",
      "Navigation": "",
      "icon": 'assets/SVGs/tadreb.svg',
    },
    {
      "service_name": "تعريف بالراتب",
      "Navigation": "",
      "icon": 'assets/SVGs/tadreb.svg',
    },
    {
      "service_name": "إعتماداتي",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EatemadatProvider(),
          // ignore: prefer_const_constructors
          child: InboxHedersView(),
        ),
      ),
      "icon": 'assets/SVGs/tadreb.svg',
    },
  ];
  //did't use
  final rescntservices = [
    {
      "service_name": "طلب إجازة",
      "Navigation": "/VacationRequest",
      "icon": Icons.request_page,
    },
    {
      "service_name": "طلب خارج دوام",
      "Navigation": "/OutdutyRequest",
      "icon": Icons.note_add,
    },
    {
      "service_name": "رصيد إجازات",
      "Navigation": "/entedab",
      "icon": Icons.ac_unit
    },
    {
      "service_name": "طلب إنتداب",
      "Navigation": "/entedab",
      "icon": Icons.note_add,
    },
    {
      "service_name": "طلب إعارة",
      "Navigation": "",
      "icon": Icons.note_add,
    },
    {
      "service_name": "طلب ترقية",
      "Navigation": "",
      "icon": Icons.note_add,
    },
    {
      "service_name": "تعريف بالراتب",
      "Navigation": "",
      "icon": Icons.note_add,
    },
  ];

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
    final suggestions = query.isEmpty
        ? services2 // replaced with rescntservices
        : services2.where((s) {
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

              navi.runtimeType == String
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
