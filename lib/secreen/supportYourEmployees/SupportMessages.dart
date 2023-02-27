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
    return ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(widget.list[index]);
            },
            child: Container(
              decoration: containerdecoration(Colors.white),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(6),
              width: 60.w,
              child: Row(
                children: [
                  Text(
                    widget.list[index],
                    style: subtitleTx(baseColor),
                  ),
                  Spacer(),
                  Icon(
                    Icons.send,
                    color: baseColor,
                  )
                ],
              ),
            ),
          );
        });
  }
}
