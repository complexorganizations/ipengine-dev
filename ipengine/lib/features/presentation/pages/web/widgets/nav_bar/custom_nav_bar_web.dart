import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ipengine/features/presentation/pages/web/widgets/common.dart';

typedef OnPageIndexCallBack=Function(int index);
class CustomNavBarWeb extends StatefulWidget {
  final OnPageIndexCallBack onPageIndexCallBack;
  const CustomNavBarWeb({this.onPageIndexCallBack});
  @override
  _CustomNavBarWebState createState() => _CustomNavBarWebState();
}

class _CustomNavBarWebState extends State<CustomNavBarWeb> {
  int _selectedText = 0;
  String _selectedIndicatorImg = "assets/select_indicator.png";
  final _selectedHoverUnderLine = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "IPengine.dev",
                style: textStyle24,
              ),
              Text(
                "Innovative Source for IP Address Data",
                style: textStyle12,
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onHover: (value) {
                            setState(() {
                              _selectedHoverUnderLine[0] = value;
                            });
                          },
                          onTap: () {
                            setState(() {
                              _selectedText = 0;
                              _selectedHoverUnderLine[0]=true;
                              _selectedHoverUnderLine[1]=false;
                              _selectedHoverUnderLine[2]=false;
                            });
                            widget.onPageIndexCallBack(0);
                          },
                          child: _tab(
                            borderColor: _selectedHoverUnderLine[0]==true||_selectedText==0?Colors.blue:Colors.transparent,
                              text: "Home",
                              image: _selectedText == 0
                                  ? _selectedIndicatorImg
                                  : null)),
                      SizedBox(
                        width: 28,
                      ),
                      InkWell(
                          onHover: (value) {
                            setState(() {
                              _selectedHoverUnderLine[1] = value;
                            });
                          },
                          hoverColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _selectedText = 1;
                              _selectedHoverUnderLine[0]=false;
                              _selectedHoverUnderLine[1]=true;
                              _selectedHoverUnderLine[2]=false;
                            });
                            widget.onPageIndexCallBack(1);
                          },
                          child: _tab(
                              borderColor: _selectedHoverUnderLine[1]==true||_selectedText==1?Colors.blue:Colors.transparent,

                              text: "Pricing",
                              image: _selectedText == 1
                                  ? _selectedIndicatorImg
                                  : null)),
                      SizedBox(
                        width: 28,
                      ),
                      InkWell(
                          hoverColor: Colors.transparent,
                          onHover: (value) {
                            setState(() {
                              _selectedHoverUnderLine[2] = value;
                            });
                          },
                          onTap: () {
                            setState(() {
                              _selectedText = 2;
                              _selectedHoverUnderLine[0]=false;
                              _selectedHoverUnderLine[1]=false;
                              _selectedHoverUnderLine[2]=true;
                            });
                            widget.onPageIndexCallBack(2);
                          },
                          child: _tab(
                              borderColor: _selectedHoverUnderLine[2]==true||_selectedText==2?Colors.blue:Colors.transparent,
                              text: "Documentation",
                              image: _selectedText == 2
                                  ? _selectedIndicatorImg
                                  : null)),
                      SizedBox(
                        width: 28,
                      ),
                      InkWell(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: (){
                          widget.onPageIndexCallBack(3);
                          _selectedText = 4;
                          _selectedHoverUnderLine[0]=false;
                          _selectedHoverUnderLine[1]=false;
                          _selectedHoverUnderLine[2]=false;
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 21,
                              width: 15,
                            ),
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(.2),spreadRadius: 1,blurRadius: 3)
                                ]
                              ),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset('assets/profile_img.png')),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _tab({text, image, borderColor}) {
    return Column(
      children: [
        Container(
          height: 21,
          width: 49,
          child: image == null ? null : Image.asset(image),
        ),
        Container(
          child: Text(text,style: TextStyle(fontWeight: image==null?FontWeight.normal:FontWeight.w600),),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1.2, color: borderColor))),
        ),
      ],
    );
  }
}
