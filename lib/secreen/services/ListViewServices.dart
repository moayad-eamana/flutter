import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:flutter/material.dart';

class ListViewServices extends StatefulWidget {
  List SubServices;
  String title;
  ListViewServices(this.SubServices, this.title);

  @override
  State<ListViewServices> createState() => _ListViewServicesState();
}

class _ListViewServicesState extends State<ListViewServices> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBarW.appBarW(widget.title, context, null),
          body: Container(
            margin: EdgeInsets.only(top: 10),
            child: ListView.builder(
                itemCount: widget.SubServices.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(7)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff0E1F35).withOpacity(0.06),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: widget.SubServices[index]["Action"],
                      child: ListTile(
                        trailing: Icon(Icons.arrow_forward_ios),
                        title: Text(
                          widget.SubServices[index]["service_name"],
                          style: fontsStyle.px16(
                              fontsStyle.SecondaryColor(), FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ));
  }
}
