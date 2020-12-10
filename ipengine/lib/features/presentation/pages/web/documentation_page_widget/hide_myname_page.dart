

import 'package:flutter/material.dart';
import 'package:ipengine/features/domain/entity/hide_myname_entity.dart';
import 'package:ipengine/features/presentation/pages/web/widgets/common.dart';

class HideMyNamePage extends StatefulWidget {
  @override
  _HideMyNamePageState createState() => _HideMyNamePageState();
}

class _HideMyNamePageState extends State<HideMyNamePage> {

  final _data=HideMyNameEntity.hideMyName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40,vertical: 30),
          child: Column(
            children: [
              _headerWidget(),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 30),
                height: 45,
                decoration: BoxDecoration(color: Colors.black.withOpacity(.1)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Ip address",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Port",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Country,City",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Speed",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Type",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Anonymity",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Latest update",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                itemCount: _data.length,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black.withOpacity(.2),width: 1),
                        right: BorderSide(color: Colors.black.withOpacity(.2),width: 1),
                        bottom: BorderSide(color: Colors.black.withOpacity(.2),width: 1),
                      )
                    ),
                    height: 45,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            _data[index].ip,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _data[index].port,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _data[index].countryCity,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _data[index].speed,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _data[index].type,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _data[index].anonymity,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _data[index].latestUpdate,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "IPengine.dev",
          style: textStyle24,
        ),
        Row(
          children: [
            _itemWidget(text: "What is VPN?"),
            SizedBox(width: 14,),
            _itemWidget(text: "Pricing"),
            SizedBox(width: 14,),
            _itemWidget(text: "Help"),
            SizedBox(width: 14,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Buy access'),
            )
          ],
        ),
      ],
    );
  }

  Widget _itemWidget({String text}) {
    return Container(
      child: Text(text,style: TextStyle(fontSize: 16),),
    );
  }
}
