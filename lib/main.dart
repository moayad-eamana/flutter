import 'package:eamanaapp/provider/login/loginProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Login/OTPView.dart';
import 'package:eamanaapp/secreen/Login/loginView.dart';
import 'package:eamanaapp/secreen/Meetings/AddMeeting.dart';
import 'package:eamanaapp/secreen/Meetings/EditMeetingView.dart';
import 'package:eamanaapp/secreen/mahamme/HRdetailsView.dart';
import 'package:eamanaapp/secreen/mahamme/HrDecisionsView.dart';
import 'package:eamanaapp/secreen/mahamme/HrRequestsView.dart';
import 'package:eamanaapp/secreen/main_home.dart';
import 'package:eamanaapp/secreen/services/servicesView.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

/*
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences? sharedPref = await SharedPreferences.getInstance();
  String? username = sharedPref.getString("username");
//  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//  await Firebase.initializeApp();
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

class MyApp extends StatefulWidget {
  String? username;
  MyApp(this.username);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  //FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*
    getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    */
  }

  getToken() async {
    /*
    String? token = await messaging.getToken();
    print(token);
    */
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      print(SizerUtil.deviceType);
      return MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'رقمي',
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
          primaryColor:
              Colors.green[800], // outdated and has no effect to Tabbar
          accentColor: Colors.cyan[600],
          bottomAppBarColor: Colors.amber,
          buttonColor: Colors.amber,

          // deprecated,
        ),
        initialRoute: '/home',
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
          '/home': (context) => const TabBarDemo(),
          '/OTPView': (context) => const OTPView(),
          '/HrRequestsView': (context) => const HrRequestsView(),
          '/HRdetailsView': (context) => HRdetailsView(),
          '/EditMeetingView': (context) => EditMeetingView(0),
          '/AddMeeting': (context) => AddMeeting(),
          '/EmpInfoView': (context) => EmpInfoView(),
          '/Empprofile': (context) => EmpProfile(),
          '/HrDecisionsView': (context) => HrDecisionsView(),
          '/services': (context) => ServicesView(),
          '/mainhome': (context) => MainHome(),
        },
      );
    });
  }
}
