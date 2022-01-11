import 'package:eamanaapp/provider/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/eatemadatProvider.dart';
import 'package:eamanaapp/provider/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EmpInfo/EmpInfoView.dart';
import 'eatemadat/InboxHedersView.dart';

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({Key? key}) : super(key: key);

  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  String usernam = "";
  void initState() {
    getuser();
    super.initState();
  }

  Future<void> getuser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      usernam = _pref.getString("username") as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: usernam == "4438104" ? 2 : 4,
      length: usernam == "4438104" ? 3 : 5,
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
                      tabs: usernam == "4438104"
                          ? [
                              Tab(
                                text: "إحصائيات",
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
            children: usernam == "4438104"
                ? [
                    ChangeNotifierProvider(
                      create: (_) => EmpInfoProvider(),
                      // ignore: prefer_const_constructors
                      child: EmpProfile(),
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
                      child: EmpProfile(),
                    ),
                    Statistics(),
                    ChangeNotifierProvider(
                      create: (_) => EmpInfoProvider(),
                      // ignore: prefer_const_constructors
                      child: EmpInfoView(),
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
