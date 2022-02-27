import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/secreen/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({Key? key}) : super(key: key);

  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  String usernam = "drefr";
  void initState() {
    getuser();
    super.initState();
  }

  Future<void> getuser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    // setState(() {
    //  usernam = _pref.getString("username") as String;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: usernam == "" ? 4 : 4,
      length: usernam == "" ? 5 : 5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffDBF3FF),
                Color(0xffE8FEFF),
              ],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/SVGs/header.png',
                  //width: 100,
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Container(
              width: double.maxFinite,
              color: Colors.white,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabBar(
                      //padding: EdgeInsets.all(0),
                      isScrollable: true,
                      tabs: usernam == ""
                          ? [
                              Tab(
                                text:
                                    "إحصائيات", //jahgssssssswdjhqgewdjqewssserfjekrgjhkjerj k 3rhgk jh3rkgjhs sfdkljdhgkjhrg mhsdfgjehrgf wmjfhjwehfjkwhe sdjhfgjsdhgf shfnsdhnh
                              ),
                              Tab(
                                text: "دليل الموظفين",
                              ),
                              Tab(
                                text: "اعتماداتي",
                              ),
                            ]
                          : [
                              Tab(
                                text: "لوحة البيانات",
                              ),
                              Tab(
                                text: "إحصائيات",
                              ),
                              Tab(
                                text: "دليل الموظفين",
                              ),
                              Tab(
                                text: "اعتماداتي",
                              ),
                              Tab(
                                text: "مواعيدي",
                              ),
                            ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
            children: usernam == ""
                ? [
                    ChangeNotifierProvider(
                      create: (_) => EmpInfoProvider(),
                      // ignore: prefer_const_constructors
                      child: EmpProfile(null),
                    ),
                    Statistics(),
                    ChangeNotifierProvider(
                      create: (context) => EatemadatProvider(),
                      // ignore: prefer_const_constructors
                      child: InboxHedersView(),
                    ),
                  ]
                : [
                    ChangeNotifierProvider(
                      create: (_) => EmpInfoProvider(),
                      // ignore: prefer_const_constructors
                      child: EmpProfile(null),
                    ),
                    Statistics(),
                    ChangeNotifierProvider(
                      create: (_) => EmpInfoProvider(),
                      // ignore: prefer_const_constructors
                      child: EmpInfoView(null),
                    ),
                    ChangeNotifierProvider(
                      create: (context) => EatemadatProvider(),
                      // ignore: prefer_const_constructors
                      child: InboxHedersView(),
                    ),
                    ChangeNotifierProvider(
                      create: (_) => MettingsProvider(),
                      // ignore: prefer_const_constructors
                      child: MeetingView(),
                    ),
                  ]),
      ),
    );
  }
}
