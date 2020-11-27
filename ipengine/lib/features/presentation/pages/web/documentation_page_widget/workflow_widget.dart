import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';
import 'package:timeline_tile/timeline_tile.dart';

class WorkFlowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            right: 10,
            top: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: btnBgColor.withOpacity(.4),
          ),
          child: TimelineTile(
            alignment: TimelineAlign.start,
            axis: TimelineAxis.vertical,
            hasIndicator: true,
            indicatorStyle: IndicatorStyle(
                color: Colors.red,
                iconStyle: IconStyle(
                    iconData: FontAwesome.exclamation, color: Colors.white),
                indicator: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      color: Colors.red),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(FontAwesome.exclamation,
                        size: 14, color: Colors.white),
                  ),
                )),
            endChild: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Regenerate your API key periodically."),
              ),
            ),
          ),
        )
      ],
    );
  }
}
