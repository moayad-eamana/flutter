import 'package:eamanaapp/provider/mahamme/HrDecisionsProvider.dart';
import 'package:eamanaapp/provider/mahamme/LoansRequestsProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
  Widget build(BuildContext context) {
    var _provider = Provider.of<EatemadatProvider>(context)
        .inboxHeaderList
        .where((element) => (element.TypeID == 1 ||
            element.TypeID == 38 ||
            element.TypeID == 120))
        .toList();
    double width = MediaQuery.of(context).size.width;
    var _provider2 = Provider.of<EatemadatProvider>(context);
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/SVGs/background.svg',
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
        AnimationLimiter(
          child: _provider.length == 0
              ? Container()
              : AnimationLimiter(
                  child: Center(
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (SizerUtil.deviceType == DeviceType.tablet
                                    ? 3
                                    : 1),
                            mainAxisSpacing: 10,
                            mainAxisExtent: 300),
                        itemCount: _provider.length,
                        itemBuilder: (BuildContext context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: FlipAnimation(
                              curve: Curves.linear,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: _provider[index].TypeID == 1
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChangeNotifierProvider.value(
                                                        value: _provider2,
                                                        child:
                                                            HrRequestsView()),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            child: Image.asset(
                                                "assets/SVGs/etemadat.jpg"),
                                          ),
                                        )
                                      : (_provider[index].TypeID == 38
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChangeNotifierProvider(
                                                            create: (_) =>
                                                                HrDecisionsProvider(),
                                                            child:
                                                                HrDecisionsView()),
                                                  ),
                                                );
                                              },
                                              child: Image.asset(
                                                  "assets/SVGs/decisions.jpg"),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChangeNotifierProvider(
                                                            create: (_) =>
                                                                LoansRequestsProvider(),
                                                            child:
                                                                LoansRequestsView()),
                                                  ),
                                                );
                                              },
                                              child: Image.asset(
                                                  "assets/SVGs/asset4-100.jpg"),
                                            )),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
        ),
      ],
    );
  }
}
