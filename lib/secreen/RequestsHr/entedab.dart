import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Entedab extends StatefulWidget {
  const Entedab({Key? key}) : super(key: key);

  @override
  _EntedabState createState() => _EntedabState();
}

class _EntedabState extends State<Entedab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarW.appBarW("طلب إنتداب", context),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                child: StaggeredGrid.count(
                    crossAxisCount: responsiveGrid(1, 2),
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                            labelText: 'Enter something',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blue),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 3, color: Colors.red),
                              borderRadius: BorderRadius.circular(4),
                            )),
                        onChanged: (String val) {},
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2021, 3, 5), onChanged: (date) {
                            print('change $date');
                          },
                              onConfirm: (date) {},
                              currentTime: DateTime.now(),
                              locale: LocaleType.ar);
                        },
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
