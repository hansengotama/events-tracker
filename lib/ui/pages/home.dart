import 'package:eventstracker/base/BaseWidget.dart';
import 'package:eventstracker/enum/event_display_type.dart';
import 'package:eventstracker/enum/route_paths.dart';
import 'package:eventstracker/service_locator.dart';
import 'package:eventstracker/shared/shared_colors.dart';
import 'package:eventstracker/shared/shared_font_family.dart';
import 'package:eventstracker/viewmodels/pages/home_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BaseWidget<HomeViewModel>(
        model: locator<HomeViewModel>(),
        onModelReady: (HomeViewModel viewModel) {
          viewModel.getUserName();
          viewModel.initEvent();
        },
        builder: (BuildContext context, HomeViewModel viewModel, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Image.asset(
              "assets/images/logo.png",
              height: AppBar().preferredSize.height - 20,
            ),
            leading: Container(),
          ),
          body: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (viewModel.onHorizontalDrag(details)) {
                viewEventTracker();
              }
            },
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _buildFloatingWidget(viewModel),
                    !viewModel.busy
                        ? Container(
                            height: MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).padding.top +
                                    AppBar().preferredSize.height +
                                    35),
                            child: viewModel.eventDisplayType != EventDisplayType.LIST
                                ? _buildEventListWidget(viewModel)
                                : _buildEventGridWidget(viewModel),
                          )
                        : Center(
                          child: Image.asset(
                            "assets/images/loading.gif",
                            width: 100,
                          ),
                        ),
                  ],
                ),
                _buildFloatingTrackerWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingWidget(HomeViewModel viewModel) {
    return Container(
      height: 35,
      width: double.infinity,
      color: SharedColors.brown,
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Hi, ${viewModel.userName}",
            style: TextStyle(
              color: Colors.white,
              fontFamily: SharedFontFamily.GOTHAM_BOOK,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          GestureDetector(
            child: viewModel.eventDisplayType == EventDisplayType.LIST
                ? _buildEventListLogoWidget()
                : _buildEventGridLogoWidget(),
            onTap: () {
              viewModel.toggleEventDisplayType();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventListLogoWidget() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.list,
          color: Colors.white,
          size: 25,
        ),
        Text(
          "List View",
          style: TextStyle(
            color: Colors.white,
            fontFamily: SharedFontFamily.GOTHAM_BOOK,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget _buildEventGridLogoWidget() {
    return Row(
      children: <Widget>[
        Image.asset(
          "assets/images/grid-icon.png",
          width: 25,
        ),
        Text(
          "Grid View",
          style: TextStyle(
            color: Colors.white,
            fontFamily: SharedFontFamily.GOTHAM_BOOK,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildEventListWidget(HomeViewModel viewModel) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: viewModel.events.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            viewEventDetail(eventId: viewModel.events[index].id);
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: SharedColors.softBrown,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        right: 15.0,
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        child: Image.asset(
                          "assets/images/events/${viewModel.events[index].name}/thumbnail.jpg",
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 164,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              viewModel.events[index].name,
                              style: TextStyle(
                                fontFamily: SharedFontFamily.GOTHAM,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 6.0,
                            ),
                            child: Text(
                              viewModel.events[index].location,
                              style: TextStyle(
                                fontFamily: SharedFontFamily.GOTHAM,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: SharedColors.softGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    viewModel.events[index].price == 0 ? "FREE" : "PAID",
                    style: TextStyle(
                      fontFamily: SharedFontFamily.GOTHAM,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: SharedColors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventGridWidget(HomeViewModel viewModel) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        mainAxisSpacing: 25,
        crossAxisSpacing: 25,
      ),
      shrinkWrap: true,
      itemCount: viewModel.events.length,
      padding: EdgeInsets.all(
        20.0,
      ),
      itemBuilder: (_, index) => GestureDetector(
        onTap: () {
          viewEventDetail(eventId: viewModel.events[index].id);
        },
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                child: Image.asset(
                  "assets/images/events/${viewModel.events[index].name}/thumbnail.jpg",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  viewModel.events[index].name,
                  style: TextStyle(
                    fontFamily: SharedFontFamily.GOTHAM,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingTrackerWidget() {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      child: GestureDetector(
        onTap: () {
          viewEventTracker();
        },
        child: Image.asset(
          "assets/images/heart-icon.png",
          width: 40.0,
          height: 40.0,
        ),
      ),
    );
  }

  void viewEventTracker() {
    Navigator.pushNamed(
      context,
      RoutePaths.EVENT_TRACKER,
    );
  }

  void viewEventDetail({@required int eventId}) {
    Navigator.pushNamed(
      context,
      RoutePaths.EVENT_DETAIL,
      arguments: eventId,
    );
  }
}
