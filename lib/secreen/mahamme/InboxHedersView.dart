import 'package:eamanaapp/provider/mahamme/HrDecisionsProvider.dart';
import 'package:eamanaapp/provider/mahamme/LoansRequestsProvider.dart';
import 'package:eamanaapp/provider/mahamme/MobasharaProvider.dart';
import 'package:eamanaapp/provider/mahamme/PurchaseRequestsProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/secreen/mahamme/Mobashara.dart';
import 'package:eamanaapp/secreen/mahamme/PurchaseRequests.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

import 'HrDecisionsView.dart';
import 'HrRequestsView.dart';
import 'LoansRequestsView.dart';

class InboxHedersView extends StatefulWidget {
  const InboxHedersView({Key? key}) : super(key: key);

  @override
  _InboxHedersViewState createState() => _InboxHedersViewState();
}

class _InboxHedersViewState extends State<InboxHedersView> {
  bool isLoaded = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      EasyLoading.show(
        status: 'جاري المعالجة...',
        maskType: EasyLoadingMaskType.black,
      );
      await Provider.of<EatemadatProvider>(context, listen: false)
          .getInboxHeader();
      EasyLoading.dismiss();
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _provider =
        Provider.of<EatemadatProvider>(context).inboxHeaderList.toList();
    double width = MediaQuery.of(context).size.width;
    var _provider2 = Provider.of<EatemadatProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إعتماداتي", context, null),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            AnimationLimiter(
              child: _provider.length == 0
                  ? Container(
                      child: Center(
                        child: Text("لايوجد إعتمادات"),
                      ),
                    )
                  : AnimationLimiter(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: (SizerUtil.deviceType ==
                                            DeviceType.tablet
                                        ? 4
                                        : 3),
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    mainAxisExtent: 120),
                            itemCount: _provider.length,
                            itemBuilder: (BuildContext context, index) {
                              return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: FlipAnimation(
                                    curve: Curves.linear,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ListWidgit(_provider[index]),
                                    ),
                                  ));
                            }),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ListWidgit(var _provider) {
    var _provider2 = Provider.of<EatemadatProvider>(context);
    if (_provider.TypeID == 1) {
      return caerdContent(
        "شؤون الموظفين",
        "assets/SVGs/dalelalmowzafen.svg",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                  value: _provider2, child: HrRequestsView()),
            ),
          );
        },
      );
    } else if (_provider.TypeID == 38) {
      return caerdContent(
        "القرارات الالكترونية",
        "assets/SVGs/dalelalmowzafen.svg",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => HrDecisionsProvider(),
                  child: HrDecisionsView()),
            ),
          );
        },
      );
    } else if (_provider.TypeID == 39 || _provider.TypeID == 40) {
      return caerdContent(
        "مباشرة عمل",
        "assets/SVGs/dalelalmowzafen.svg",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => MobasharaProvider(),
                  child: Mobashara(_provider.TypeID)),
            ),
          );
        },
      );
    } else if (_provider.TypeID == 6 || _provider.TypeID == 4) {
      return caerdContent(
        "إعتماد مشتريــات",
        "assets/SVGs/dalelalmowzafen.svg",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => PurchaseRequestsProvider(),
                  child: PurchaseRequests(_provider.TypeID)),
            ),
          );
        },
      );
    } // else if (_provider.TypeID == 120) {
    //   return caerdContent(
    //     "إعتماد إعارة",
    //     "assets/SVGs/dalelalmowzafen.svg",
    //     () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => ChangeNotifierProvider(
    //               create: (_) => LoansRequestsProvider(),
    //               child: LoansRequestsView()),
    //         ),
    //       );
    //     },
    //   );    // }
    else {
      return Container();
    }
  }

  Widget caerdContent(String Title, String iconPath, VoidCallback function) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: widgetsUni.servicebutton2(
          Title,
          iconPath, //later
          function,
        ));
  }
}
