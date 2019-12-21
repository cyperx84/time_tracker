import 'package:flutter/material.dart';
import 'package:time_tracker/widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String assetImgName,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(assetImgName != null),
        assert(text != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(assetImgName),
              Text(text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                  )),
              Opacity(
                child: Image.asset(assetImgName),
                opacity: 0.0,
              ),
            ],
          ),
          color: color,
          onPressed: onPressed,
        );
}
