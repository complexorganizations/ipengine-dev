import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ipengine/features/domain/entity/ai_machine_learing_entity.dart';
import 'package:ipengine/features/domain/entity/ai_machine_learing_entity.dart';
import 'package:ipengine/features/domain/entity/ai_machine_learing_entity.dart';
import 'package:ipengine/features/domain/entity/security_tirils_entity.dart';
import 'package:ipengine/features/presentation/pages/web/widgets/common.dart';

class AiMachineLearningPage extends StatefulWidget {
  @override
  _AiMachineLearningPageState createState() => _AiMachineLearningPageState();
}

class _AiMachineLearningPageState extends State<AiMachineLearningPage> {
  int _selectedMenuItem = -1;
  final _listData = SecurityTrailsEntity.securityTrailsList;
  final _buildingBlocksData = AiMachineLearningEntity.buildingBlocksData;
  final _infrastructureData = AiMachineLearningEntity.infrastructureData;
  final _platformData = AiMachineLearningEntity.platformData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerWidget(),
            _bodyWidget(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 35),
      child: Text(
        "AI and Machine Learning",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
      ),
    );
  }

  Widget _bodyWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: _menuWidget()),
          Expanded(flex: 4, child: _listDataWidget()),
        ],
      ),
    );
  }

  Widget _menuWidget() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          _menuItemHeaderWidget(
              color: Colors.black.withOpacity(.1),
              text: "Google Cloud Product"),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 0;
              });
            },
            child: _menuItemWidget(
              color: Colors.black.withOpacity(.1),
              text: "Overview",
              selectedTextColor: _selectedMenuItem == 0
                  ? Colors.black.withOpacity(.9)
                  : Colors.black.withOpacity(.7),
              selectItemColor: _selectedMenuItem == 0
                  ? Colors.black.withOpacity(.8)
                  : Colors.black.withOpacity(.1),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 1;
              });
            },
            child: _menuItemWidget(
              color: Colors.black,
              text: "Featured products",
              selectedTextColor: _selectedMenuItem == 1
                  ? Colors.black.withOpacity(.9)
                  : Colors.black.withOpacity(.7),
              selectItemColor: _selectedMenuItem == 1
                  ? Colors.black.withOpacity(.8)
                  : Colors.black.withOpacity(.1),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 2;
              });
            },
            child: _menuItemWidget(
              color: Colors.black.withOpacity(.1),
              text: "AI and Machine Learning",
              selectedTextColor: _selectedMenuItem == 2
                  ? Colors.black.withOpacity(.9)
                  : Colors.black.withOpacity(.7),
              selectItemColor: _selectedMenuItem == 2
                  ? Colors.black.withOpacity(.8)
                  : Colors.black.withOpacity(.1),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 3;
              });
            },
            child: _menuItemWidget(
                color: Colors.lightBlueAccent,
                text: "API Management",
                selectedTextColor: _selectedMenuItem == 3
                    ? Colors.black.withOpacity(.9)
                    : Colors.black.withOpacity(.7),
                selectItemColor: _selectedMenuItem == 3
                    ? Colors.black.withOpacity(.8)
                    : Colors.black.withOpacity(.1)),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 4;
              });
            },
            child: _menuItemWidget(
                color: Colors.lightBlueAccent,
                text: "Compute",
                selectedTextColor: _selectedMenuItem == 4
                    ? Colors.black.withOpacity(.9)
                    : Colors.black.withOpacity(.7),
                selectItemColor: _selectedMenuItem == 4
                    ? Colors.black.withOpacity(.8)
                    : Colors.black.withOpacity(.1)),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 5;
              });
            },
            child: _menuItemWidget(
                color: Colors.lightBlueAccent,
                text: "Containers",
                selectedTextColor: _selectedMenuItem == 5
                    ? Colors.black.withOpacity(.9)
                    : Colors.black.withOpacity(.7),
                selectItemColor: _selectedMenuItem == 5
                    ? Colors.black.withOpacity(.8)
                    : Colors.black.withOpacity(.1)),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 6;
              });
            },
            child: _menuItemWidget(
                color: Colors.lightBlueAccent,
                text: "Data Analytics",
                selectedTextColor: _selectedMenuItem == 6
                    ? Colors.black.withOpacity(.9)
                    : Colors.black.withOpacity(.7),
                selectItemColor: _selectedMenuItem == 6
                    ? Colors.black.withOpacity(.8)
                    : Colors.black.withOpacity(.1)),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 7;
              });
            },
            child: _menuItemWidget(
                color: Colors.lightBlueAccent,
                text: "Database",
                selectedTextColor: _selectedMenuItem == 7
                    ? Colors.black.withOpacity(.9)
                    : Colors.black.withOpacity(.7),
                selectItemColor: _selectedMenuItem == 7
                    ? Colors.black.withOpacity(.8)
                    : Colors.black.withOpacity(.1)),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 8;
              });
            },
            child: _menuItemWidget(
                color: Colors.lightBlueAccent,
                text: "Developer Tools",
                selectedTextColor: _selectedMenuItem == 8
                    ? Colors.black.withOpacity(.9)
                    : Colors.black.withOpacity(.7),
                selectItemColor: _selectedMenuItem == 8
                    ? Colors.black.withOpacity(.8)
                    : Colors.black.withOpacity(.1)),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 9;
              });
            },
            child: _menuItemWidget(
                color: Colors.lightBlueAccent,
                text: "Healthcare and Life Science",
                selectedTextColor: _selectedMenuItem == 9
                    ? Colors.black.withOpacity(.9)
                    : Colors.black.withOpacity(.7),
                selectItemColor: _selectedMenuItem == 9
                    ? Colors.black.withOpacity(.8)
                    : Colors.black.withOpacity(.1)),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 10;
              });
            },
            child: _menuItemWidget(
                color: Colors.lightBlueAccent,
                text: "Hybrid and Multi-cloud",
                selectedTextColor: _selectedMenuItem == 10
                    ? Colors.black.withOpacity(.9)
                    : Colors.black.withOpacity(.7),
                selectItemColor: _selectedMenuItem == 10
                    ? Colors.black.withOpacity(.8)
                    : Colors.black.withOpacity(.1)),
          ),
        ],
      ),
    );
  }

  Widget _listDataWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "AI Building Blocks",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GridView.builder(
            itemCount: _buildingBlocksData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 2.4),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _buildingBlocksData[index].title,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _buildingBlocksData[index].description,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      )
                    ],
                  ));
            },
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "AI Infrastructure",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GridView.builder(
            itemCount: _infrastructureData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 2.4),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _infrastructureData[index].title,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _infrastructureData[index].description,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      )
                    ],
                  ));
            },
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "AI Platform and Accelerators",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GridView.builder(
            itemCount: _platformData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 2.4),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Colors.black, width: 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _platformData[index].title,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _platformData[index].description,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _menuItemWidget(
      {Color color,
      String text,
      Color selectItemColor,
      Color selectedTextColor}) {
    return Container(
      height: 55,
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(width: 2, color: selectItemColor)),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: selectedTextColor),
      ),
    );
  }

  Widget _menuItemHeaderWidget({Color color, String text}) {
    return Container(
      height: 55,
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
