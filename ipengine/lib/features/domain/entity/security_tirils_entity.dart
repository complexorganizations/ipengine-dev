class IpDataSet {
  final String title;
  final String leftValue;
  final String value;

  IpDataSet({this.title, this.leftValue,this.value});
}

class SecurityTrailsEntity {
  final String heading;
  final String headingValue;
  final String subHeading;
  final List<IpDataSet> ipData;
  final String title;

  SecurityTrailsEntity({
    this.heading,
    this.headingValue,
    this.subHeading,
    this.ipData,
    this.title,
  });

  static List<SecurityTrailsEntity> securityTrailsList = [
    SecurityTrailsEntity(
      heading: "A",
      subHeading: "records",
      headingValue: "",
      title: "GOOGLE LLC",
      ipData: [
        IpDataSet(title: "172.21713.238", value: "11,643",leftValue: ""),
      ],
    ),
    SecurityTrailsEntity(
      heading: "AAAA",
      subHeading: "records",
      headingValue: "",
      title: "GOOGLE LLC",
      ipData: [
        IpDataSet(title: "2608.f8b0.4004:809::200e",leftValue: "", value: "11,021"),
      ],
    ),
    SecurityTrailsEntity(
      heading: "AAAA",
      subHeading: "records",
      headingValue: "",
      title: "GOOGLE LLC",
      ipData: [
        IpDataSet(title: "2608.f8b0.4004:809::200e",leftValue: "", value: "11,021"),
      ],
    ),
    SecurityTrailsEntity(
      heading: "MAX",
      subHeading: "records",
      headingValue: "",
      title: "GOOGLE LLC",
      ipData: [
        IpDataSet(title: "alt4.aspmx.i.google.com",leftValue: "50 ", value: " 7,018,505"),
        IpDataSet(title: "alt4.aspmx.i.google.com",leftValue: "40 ", value: " 7,018,681"),
        IpDataSet(title: "alt4.aspmx.i.google.com",leftValue: "30 ", value: " 12,369,077"),
        IpDataSet(title: "alt4.aspmx.i.google.com",leftValue: "20 ", value: " 12,469,577"),
        IpDataSet(title: "alt4.aspmx.i.google.com",leftValue: "10 ", value: " 12,732,770"),
      ],
    ),
    SecurityTrailsEntity(
      heading: "SOA",
      subHeading: "records",
      headingValue: "",
      title: "ttl: 900",
      ipData: [
        IpDataSet(title: "dns-admin.google.com",leftValue: "email: ", value: "150,523"),

      ],
    ),
    SecurityTrailsEntity(
      heading: "TXT",
      subHeading: "",
      headingValue: "",
      title: "",
      ipData: [
        IpDataSet(title: "",leftValue: "v=spf1 include_spf.google.com ~ all", value: ""),
        IpDataSet(title: "",leftValue: "v=spf1 include_spf.google.com ~ all", value: ""),
        IpDataSet(title: "",leftValue: "v=spf1 include_spf.google.com ~ all", value: ""),
        IpDataSet(title: "",leftValue: "show more", value: ""),

      ],
    ),
    SecurityTrailsEntity(
      heading: "CNAME",
      subHeading: "records pointed here",
      headingValue: "7,825",
      title: "",
      ipData: [
        IpDataSet(title: "img01.olx.co.za",leftValue: "", value: ""),
        IpDataSet(title: "img01.olx.co.ke",leftValue: "", value: ""),
        IpDataSet(title: "googleadaff61b2c8b834.cbmre.ca",leftValue: "", value: ""),
        IpDataSet(title: "View more",leftValue: "", value: ""),

      ],
    ),
    SecurityTrailsEntity(
      heading: "MX",
      subHeading: "records pointed here",
      headingValue: "490",
      title: "",
      ipData: [
        IpDataSet(title: "phillip-moreeu.tapissier.com",leftValue: "", value: ""),
        IpDataSet(title: "phillip-moreeu.tapissier.com",leftValue: "", value: ""),
        IpDataSet(title: "phillip-moreeu.tapissier.com",leftValue: "", value: ""),
        IpDataSet(title: "View more",leftValue: "", value: ""),

      ],
    ),
    SecurityTrailsEntity(
      heading: "NS",
      subHeading: "records pointed here",
      headingValue: "25",
      title: "",
      ipData: [
        IpDataSet(title: "artrake.com",leftValue: " ", value: ""),
        IpDataSet(title: "rding-china.com",leftValue: " ", value: ""),
        IpDataSet(title: "kuzentps.com",leftValue: " ", value: ""),
        IpDataSet(title: "View more",leftValue: " ", value: ""),

      ],
    ),
  ];
}
