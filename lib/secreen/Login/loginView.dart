import 'package:eamanaapp/provider/loginProvider.dart';
import 'package:eamanaapp/secreen/Login/OTPView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _usernameError = false;
  bool passError = false;
  var _provider;
  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text("دخول"),
          ],
        ),
      ),
      body: Stack(
        children: [
          background(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  logo(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("تسجيل الدخول"),
                  const Text("فضلا أدخل معلومات التسجيل"),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 280,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Stack(
                      children: [
                        bagPanel(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            userName(),
                            const SizedBox(
                              height: 10,
                            ),
                            password(),
                            const SizedBox(
                              height: 10,
                            ),
                            loginBtn(_provider),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget userName() {
    return Container(
      margin: const EdgeInsets.only(left: 60, right: 60),
      child: TextField(
        controller: _username,
        keyboardType: TextInputType.text,
        maxLines: 1,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          filled: true,
          fillColor: Colors.white,
          errorText: _usernameError ? "الرجاء إدخال الرقم الوضيفي" : null,
          labelText: "رقم الوضيفي",
          alignLabelWithHint: true,
        ),
        onChanged: (String val) {
          setState(() {
            if (val.isEmpty) {
              _usernameError = true;
            } else {
              _usernameError = false;
            }
          });
        },
      ),
    );
  }

  Widget password() {
    return Container(
      margin: const EdgeInsets.only(left: 60, right: 60),
      child: TextField(
        controller: _password,
        keyboardType: TextInputType.text,
        maxLines: 1,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          filled: true,
          fillColor: Colors.white,
          labelText: "الرقم السري",
          errorText: (passError ? "الرجاء إدخال الرقم السري" : null),
        ),
        onChanged: (String val) {
          setState(() {
            if (val.isEmpty) {
              passError = true;
            } else {
              passError = false;
            }
          });
        },
      ),
    );
  }

  Widget background() {
    return SvgPicture.asset(
      'assets/SVGs/background.svg',
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      fit: BoxFit.fill,
    );
  }

  Widget logo() {
    return SvgPicture.asset(
      'assets/SVGs/brand-logo.svg',
      alignment: Alignment.center,
    );
  }

  Widget bagPanel() {
    return Center(
      child: SvgPicture.asset(
        'assets/SVGs/panel-bg.svg',
        alignment: Alignment.center,
        //   width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        height: 280,
        // fit: BoxFit.,
      ),
    );
  }

  Widget loginBtn(_provider) {
    var provider2 = Provider.of<LoginProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () async {
          bool erore = false;
          erore = checkValditionSubmit();
          if (!erore) {
            EasyLoading.show(
              status: 'loading...',
            );

            bool isValiedUser =
                await _provider.checkUser(_username.text, _password.text);
            EasyLoading.dismiss();
            if (isValiedUser) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                      value: provider2,
                      child: OTPView(),
                    ),
                  ));
            } else {
              Alert(
                context: context,
                type: AlertType.error,
                title: "خطأ",
                desc: "خطأ في كلمة المرور أو إسم المستخدم",
                buttons: [
                  DialogButton(
                    child: const Text(
                      "حسنا",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
              ).show();
            }
          }
        },
        child: const Text('دخول'),
      ),
    );
  }

  bool checkValditionSubmit() {
    bool erore = false;
    if (_password.text.isEmpty) {
      setState(() {
        passError = true;
        erore = true;
      });
    }
    if (_username.text.isEmpty) {
      setState(() {
        _usernameError = true;
        erore = true;
      });
    }
    if (_password.text.isNotEmpty) {
      setState(() {
        passError = false;
      });
    }
    if (_username.text.isNotEmpty) {
      setState(() {
        _usernameError = false;
      });
    }
    return erore;
  }
}
