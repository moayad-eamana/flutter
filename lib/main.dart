import 'dart:io';
import 'package:eamanaapp/auth_secreen.dart';
import 'package:eamanaapp/events.dart';
import 'package:eamanaapp/firebase_options.dart';
import 'package:eamanaapp/provider/login/loginProvider.dart';
import 'package:eamanaapp/provider/otp.dart';
import 'package:eamanaapp/secreen/EamanaDiscount/EamanaDiscount.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/EmpInfo/my_Card.dart';
import 'package:eamanaapp/secreen/EmpInfo/newEmpinfo.dart';
import 'package:eamanaapp/secreen/Home/Drawer&NavigationBar.dart';
import 'package:eamanaapp/secreen/Home/panel&NavigationBar.dart';
import 'package:eamanaapp/secreen/Login/OTPView.dart';
import 'package:eamanaapp/secreen/Login/loginView.dart';
import 'package:eamanaapp/secreen/Meetings/AddMeeting.dart';
import 'package:eamanaapp/secreen/Meetings/EditMeetingView.dart';
import 'package:eamanaapp/secreen/Meetings/contactsView.dart';
import 'package:eamanaapp/secreen/Meetings/mettingsType.dart';
import 'package:eamanaapp/secreen/QrCode/scannQrcode.dart';
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
import 'package:eamanaapp/secreen/customerService/customerServiceActions/customerServiceRequests.dart';
import 'package:eamanaapp/secreen/customerService/reserveForcustomer/reserveForcustomer.dart';
import 'package:eamanaapp/secreen/events/events_page.dart';
import 'package:eamanaapp/secreen/favs/favs.dart';
import 'package:eamanaapp/secreen/mahamme/CooperativeTrainingRequestsInfo.dart';
import 'package:eamanaapp/secreen/mahamme/GetCardRequestInfo.dart';
import 'package:eamanaapp/secreen/mahamme/HRdetailsView.dart';
import 'package:eamanaapp/secreen/mahamme/HrDecisionsView.dart';
import 'package:eamanaapp/secreen/mahamme/HrRequestsView.dart';
import 'package:eamanaapp/secreen/messages/morning.dart';
import 'package:eamanaapp/secreen/salary/salaryHistory.dart';
import 'package:eamanaapp/secreen/Wallet/AndroidWallet.dart';
import 'package:eamanaapp/secreen/services/servicesView.dart';
import 'package:eamanaapp/secreen/RequestsHr/vacation_request.dart';
import 'package:eamanaapp/secreen/splashScreen/splashScreen.dart';
import 'package:eamanaapp/secreen/violation/addViolation/ViolationHome.dart';
import 'package:eamanaapp/settings_utilities/firebase_Notification.dart';
import 'package:eamanaapp/settings_utilities/setSettings.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:root_tester/root_tester.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_performance/firebase_performance.dart';

