import 'package:flutter/material.dart';
import 'package:news_info/constants.dart';

class BottomSheetMain extends StatelessWidget {
  const BottomSheetMain({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color(0x3B1D2429),
            offset: Offset(0, -3),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          print('Bottom Sheet Main');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                '1',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 34.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '1',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 34.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '1',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 34.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '1',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 34.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
