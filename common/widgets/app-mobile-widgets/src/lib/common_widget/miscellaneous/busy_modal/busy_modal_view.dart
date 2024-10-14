import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';

class PSBusyView extends StatelessWidget {
  final String text;

  PSBusyView({this.text = '', Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      key: Key('PSBusyViewBuilder'),
      builder: (context) {
        final backGroundColor = Color(0xFFCCC9C8);
        return Stack(children: [
          Center(
            key: Key('PSBusyViewCenter'),
            child: Container(
              key: Key('PSBusyViewContainer'),
              color: backGroundColor,
              child: Center(
                key: Key('PSBusyViewChildCenter'),
                /* child: getPng(
                  'widget_library:assets/images/loader_no_background.gif',
                  height: 50,
                  width: 50,
                ), */
                child: PSImage(
                  PSImageModel(
                    iconPath:
                        'widget_library:assets/images/loader_no_background.gif',
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left:80,top: 150,right:80),
              child: text.isNotEmpty
                  ? Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Noto Sans',
                        fontSize: 14,
                      ),
                    )
                  : SizedBox(),
            ),
          ),
        ]);
      },
    );
  }
}
