import 'package:flutter/material.dart';
import 'package:ipengine/features/domain/entity/reverse_ip_entity.dart';

class ReversIpPage extends StatefulWidget {
  @override
  _ReversIpPageState createState() => _ReversIpPageState();
}

class _ReversIpPageState extends State<ReversIpPage> {
  final _data = ReversIpEntity.reverseIp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerWidget(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Row(
                    children: [
                      Text(
                        "1-100 of 1000 results",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      _pageNextWidget(
                          icon: Icons.arrow_back_ios_outlined, text: ""),
                      _pageNextWidget(icon: null, text: "1"),
                      _pageNextWidget(icon: null, text: "2"),
                      _pageNextWidget(icon: null, text: "3"),
                      _pageNextWidget(icon: null, text: "4"),
                      _pageNextWidget(
                          icon: Icons.arrow_forward_ios_outlined, text: ""),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                decoration: BoxDecoration(color: Colors.black.withOpacity(.1)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Domain",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Ranks",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Hosting Provider",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Mail Provider",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemCount: _data.length,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            _data[index].domain,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _data[index].rank,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _data[index].hostingProvider,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _data[index].MailProvider,
                            style: TextStyle(fontSize: 18, color: Colors.black),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "1.1.1.1 reverse IP lookup",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        SizedBox(
          height: 15,
        ),
        _searchWidget(),
      ],
    );
  }

  Widget _searchWidget() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width / 1.5,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.2),
      ),
      child: TextField(
          decoration: InputDecoration(
              hintText: "Search...",
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 22, left: 20),
              suffixIcon: Container(
                height: 55,
                width: 60,
                color: Colors.black.withOpacity(.8),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ))),
    );
  }

  Widget _pageNextWidget({String text, IconData icon}) {
    return Container(
      height: 30,
      width: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(.6), width: 1),
      ),
      child: icon == null
          ? Text(
              text,
              style: TextStyle(color: Colors.black.withOpacity(.6)),
            )
          : Icon(
              icon,
              color: Colors.black.withOpacity(.6),
            ),
    );
  }
}
