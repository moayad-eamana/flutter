import 'package:eamanaapp/auth_secreen.dart';
import 'package:eamanaapp/provider/login/loginProvider.dart';
import 'package:eamanaapp/secreen/EamanaDiscount/EamanaDiscount.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Login/OTPView.dart';
import 'package:eamanaapp/secreen/Login/loginView.dart';
import 'package:eamanaapp/secreen/Meetings/AddMeeting.dart';
import 'package:eamanaapp/secreen/Meetings/EditMeetingView.dart';
import 'package:eamanaapp/secreen/RequestsHr/auhad.dart';
import 'package:eamanaapp/secreen/RequestsHr/entedab.dart';
import 'package:eamanaapp/secreen/RequestsHr/outduty_request.dart';
import 'package:eamanaapp/secreen/auth.dart';
import 'package:eamanaapp/secreen/community.dart';
import 'package:eamanaapp/secreen/mahamme/HRdetailsView.dart';
import 'package:eamanaapp/secreen/mahamme/HrDecisionsView.dart';
import 'package:eamanaapp/secreen/mahamme/HrRequestsView.dart';
import 'package:eamanaapp/secreen/main_home.dart';
import 'package:eamanaapp/secreen/salary/salaryHistory.dart';
import 'package:eamanaapp/secreen/services/servicesView.dart';
import 'package:eamanaapp/secreen/RequestsHr/vacation_request.dart';
import 'package:eamanaapp/secreen/settings.dart';
import 'package:eamanaapp/secreen/home.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: baseColor,
  // ));
  //new aksjdhlkajswhdlkajshdwliuagdLIUYSDWGQ
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences? sharedPref = await SharedPreferences.getInstance();
  setSettings();
  //Settings.getSettings();
  getColorSettings();
  //getfingerprintSettings();
  double? username;
  try {
    username = sharedPref.getDouble("EmployeeNumber");
  } catch (e) {}

//  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//  await Firebase.initializeApp();
  runApp(
    MyApp(username),
  );
  configLoading();
}

void setSettings() async {
  final settingSP = await SharedPreferences.getInstance();

  if (settingSP.getBool('fingerprint') == null) {
    settingSP.setBool("fingerprint", false);
  }

  if (settingSP.getBool('blindness') == null) {
    settingSP.setBool("blindness", false);
  }

  if (settingSP.getBool('darkmode') == null) {
    settingSP.setBool("darkmode", false);
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = baseColor
    ..backgroundColor = Colors.white
    ..indicatorColor = baseColor
    ..textColor = baseColor
    ..maskColor = baseColor.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  double? username;
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
    getfingerprintSettings();

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

  bool fingerprint = false;
  bool darkmode = false;

  void getfingerprintSettings() async {
    final settingSP = await SharedPreferences.getInstance();

    fingerprint = settingSP.getBool("fingerprint")!;
    darkmode = settingSP.getBool("darkmode")!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      print(SizerUtil.deviceType);
      return MaterialApp(
        navigatorKey: navigatorKey,
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'رقمي',
        theme: ThemeData(
          //dark mode

          //brightness: Brightness.light,
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

          // primaryColor:
          //     Colors.green[800], // outdated and has no effect to Tabbar
          // accentColor: Colors.cyan[600],
          // bottomAppBarColor: Colors.amber,
          // buttonColor: Colors.amber,
          // deprecated,
        ),
        initialRoute: widget.username == null || widget.username == ""
            ? "/"
            : fingerprint == false
                ? '/home'
                : '/AuthenticateBio',
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
          '/home': (context) => TabBarDemo(),
          '/OTPView': (context) => OTPView(),
          '/HrRequestsView': (context) => HrRequestsView(),
          '/HRdetailsView': (context) => HRdetailsView(),
          '/EditMeetingView': (context) => EditMeetingView(0),
          '/AddMeeting': (context) => AddMeeting(),
          '/EmpInfoView': (context) => EmpInfoView(null),
          '/Empprofile': (context) => EmpProfile(null),
          '/HrDecisionsView': (context) => HrDecisionsView(),
          '/services': (context) => ServicesView(),
          '/EamanaDiscount': (context) => EamanaDiscount(),
          '/VacationRequest': (context) => VacationRequest(),
          '/entedab': (context) => Entedab(),
          '/OutdutyRequest': (context) => OutdutyRequest(),
          '/Settings': (context) => Settings(
                () {},
              ),
          '/AuthenticateBio': (context) => AuthenticateBio(),
          '/auhad': (context) => Auhad(),
          '/auth_secreen': (context) => AuthenticateBioSecreen(),
          '/SalaryHistory': (context) => SalaryHistory(),
        },
      );
    });
  }

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
