import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class SupportMessages extends StatefulWidget {
  List list;

  SupportMessages(this.list);

  @override
  State<SupportMessages> createState() => _SupportMessagesState();
}

class _SupportMessagesState extends State<SupportMessages> {
  @override
  void initState() {
    // TODO: implement initState
    print("object");
    print(widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print(widget.list[index]);
                Alerts.confirmAlrt(
                        context,
                        "هل أانت متأكد",
                        "هل أانت متأكد من إرسال الرسالة\n" + widget.list[index],
                        'نعم')
                    .show();
              },
              child: Container(
                decoration: containerdecoration(BackGWhiteColor),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                width: 60.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.list[index],
                        style: subtitleTx(baseColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.send,
                        color: baseColor,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
