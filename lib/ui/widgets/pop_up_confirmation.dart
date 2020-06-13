import 'package:eventstracker/shared/shared_colors.dart';
import 'package:eventstracker/shared/shared_font_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpConfirmationWidget extends StatefulWidget {
  String _message;
  double _height;
  String _buttonText;
  String _cancelButtonText;
  Function _buttonAction;

  PopUpConfirmationWidget({
    @required String message,
    @required double height,
    @required String buttonText,
    @required Function buttonAction,
    String cancelButtonText = "Cancel",
  }) {
    _message = message;
    _height = height;
    _buttonText = buttonText;
    _buttonAction = buttonAction;
    _cancelButtonText = cancelButtonText;
  }

  @override
  _PopUpConfirmationWidgetState createState() => _PopUpConfirmationWidgetState();
}

class _PopUpConfirmationWidgetState extends State<PopUpConfirmationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        contentPadding: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              15.0,
            ),
          ),
        ),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                15.0,
              ),
            ),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width - 60,
          height: widget._height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 50,
                ),
              ),
              Divider(height: 1, color: Colors.black),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                width: MediaQuery.of(context).size.width - 120,
                child: Text(
                  widget._message,
                  style: TextStyle(
                    fontFamily: SharedFontFamily.GOTHAM_BOOK,
                    color: SharedColors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                50.0,
                              ),
                            ),
                            border: Border.all(
                              color: SharedColors.brown,
                            ),
                          ),
                          width: double.infinity,
                          child: Text(
                            "${widget._cancelButtonText}",
                            style: TextStyle(
                              color: SharedColors.brown,
                              fontFamily: SharedFontFamily.GOTHAM_BOOK,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: widget._buttonAction,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                50.0,
                              ),
                            ),
                          ),
                          width: double.infinity,
                          child: Text(
                            widget._buttonText,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: SharedFontFamily.GOTHAM_BOOK,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
