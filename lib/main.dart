import 'package:eamanaapp/auth_secreen.dart';
import 'package:eamanaapp/events.dart';
import 'package:eamanaapp/provider/login/loginProvider.dart';
import 'package:eamanaapp/secreen/EamanaDiscount/EamanaDiscount.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Home/panel&NavigationBar.dart';
import 'package:eamanaapp/secreen/Login/OTPView.dart';
import 'package:eamanaapp/secreen/Login/loginView.dart';
import 'package:eamanaapp/secreen/Meetings/AddMeeting.dart';
import 'package:eamanaapp/secreen/Meetings/EditMeetingView.dart';
import 'package:eamanaapp/secreen/RequestsHr/auhad.dart';
import 'package:eamanaapp/secreen/RequestsHr/entedab.dart';
import 'package:eamanaapp/secreen/RequestsHr/outduty_request.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/Mandates_history.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/OutDuties_history.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/vacation_history_request.dart';
import 'package:eamanaapp/secreen/Settings/settings%20copy.dart';
import 'package:eamanaapp/secreen/Settings/settings.dart';
import 'package:eamanaapp/secreen/auth.dart';
import 'package:eamanaapp/secreen/community/comments.dart';
import 'package:eamanaapp/secreen/mahamme/HRdetailsView.dart';
import 'package:eamanaapp/secreen/mahamme/HrDecisionsView.dart';
import 'package:eamanaapp/secreen/mahamme/HrRequestsView.dart';
import 'package:eamanaapp/secreen/salary/salaryHistory.dart';
import 'package:eamanaapp/secreen/services/servicesView.dart';
import 'package:eamanaapp/secreen/RequestsHr/vacation_request.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null) {
//     print(message.data);
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           playSound: true,
//           color: Colors.blue,
//           icon: '@mipmap/ic_launcher',
//         ),
//       ),
//     );
//   }

//   print("Handling a background message: ${message.messageId}");
// }

// late AndroidNotificationChannel channel;

// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

final navigatorKey = GlobalKey<NavigatorState>();
dynamic hasePerm = "";
late PackageInfo packageInfo;
late SharedPreferences sharedPref;
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: baseColor,
  ));

  //new aksjdhlkajswhdlkajshdwliuagdLIUYSDWGQ
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();
  sharedPref = await SharedPreferences.getInstance();
  hasePerm = sharedPref.getString("hasePerm");

  // channel = const AndroidNotificationChannel(
  //   'high_importance_channel', // id
  //   'High Importance Notifications', // title
  //   // description
  //   showBadge: true,

  //   importance: Importance.high,
  // );

  // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // await Firebase.initializeApp();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   print('User granted permission');
  // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //   print('User granted provisional permission');
  // } else {
  //   print('User declined or has not accepted permission');
  // }
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //  Create an Android Notification Channel.

  //  We use this channel in the `AndroidManifest.xml` file to override the
  //  default FCM channel to enable heads up notifications.
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true, // Required to display a heads up notification
  //   badge: true,
  //   sound: true,
  // );

  //Settings.getSettings();
  setSettings();
  getColorSettings();
  //getfingerprintSettings();
  double? username;
  try {
    username = sharedPref.getDouble("EmployeeNumber");
  } catch (e) {}

  runApp(
    MyApp(username),
  );
  configLoading();
}

void setSettings() async {
  //final settingSP = await SharedPreferences.getInstance();

  if (sharedPref.getBool('fingerprint') == null) {
    sharedPref.setBool("fingerprint", false);
  }

  if (sharedPref.getBool('blindness') == null) {
    sharedPref.setBool("blindness", false);
  }

  if (sharedPref.getBool('darkmode') == null) {
    sharedPref.setBool("darkmode", false);
  }

  if (sharedPref.getBool('onboarding') == null) {
    sharedPref.setBool("onboarding", false);
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
    ..backgroundColor = BackGWhiteColor
    ..indicatorColor = baseColor
    ..textColor = baseColor
    ..maskColor = baseColor.withOpacity(0.5)
    ..userInteractions = true
    ..indicatorWidget = Container(
      height: 80,
      width: 100,
      child: Image(image: AssetImage("assets/image/rakamy-logo-21.png")),
    )
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

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfingerprintSettings();

    if (widget.username != null && widget.username != 0) {
      DateTime time = DateTime.parse(sharedPref.getString("tokenTime") ?? "");

      print(DateTime.now());
      if (time.compareTo(DateTime.now()) == 0 ||
          time.compareTo(DateTime.now()) < 0) {
        // unsubscribeFromNotofication();
        widget.username = null;
      }
    }

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     print(message.data);
    //     flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel.id,
    //           channel.name,
    //           visibility: NotificationVisibility.public,
    //           color: Colors.blue,
    //           icon: '@mipmap/launcher_icon',
    //         ),
    //       ),
    //     );
    //   }
    // });
    // getToken();
  }

  // getToken() async {
  //   String? token = await messaging.getToken();
  //   await FirebaseMessaging.instance.subscribeToTopic('raqame_eamana');
  //   print(token);
  // }

  // unsubscribeFromNotofication() async {
  //   await FirebaseMessaging.instance.deleteToken();
  //   await FirebaseMessaging.instance.unsubscribeFromTopic('raqame_eamana');
  // }

  bool fingerprint = false;
  bool darkmode = false;

  void getfingerprintSettings() async {
    //final settingSP = await SharedPreferences.getInstance();

    fingerprint = sharedPref.getBool("fingerprint")!;
    darkmode = sharedPref.getBool("darkmode")!;
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
          //brightness: Brightness.dark,
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
        initialRoute: widget.username == null || widget.username == 0
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
                child: HomePanel(),
              ),
          '/loginView': (context) => ChangeNotifierProvider(
                create: (_) => LoginProvider(),
                child: LoginView(),
              ),
          '/home': (context) => HomePanel(),
          '/OTPView': (context) => OTPView(),
          '/HrRequestsView': (context) => HrRequestsView(),
          '/HRdetailsView': (context) => HRdetailsView(),
          '/EditMeetingView': (context) => EditMeetingView(0),
          '/AddMeeting': (context) => AddMeeting(),
          '/EmpInfoView': (context) => EmpInfoView(null),
          '/Empprofile': (context) => EmpProfile(null),
          '/HrDecisionsView': (context) => HrDecisionsView(),
          '/services': (context) => ServicesView(),
          '/EamanaDiscount': (context) => EamanaDiscount(null),
          '/VacationRequest': (context) => VacationRequest(),
          '/entedab': (context) => Entedab(),
          '/OutdutyRequest': (context) => OutdutyRequest(),
          '/Settings': (context) => Settings(null),
          '/AuthenticateBio': (context) => AuthenticateBio(),
          '/auhad': (context) => Auhad(),
          '/auth_secreen': (context) => AuthenticateBioSecreen(),
          '/SalaryHistory': (context) => SalaryHistory(),
          '/comments': (context) => Comments(),
          '/events': (context) => Events(),
          '/Settings2': (context) => Settings2(null), //for test animation
          '/vacation_old_request': (context) => vacation_old_request(),
          '/OutDuties_hostiry': (context) => OutDuties_hostiry(),
          '/Mandates_history': (context) => Mandates_history(),
        },
      );
    });
  }

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
