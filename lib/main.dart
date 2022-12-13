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
import 'package:eamanaapp/secreen/Meetings/contactsView.dart';
import 'package:eamanaapp/secreen/Meetings/mettingsType.dart';
import 'package:eamanaapp/secreen/QrCode/scannQrcode.dart';
import 'package:eamanaapp/secreen/RequestsHr/auhad.dart';
import 'package:eamanaapp/secreen/RequestsHr/auhad2.dart';
import 'package:eamanaapp/secreen/RequestsHr/entedab.dart';
import 'package:eamanaapp/secreen/RequestsHr/outduty_request.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/Mandates_history.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/OutDuties_history.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/vacation_history_request.dart';
import 'package:eamanaapp/secreen/Settings/settings%20copy.dart';
import 'package:eamanaapp/secreen/Settings/settings.dart';
import 'package:eamanaapp/secreen/auth.dart';
import 'package:eamanaapp/secreen/community/comments.dart';
import 'package:eamanaapp/secreen/customerService/customerServiceActions/customerServiceRequests.dart';
import 'package:eamanaapp/secreen/customerService/reserveForcustomer/reserveForcustomer.dart';
import 'package:eamanaapp/secreen/favs/favs.dart';
import 'package:eamanaapp/secreen/mahamme/CooperativeTrainingRequestsInfo.dart';
import 'package:eamanaapp/secreen/mahamme/GetCardRequestInfo.dart';
import 'package:eamanaapp/secreen/mahamme/HRdetailsView.dart';
import 'package:eamanaapp/secreen/mahamme/HrDecisionsView.dart';
import 'package:eamanaapp/secreen/mahamme/HrRequestsView.dart';
import 'package:eamanaapp/secreen/messages/morning.dart';
import 'package:eamanaapp/secreen/salary/salaryHistory.dart';
import 'package:eamanaapp/secreen/services/servicesView.dart';
import 'package:eamanaapp/secreen/RequestsHr/vacation_request.dart';
import 'package:eamanaapp/secreen/violation/addViolation/ViolationHome.dart';
import 'package:eamanaapp/settings_utilities/firebase_Notification.dart';
import 'package:eamanaapp/settings_utilities/setSettings.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:root_tester/root_tester.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timezone/data/latest.dart' as tz;

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
  //new aksjdhlkajswhdlkajshdwliuagdLIUYSDWGQ
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.removeAfter(await Future.delayed(Duration(seconds: 4)));
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // FlutterNativeSplash.removeAfter(
  //     await Future.delayed(const Duration(seconds: 0)));
  print("dddd");
  sharedPref = await SharedPreferences.getInstance();

  packageInfo = await PackageInfo.fromPlatform();
  await firebase_Notification();

  hasePerm = sharedPref.getString("hasePerm");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //Settings.getSettings();
  setSettings();
  getColorSettings();

  tz.initializeTimeZones();

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: baseColor,
  // ));
  //getfingerprintSettings();
  double? username;
  try {
    username = sharedPref.getDouble("EmployeeNumber");
  } catch (e) {}
  late bool isRooted;
  if (Platform.isAndroid) {
    isRooted = await RootTester.isDeviceRooted;
  } else {
    isRooted = false;
  }

  if (!isRooted) {
    runApp(
      MyApp(username),
    );
  }

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
        ? remoteConfig.getString("ServerVersionAndroidAll")
        : remoteConfig.getString("ServerVersionIOSAll");
    forceUpdate = remoteConfig.getBool("forceUpdateAll");
    setState(() {});
    print(localVersion.toString() + " _ios");
    print(packageInfo.version);
    print(forceUpdate);
  }

  getToken() async {
    String? token = await messaging.getToken();
    print(token);
  }

  final LocalAuthentication auth = LocalAuthentication();
  bool? _authenticated;
  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _authenticated = authenticated;
      });
    } on PlatformException catch (e) {
      setState(() {
        _authenticated = authenticated;
      });
      print(e);
      return;
    }
    if (!mounted) {
      return;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      print('state = $state');
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        permissionStatusFuture = "granted";
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        permissionStatusFuture = "granted";
      } else {
        permissionStatusFuture = "denied";
      }
      setState(() {});
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
          ? remoteConfig.getString("ServerVersionAndroidAll")
          : remoteConfig.getString("ServerVersionIOSAll");

      forceUpdate = remoteConfig.getBool("forceUpdateAll");
      setState(() {});
      print(localVersion.toString() + " _ios");
      print(forceUpdate);
      setState(() {});
      // option  for request authentication all time
      // fingerprint = sharedPref.getBool("fingerprint") ?? false;
      // if (fingerprint == true) {
      //   do {
      //     await _authenticate();
      //   } while (_authenticated == false);
      // }
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
      return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
          Locale('ar', ''),
        ],
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
          '/auhad2': (context) => Auhad2(),

          '/auth_secreen': (context) => AuthenticateBioSecreen(),
          '/SalaryHistory': (context) => SalaryHistory(),
          '/comments': (context) => Comments(),
          '/events': (context) => Events(),
          '/Settings2': (context) => Settings2(null), //for test animation
          '/vacation_old_request': (context) => vacation_old_request(),
          '/OutDuties_hostiry': (context) => OutDuties_hostiry(),
          '/Mandates_history': (context) => Mandates_history(),
          '/morning': (context) => morning(),
          '/favs': (context) => favoriot(),
          '/GetCardRequestInfo': (context) => GetCardRequestInfo(),
          '/CooperativeTrainingRequestsInfo': (context) =>
              CooperativeTrainingRequestsInfo(),
          '/contactsView': (context) => ContactsView(),
          '/scannQrcode': (context) => scanQrcode(),
          '/ViolationHome': (context) => ViolationHome(),
          '/customerServiceRequests': (context) => customerServiceRrequests(""),
          '/reserveForcustomer': (context) => reserveForcustomer(),
          '/meettingsType': (context) => meettingsType(),
        },
      );
    });
  }

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