late AndroidNotificationChannel channel;
int? notificationcont;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
String? localVersion;
bool forceUpdate = false;
bool showImage = false;
final navigatorKey = GlobalKey<NavigatorState>();
dynamic hasePerm = "";
late PackageInfo packageInfo;
late SharedPreferences sharedPref;
final Controller c = Get.put(Controller());

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (message.data["module_name"] == "otp") {
    c.increment(message.data["image"]);
    return;
  }
  if (message.data["module_name"] == "GeneralMessages") {
    navigatorKey.currentState?.pushNamed("/morning",
        arguments: ({
          "title": message.notification?.title,
          "body": message.notification?.body,
          "url": message.data,
        }));
    return;
  }
  if (message.data["module_name"] == "Offers") {
    navigatorKey.currentState?.pushNamed("/EamanaDiscount");
    return;
  }
  if (message.data["module_name"] == "update") {
    if (Platform.isAndroid) {
      launch(
          "https://play.google.com/store/apps/details?id=com.eamana.eamanaapp.gov.sa");
    } else {
      launch(
          "https://apps.apple.com/us/app/%D8%B1%D9%82%D9%85%D9%8A/id1613668254");
    }
  }
  if (notification != null && android != null) {
    print(message.data);
    print("object");
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
  sharedPref.setBool("darkmode", false);
  packageInfo = await PackageInfo.fromPlatform();
  try {
    // FirebaseApp app = await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    await firebase_Notification();
  } catch (e) {
    print(e);
  }
  FirebasePerformance performance = FirebasePerformance.instance;
  hasePerm = sharedPref.getString("hasePerm");
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //Settings.getSettings();
  setSettings();
  getColorSettings();
  // DeterminePosition.determinePosition();
  tz.initializeTimeZones();
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();

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
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

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
    showImage = remoteConfig.getBool("showImage");
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
        options: AuthenticationOptions(useErrorDialogs: true, stickyAuth: true),
        localizedReason: 'Let OS determine authentication method',
      );

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
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

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

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        // navigatorObservers: <NavigatorObserver>[observer],
        navigatorKey: navigatorKey,
        builder: EasyLoading.init(builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        }),
        debugShowCheckedModeBanner: false,
        title: 'رقمي',
        theme: ThemeData(
          //dark mode
          //brightness: Brightness.dark,

          primarySwatch: Colors.blue,
          fontFamily: 'TheSansArabic',
          tabBarTheme: TabBarTheme(
              labelColor: Colors.black,
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "TheSansArabic2"), // color for text
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

        initialRoute: '/splashScreen',

        // initialRoute: widget.username == null || widget.username == 0
        //     ? "/"
        //     : fingerprint == false
        //         ? '/home'
        //         : '/AuthenticateBio',
        routes: {
          '/': (context) => ChangeNotifierProvider(
                create: (_) => LoginProvider(),
                child: LoginView(
                    // analytics: analytics,
                    // observer: observer,
                    ),
              ),
          '/TabBarDemo': (context) => ChangeNotifierProvider(
                create: (_) => LoginProvider(),
                child: HomePanel(),
              ),
          '/loginView': (context) => ChangeNotifierProvider(
                create: (_) => LoginProvider(),
                child: LoginView(
                    // analytics: analytics,
                    // observer: observer,
                    ),
              ),
          '/home': (context) => Home(),
          '/OTPView': (context) => OTPView(),
          '/HrRequestsView': (context) => HrRequestsView(),
          '/HRdetailsView': (context) => HRdetailsView(),
          '/EditMeetingView': (context) => EditMeetingView(0),
          '/AddMeeting': (context) => AddMeeting(),
          '/EmpInfoView': (context) => EmpInfoView(null),
          '/Empprofile': (context) => EmpProfile(null),
          '/HrDecisionsView': (context) => HrDecisionsView(),
          '/services': (context) => ServicesView(),
          '/EamanaDiscount': (context) => EamanaDiscount(null, null),
          '/VacationRequest': (context) => VacationRequest(),
          '/entedab': (context) => Entedab(),
          '/OutdutyRequest': (context) => OutdutyRequest(),
          '/Settings': (context) => Settings(null),
          '/AuthenticateBio': (context) => AuthenticateBio(),
          '/auhad': (context) => Auhad(null),
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
          '/AndroidWallet': (context) => AndroidWallet(),
          '/GetCardRequestInfo': (context) => GetCardRequestInfo(),
          '/CooperativeTrainingRequestsInfo': (context) =>
              CooperativeTrainingRequestsInfo(),
          '/contactsView': (context) => ContactsView(),
          '/scannQrcode': (context) => scanQrcode(),
          '/ViolationHome': (context) => ViolationHome(),
          '/customerServiceRequests': (context) => customerServiceRrequests(""),
          '/reserveForcustomer': (context) => reserveForcustomer(),
          '/meettingsType': (context) => meettingsType(),
          '/newEmpInfo': (context) => newEmpInfo(true),
          '/splashScreen': (context) => splashScreen(),
          '/events_page': (context) => EventsPage(),
          '/MyCard': (context) => MyCard(),
        },
      );
    });
  }

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
