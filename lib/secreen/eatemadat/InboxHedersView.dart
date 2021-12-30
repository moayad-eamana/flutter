import 'package:eamanaapp/provider/HrDecisionsProvider.dart';
import 'package:eamanaapp/provider/eatemadatProvider.dart';
import 'package:eamanaapp/secreen/eatemadat/HrDecisionsView.dart';
import 'package:eamanaapp/secreen/eatemadat/HrRequestsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
        status: 'loading...',
      );
      await Provider.of<EatemadatProvider>(context, listen: false)
          .getInboxHeader();
      EasyLoading.dismiss();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<EatemadatProvider>(context);

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
          child: _provider.inboxHeaderList.length == 0
              ? Container()
              : AnimationLimiter(
                  child: ListView.builder(
                      itemCount: _provider.inboxHeaderList.length,
                      itemBuilder: (BuildContext context, index) {
                        return _provider.inboxHeaderList[index].TypeID == 1 ||
                                _provider.inboxHeaderList[index].TypeID == 38
                            ? AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: FlipAnimation(
                                  curve: Curves.linear,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child:
                                          _provider.inboxHeaderList[index]
                                                      .TypeID ==
                                                  1
                                              ? Material(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChangeNotifierProvider.value(
                                                                  value:
                                                                      _provider,
                                                                  child:
                                                                      HrRequestsView()),
                                                        ),
                                                      );
                                                    },
                                                    child: ClipRRect(
                                                      child: Image.asset(
                                                          "assets/SVGs/etemadat.jpg"),
                                                    ),
                                                  ),
                                                )
                                              : Material(
                                                  child: InkWell(
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
                                                  ),
                                                ),
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      }),
                ),
        ),
      ],
    );
  }
}
