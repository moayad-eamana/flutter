import 'package:device_preview/device_preview.dart';
import 'package:eamanaapp/model/EmpInfo.dart';
import 'package:eamanaapp/provider/loginProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Login/OTPView.dart';
import 'package:eamanaapp/secreen/Meetings/AddMeeting.dart';
import 'package:eamanaapp/secreen/Meetings/EditMeetingView.dart';
import 'package:eamanaapp/secreen/Transaction/TransactionDetail.dart';
import 'package:eamanaapp/secreen/Transaction/transaction.dart';
import 'package:eamanaapp/secreen/eatemadat/HRdetailsView.dart';
import 'package:eamanaapp/secreen/eatemadat/HrDecisionsView.dart';
import 'package:eamanaapp/secreen/eatemadat/HrRequestsView.dart';
import 'package:eamanaapp/secreen/globalcss.dart';
import 'package:eamanaapp/secreen/tab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(
    MyApp(),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.blue
    ..textColor = Colors.blue
    ..maskColor = Colors.black
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//    useInheritedMediaQuery: true,
      //  locale: DevicePreview.locale(context),
      //  builder: (context, myWidget) {
      //    // do your initialization here
      //   myWidget = DevicePreview.appBuilder(context, myWidget);
      //   myWidget = BotToastInit()(context, myWidget);
      //    myWidget = EasyLoading.init()(context, myWidget);
      //    return myWidget;
      //   },

      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
        tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Cairo"), // color for text
            indicator: UnderlineTabIndicator(
                // color for indicator (underline)
                borderSide: BorderSide(color: baseColor))),
        primaryColor: Colors.green[800], // outdated and has no effect to Tabbar
        accentColor: Colors.cyan[600],
        bottomAppBarColor: Colors.amber,
        buttonColor: Colors.amber,

        // deprecated,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TabBarDemo(),
        '/TabBarDemo': (context) => ChangeNotifierProvider(
              create: (_) => LoginProvider(),
              child: TabBarDemo(),
            ),
        '/tab': (context) => const TabBarDemo(),
        '/transaction': (context) => TransactionsView(),
        '/TransactionDetail': (context) => TransactionDetail(),
        '/OTPView': (context) => const OTPView(),
        '/HrRequestsView': (context) => const HrRequestsView(),
        '/HRdetailsView': (context) => HRdetailsView(),
        '/EditMeetingView': (context) => EditMeetingView(0),
        '/AddMeeting': (context) => AddMeeting(),
        '/EmpInfoView': (context) => EmpInfoView(),
        '/Empprofile': (context) => EmpProfile(),
        '/HrDecisionsView': (context) => HrDecisionsView(),
      },
    );
  }
}
