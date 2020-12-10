import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ipengine/features/presentation/pages/web/widgets/common.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';
import 'package:ipengine/features/presentation/widgets/web_google_map_widget.dart';

class IpEngineInfoPage extends StatefulWidget {
  @override
  _IpEngineInfoPageState createState() => _IpEngineInfoPageState();
}

class _IpEngineInfoPageState extends State<IpEngineInfoPage> {
  String _text = """{
  "network": {
    "ip": "8.8.8.8",
    "hostname": "dns.google.",
    "reverse": "2001:4860:4860::8844",
    "asn": "15169"
  },
  "location": {
    "country": "United States"
  },
  "arin": {
    "name": "LVLT-GOGL-8-8-8",
    "handle": "NET-8-8-8-0-1",
    "parent": "NET-8-0-0-0-1",
    "type": "ALLOCATION",
    "range": "8.8.8.0-8.8.8.255",
    "cidr": "NET-8-8-8-0-1",
    "status": [
      "active"
    ],
    "registration": "2014-03-14T16:52:05-04:00",
    "updated": "2014-03-14T16:52:05-04:00"
  },
  "organization": {
    "name": "Google LLC",
    "handle": "GOGL",
    "registration": "2000-03-30T00:00:00-05:00",
    "updated": "2019-10-31T15:45:45-04:00"
  },
  "contact": {
    "name": "Google LLC",
    "handle": "ZG39-ARIN",
    "registration": "2000-03-30T00:00:00-05:00",
    "updated": "2019-10-31T15:45:45-04:00",
    "phone": "+1-650-253-0000",
    "email": "arin-contact@google.com"
  },
  "abuse": {
    "name": "Abuse",
    "handle": "ABUSE5250-ARIN",
    "registration": "2000-03-30T00:00:00-05:00",
    "updated": "2019-10-31T15:45:45-04:00",
    "phone": "+1-650-253-0000",
    "email": "network-abuse@google.com"
  },
  "analysis": {
    "abuse": false,
    "anonymizers": false,
    "attacks": false,
    "malware": false,
    "organizations": false,
    "reputation": false,
    "spam": false
  }
}""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerWidget(),
            SizedBox(
              height: 10,
            ),
            _ipWidget(),
            SizedBox(
              height: 20,
            ),
            _bodyWidget(),
            SizedBox(
              height: 10,
            ),
            _footerWidget()
          ],
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "IPengine.dev",
                style: textStyle24,
              ),
              SizedBox(
                width: 10,
              ),
              _searchWidget(),
            ],
          ),
          Row(
            children: [
              Text(
                "ABOUT",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "FEATURES",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "USECASES",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _ipWidget() {
    return Column(
      children: [
        Text(
          "IP ADDRESS DETAILS",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          "8.8.8.8",
          style: TextStyle(
            fontSize: 48,
          ),
        ),
        Text(
          "IP ADDRESS DETAILS",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _searchWidget() {
    return Container(
      padding: EdgeInsets.only(left: 15),
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
      ),
      width: MediaQuery.of(context).size.width / 4,
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search",
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 15),
            suffixIcon: Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            )),
      ),
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 150),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: _leftWidget()),
          SizedBox(
            width: 25,
          ),
          Container(
            width: 1,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(.2),
          ),
          SizedBox(
            width: 25,
          ),
          Expanded(child: _rightWidget()),
        ],
      ),
    );
  }

  Widget _footerWidget() {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(.2)),
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: _leftFooterWidget()),
          Expanded(child: _rightFooterWidget()),
        ],
      ),
    );
  }

  Widget _leftWidget() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              FontAwesome.map_marker,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Location",
              style: TextStyle(fontSize: 26),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 240,
          child: getMap(),
        ),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "City", value: "Mountain View"),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "Region", value: "California"),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "Postal Code", value: "94043"),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "Coordinates", value: "37,4056,123.2342"),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "Timezone", value: "America/Los_Angeles"),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "Local Time", value: "December 05,2020 | 06:36 AM"),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "Country", value: "United States"),
        SizedBox(
          height: 20,
        ),
        _hostingDomainWidget(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _rightWidget() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              FontAwesome.wifi,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Location",
              style: TextStyle(fontSize: 26),
            )
          ],
        ),
        SizedBox(height: 15),
        _rowItem(title: "HostName", value: "dns.google"),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "Address type", value: "IPv4"),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "ASN", value: "AS15169"),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "Organization", value: "Google LLC (google.com)"),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "Route", value: "8.8.8.0/24"),
        SizedBox(
          height: 10,
        ),
        _rowItem(title: "Abuse Contact", value: "network-abuse@gmail.com"),
        SizedBox(
          height: 10,
        ),
        _rowItem3(title: "Privacy", value: "VPN", value2: "Proxy"),
        SizedBox(
          height: 10,
        ),
        _rowItem3(title: "", value: "Tor", value2: "Hosting"),
        SizedBox(
          height: 25,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Text(
            "Access all of this data with just one line of code using our API.",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Icon(
              Icons.speed,
              size: 24,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Network Speed",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    height: 40,
                    alignment: Alignment.center,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      FontAwesome.download,
                      color: Colors.transparent,
                      size: 18,
                    )),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "154.71 ms",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Text("Ping")
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(
             children: [
               Container(
                   height: 40,
                   alignment: Alignment.center,
                   width: 40,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     border: Border.all(color: Colors.green),
                     borderRadius: BorderRadius.all(Radius.circular(40)),
                   ),
                   padding: EdgeInsets.all(10),
                   child: Icon(
                     FontAwesome.download,
                     color: Colors.green,
                     size: 18,
                   )),
               SizedBox(
                 width: 20,
               ),
               Text(
                 "154.71 Mbps",
                 style: TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.w400,
                 ),
               )
             ],
           ),
            Text("Download")
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    height: 40,
                    alignment: Alignment.center,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      FontAwesome.download,
                      color: Colors.red,
                      size: 18,
                    )),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "54.71 Mbps",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Text("Upload")
          ],
        ),
        SizedBox(height: 20,),
        Text("The average network speed for Google LLC in is shown above. See how your own network speed compares at speedsmart.net.")
      ],
    );
  }

  Widget _rowItem({String title, String value}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
            child: Text(
          value,
        ))
      ],
    );
  }

  Widget _rowItem3({String title, String value, String value2}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
            child: Text(
          value,
          style: TextStyle(color: Colors.black.withOpacity(.5)),
        )),
        Expanded(
            child: Icon(
          Icons.clear,
          color: Colors.red,
        )),
        Expanded(
            child: Text(
          value,
          style: TextStyle(color: Colors.black.withOpacity(.5)),
        )),
        Expanded(
            child: Icon(
          Icons.clear,
          color: Colors.red,
        )),
      ],
    );
  }

  Widget _rowItemHosting({String title, String value}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _hostingDomainWidget() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              FontAwesome.internet_explorer,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "Hosted Domain Names",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            "There are 12,113 domain names hosted on this IP address. A sample of 16 of them are shown below."),
        SizedBox(
          height: 10,
        ),
        _rowItemHosting(title: "41.cn", value: "ftempurl.com"),
        SizedBox(
          height: 10,
        ),
        _rowItemHosting(title: "mcqs.az", value: "proxyie.cn"),
        SizedBox(
          height: 10,
        ),
        _rowItemHosting(title: "etempurl.com", value: "dtempural.com"),
        SizedBox(
          height: 10,
        ),
        _rowItemHosting(title: "gtempural.com", value: "bts-hyderabad.cn"),
        SizedBox(
          height: 10,
        ),
        _rowItemHosting(title: "ctempural.com", value: "dns.google.cn"),
        SizedBox(
          height: 10,
        ),
        _rowItemHosting(title: "server-plane.net", value: "htempural.com.cn"),
        SizedBox(
          height: 10,
        ),
        _rowItemHosting(title: "iptvx.tv", value: "betsy.software"),
        SizedBox(
          height: 10,
        ),
        _rowItemHosting(title: "mtqnia.com", value: "dealfortwo.at"),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _rightFooterWidget() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: colorF9F9F9,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: colorBBBBBB,
                  blurRadius: 4,
                  spreadRadius: 3,
                )
              ]),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200),
              child: Theme(
                data: ThemeData(
                  highlightColor: colorFFDE8A,
                ),
                child: TextField(
                  style: TextStyle(wordSpacing: 1.0, height: 2),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  controller: TextEditingController(text: _text),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _leftFooterWidget() {
    return Column(
      children: [
        Text(
          "Try Our Free Geolocation and Basic ANS details API",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Our free API is limited to 50,000 monthly requests and returns city level location data only, if you require larger query volumes or more information such as latitude/longitude, ISP details or threat level assessment, please see our paid plans",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
