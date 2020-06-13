import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventstracker/base/BaseWidget.dart';
import 'package:eventstracker/database/app_database.dart';
import 'package:eventstracker/service_locator.dart';
import 'package:eventstracker/shared/shared_colors.dart';
import 'package:eventstracker/shared/shared_font_family.dart';
import 'package:eventstracker/ui/widgets/pop_up_confirmation.dart';
import 'package:eventstracker/viewmodels/pages/event_detail_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatefulWidget {
  int _eventId;

  EventDetailPage({@required int eventId}) {
    _eventId = eventId;
  }

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BaseWidget<EventDetailViewModel>(
        model: locator<EventDetailViewModel>(),
        onModelReady: (EventDetailViewModel viewModel) {
          viewModel.getEventById(
            eventId: widget._eventId,
          );
        },
        builder: (BuildContext context, EventDetailViewModel viewModel, child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: SharedColors.brown,
                size: 16.62,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Image.asset(
              "assets/images/logo.png",
              height: AppBar().preferredSize.height - 20,
            ),
          ),
          body: !viewModel.busy
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: <Widget>[
                      _buildCarouselSliderWidget(viewModel.event),
                      _buildEventInfoWidget(viewModel),
                    ],
                  ),
                )
              : Center(
                  child: Image.asset(
                    "assets/images/loading.gif",
                    width: 100,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildCarouselSliderWidget(Event event) {
    return Container(
      child: CarouselSlider.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int itemIndex) => Container(
          width: MediaQuery.of(context).size.width,
          child: FittedBox(
            child: Image.asset(
              "assets/images/events/${event.name}/${itemIndex + 1}.jpg",
              width: MediaQuery.of(context).size.width,
            ),
            fit: BoxFit.cover,
          ),
        ),
        options: CarouselOptions(
            autoPlay: false,
            viewportFraction: 1,
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top + AppBar().preferredSize.height + 125)),
      ),
    );
  }

  Widget _buildEventInfoWidget(EventDetailViewModel viewModel) {
    return Positioned(
      bottom: 0,
      child: Material(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
        child: Container(
          height: 160,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            right: 15.0,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            child: Image.asset(
                              "assets/images/events/${viewModel.event.name}/thumbnail.jpg",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                viewModel.event.name,
                                style: TextStyle(
                                  fontFamily: SharedFontFamily.GOTHAM,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 4.0,
                              ),
                              width: 168,
                              child: Text(
                                "${viewModel.event.location} | ${viewModel.event.cityLocation}",
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
                      ],
                    ),
                    Container(
                      child: Text(
                        viewModel.event.price == 0 ? "FREE" : "${viewModel.event.price}K",
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
              viewModel.eventTracked == null
                  ? _buildButtonTrackEventWidget(viewModel)
                  : _buildTrackedEventWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonTrackEventWidget(EventDetailViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return PopUpConfirmationWidget(
              height: 210.0,
              buttonText: "Yes",
              cancelButtonText: "No",
              message: "Do you want to track this event?",
              buttonAction: () async {
                if (!viewModel.isLoadingTrackEvent)
                  await viewModel.trackEvent(id: viewModel.event.id);

                Navigator.pop(context);
              },
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: SharedColors.brown,
          borderRadius: BorderRadius.all(
            Radius.circular(
              50.0,
            ),
          ),
        ),
        margin: EdgeInsets.only(
          bottom: 15.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Text(
          "Track Event",
          style: TextStyle(
            fontFamily: SharedFontFamily.GOTHAM_BOOK,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTrackedEventWidget() {
    return Container(
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
      margin: EdgeInsets.only(
        bottom: 15.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Text(
        "Tracked",
        style: TextStyle(
          fontFamily: SharedFontFamily.GOTHAM,
          fontWeight: FontWeight.bold,
          color: SharedColors.brown,
        ),
      ),
    );
  }
}
