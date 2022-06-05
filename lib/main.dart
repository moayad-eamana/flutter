import 'dart:io';
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
import 'package:eamanaapp/main_utilities/firebase_Notification.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/main_utilities/setSettings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:package_info_plus/package_info_plus.dart';

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

String? localVersion;
bool forceUpdate = false;
final navigatorKey = GlobalKey<NavigatorState>();
dynamic hasePerm = "";
late PackageInfo packageInfo;
late SharedPreferences sharedPref;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    print(message.data);
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          playSound: true,
          color: Colors.blue,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: baseColor,
  ));

  //new aksjdhlkajswhdlkajshdwliuagdLIUYSDWGQ
  WidgetsFlutterBinding.ensureInitialized();

  packageInfo = await PackageInfo.fromPlatform();
  firebase_Notification();
  sharedPref = await SharedPreferences.getInstance();
  hasePerm = sharedPref.getString("hasePerm");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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

class MyApp extends StatefulWidget {
  double? username;
  MyApp(this.username);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    getVersionFromServer();
    getfingerprintSettings();
    //  Alerts.update(context, "", "يوجد تحديث جديد").show();
    if (widget.username != null && widget.username != 0) {
      DateTime time = DateTime.parse(sharedPref.getString("tokenTime") ?? "");

      print(DateTime.now());
      if (time.compareTo(DateTime.now()) == 0 ||
          time.compareTo(DateTime.now()) < 0) {
        // unsubscribeFromNotofication();
        widget.username = null;
      }
    }
    listenToFirbaseNotification();
    getToken();
  }

  getVersionFromServer() async {
    await Firebase.initializeApp();
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));

    await remoteConfig.fetchAndActivate();
    localVersion = Platform.isAndroid
        ? remoteConfig.getString("ServerVersionAndroid")
        : remoteConfig.getString("ServerVersionIOS");

    forceUpdate = remoteConfig.getBool("forceUpdate");
    setState(() {});
    print(localVersion.toString() + " _ios");
    print(forceUpdate);
  }

  getToken() async {
    String? token = await messaging.getToken();
    print(token);
  }

  unsubscribeFromNotofication() async {
    await FirebaseMessaging.instance.deleteToken();
    await FirebaseMessaging.instance.unsubscribeFromTopic('raqameUpdate');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      print('state = $state');

      packageInfo = await PackageInfo.fromPlatform();
      setState(() {});
      await Firebase.initializeApp();
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));

      await remoteConfig.fetchAndActivate();
      localVersion = Platform.isAndroid
          ? remoteConfig.getString("ServerVersionAndroid")
          : remoteConfig.getString("ServerVersionIOS");

      forceUpdate = remoteConfig.getBool("forceUpdate");
      setState(() {});
      print(localVersion.toString() + " _ios");
      print(forceUpdate);
      setState(() {});
    }
  }

  bool fingerprint = false;
  void getfingerprintSettings() async {
    fingerprint = sharedPref.getBool("fingerprint") ?? false;
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
