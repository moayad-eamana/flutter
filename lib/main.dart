import 'package:eamanaapp/provider/loginProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Login/OTPView.dart';
import 'package:eamanaapp/secreen/Login/loginView.dart';
import 'package:eamanaapp/secreen/Meetings/AddMeeting.dart';
import 'package:eamanaapp/secreen/Meetings/EditMeetingView.dart';
import 'package:eamanaapp/secreen/Transaction/TransactionDetail.dart';
import 'package:eamanaapp/secreen/Transaction/transaction.dart';
import 'package:eamanaapp/secreen/eatemadat/HRdetailsView.dart';
import 'package:eamanaapp/secreen/eatemadat/HrDecisionsView.dart';
import 'package:eamanaapp/secreen/eatemadat/HrRequestsView.dart';
import 'package:eamanaapp/secreen/globalcss.dart';
import 'package:eamanaapp/secreen/tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences? sharedPref = await SharedPreferences.getInstance();
  String? username = sharedPref.getString("username");
  runApp(
    MyApp(username),
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
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  String? username;
  MyApp(this.username);

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
        tabBarTheme: const TabBarTheme(
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
      initialRoute: username == null || username == "" ? '/' : '/TabBarDemo',
      routes: {
        '/': (context) => ChangeNotifierProvider(
              create: (_) => LoginProvider(),
              child: LoginView(),
            ),
        '/TabBarDemo': (context) => ChangeNotifierProvider(
              create: (_) => LoginProvider(),
              child: TabBarDemo(),
            ),
        '/loginView': (context) => ChangeNotifierProvider(
              create: (_) => LoginProvider(),
              child: LoginView(),
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
