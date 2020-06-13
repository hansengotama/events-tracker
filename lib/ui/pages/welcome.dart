import 'package:eventstracker/base/BaseWidget.dart';
import 'package:eventstracker/enum/route_paths.dart';
import 'package:eventstracker/service_locator.dart';
import 'package:eventstracker/shared/shared_colors.dart';
import 'package:eventstracker/shared/shared_font_family.dart';
import 'package:eventstracker/shared/shared_toast.dart';
import 'package:eventstracker/viewmodels/pages/welcome_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BaseWidget<WelcomeViewModel>(
        model: locator<WelcomeViewModel>(),
        builder: (BuildContext context, WelcomeViewModel viewModel, child) {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FittedBox(
                      child: Image.asset(
                        "assets/images/welcome-background.jpg",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Center(
                            child: Image.asset(
                              "assets/images/logo.png",
                              width: 150,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 2 - MediaQuery.of(context).padding.top,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                            horizontal: 50.0,
                          ),
                          child: Center(
                            child: Container(
                              child: _buildTextFieldWidget(viewModel),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextFieldWidget(WelcomeViewModel viewModel) {
    return TextField(
      controller: viewModel.textFieldController,
      style: TextStyle(
        fontFamily: SharedFontFamily.GOTHAM_BOOK,
      ),
      autofocus: false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Please enter your name',
        hintStyle: TextStyle(
          fontFamily: SharedFontFamily.GOTHAM_BOOK,
          color: SharedColors.softGrey,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: SharedColors.grey,
          ),
          onPressed: () async {
            if(await viewModel.onSubmit()) {
              Navigator.pushNamed(
                context,
                RoutePaths.HOME,
              );
            }else {
              SharedToast.show("Name must be required");
            }
          },
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              50.0,
            ),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
