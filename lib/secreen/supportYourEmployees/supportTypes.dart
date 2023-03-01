import 'package:eamanaapp/secreen/supportYourEmployees/supportYourEmployees.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/listOfSupportTypes.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class supportTypes extends StatefulWidget {
  Function nextPage;
  Function backPage;
  Function listOfmessagesfn;
  List listOfmessages;
  supportTypes(
      this.nextPage, this.backPage, this.listOfmessages, this.listOfmessagesfn);

  @override
  State<supportTypes> createState() => _supportTypesState();
}

class _supportTypesState extends State<supportTypes> {
  double hi = SizerUtil.deviceType == DeviceType.mobile ? 170 : 140;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: StaggeredGrid.count(
              crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 2 : 4,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              children: [
                ...listOfSupportTypes.list(context).map((e) {
                  return StaggeredGridTileW(
                      1,
                      hi,
                      widgetsUni.servicebutton2(e["service_name"], e["icon"],
                          () {
                        // e["messages"];
                        widget.listOfmessages = e["messages"];
                        //setState(() {});
                        widget.listOfmessagesfn(e["messages"]);
                        widget.nextPage();
                      }));
                }),
              ],
            ),
          ),
        ),
        // Container(
        //     padding: const EdgeInsets.all(8),
        //     height: 48,
        //     child: Row(
        //       children: <Widget>[
        //         Expanded(
        //           child: Align(
        //               alignment: Alignment.centerLeft,
        //               child: ElevatedButton(
        //                 style: ElevatedButton.styleFrom(primary: secondryColor),
        //                 child: Icon(Icons.arrow_forward_ios),
        //                 onPressed: widget.listOfmessages.length > 0
        //                     ? () {
        //                         widget.nextPage();
        //                       }
        //                     : null,
        //               )),
        //         ),
        //       ],
        //     ))
      ],
    );
  }
}
