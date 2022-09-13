 //device_apps: ^2.2.0
  
 widgetsUni.actionbutton("إضافة إلى المحفضة",
                                  Icons.account_balance_wallet, () async {
                                // "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_Pkpass2.php?fname=${_provider[0].FirstName}&lname=${_provider[0].LastName}&fullname=${_provider[0].EmployeeName}&id=${_provider[0].EmployeeNumber.toString().split(".")[0]}&mobile=${_provider[0].MobileNumber}&email=${_provider[0].Email}@eamana.gov.sa&jobtitle=${_provider[0].Title}";
                                var path =
                                    "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_Pkpass2.php?email=${_provider[0].Email}&token=${sharedPref.getString("AccessToken")}";

                                EasyLoading.show(
                                  status: '... جاري المعالجة',
                                  maskType: EasyLoadingMaskType.black,
                                );

                                Response response;
                                Dio dio = new Dio();

                                final appStorage =
                                    await getApplicationDocumentsDirectory();
                                var file =
                                    File('${appStorage.path}/wallet.pkpass');
                                final raf = file.openSync(mode: FileMode.write);

                                response = await dio.post(
                                  path,
                                  options: Options(
                                      responseType: ResponseType.bytes,
                                      followRedirects: false,
                                      receiveTimeout: 0),
                                );
                                if (response.data != null) {
                                  try {
                                    raf.writeFromSync(response.data);
                                    await raf.close();
                                    // print("path = " + file.path);
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  print("Data error");
                                }

                                if (Platform.isAndroid) {
                                  bool isPassWalletInstalled =
                                      await DeviceApps.isAppInstalled(
                                          'com.attidomobile.passwallet');

                                  bool isWalletPassesInstalled =
                                      await DeviceApps.isAppInstalled(
                                          'io.walletpasses.android');

                                  if (isPassWalletInstalled == true ||
                                      isWalletPassesInstalled == true) {
                                    OpenFile.open(file.path,
                                        type: 'application/x-zip-compressed',
                                        uti: 'com.pkware.zip-archive');
                                  } else {
                                    Alerts.warningAlert(context, "تبيه",
                                            "تحتاج تطبيقات أخرى لفتح الملف")
                                        .show()
                                        .then((value) => launch(
                                            "https://play.google.com/store/search?q=Pass%20Wallet&c=apps&hl=en&gl=US"));
                                  }
                                } else {
                                  //for iOS
                                  // try {
                                  //   if (Platform.isIOS) {
                                  //     if (!await launchUrl(Uri.parse(path))) {
                                  //       throw 'Could not launch $path';
                                  //     }
                                  //   } else {
                                  //     if (!await launchUrl(Uri.parse(path),
                                  //         mode: LaunchMode.externalApplication)) {
                                  //       throw 'Could not launch $path';
                                  //     }
                                  //   }
                                  // } catch (e) {
                                  //   return;
                                  // }

                                  /////////////

                                  // PassFile passFile = await Pass()
                                  //     .fetchPreviewFromUrl(
                                  //         url: response.data);
                                  // passFile.save();
                                }
                                EasyLoading.dismiss();
                              }),