import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';

import 'package:local_auth/local_auth.dart';

class AuthenticateBio extends StatefulWidget {
  AuthenticateBio({Key? key}) : super(key: key);

  @override
  State<AuthenticateBio> createState() => _AuthenticateBioState();
}

class _AuthenticateBioState extends State<AuthenticateBio> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  //bool? _canCheckBiometrics;
  // List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  AndroidAuthMessages androidAuthStrings =
      const AndroidAuthMessages(signInTitle: "الرجاء التحقق من هويتك");
  IOSAuthMessages iOSAuthStrings = const IOSAuthMessages();

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    _authenticate();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          androidAuthStrings: androidAuthStrings,
          localizedReason: 'تحقق',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
      });
      if (authenticated == true) {
        print("suc 1");
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {}

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "تسجيل الدخول بواسطة البصمة",
            style: titleTx(baseColor),
          ),
          SizedBox(
            height: 20,
          ),
          IconButton(
              iconSize: 100,
              onPressed: _authenticate,
              icon: Icon(
                Icons.fingerprint,
              )),
          SizedBox(
            height: 100,
          ),
          Image(
            //width: responsiveMT(90, 150),
            alignment: Alignment.center,
            width: 150,

            image: AssetImage("assets/image/rakamy-logo-2.png"),
          ),
        ],
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
