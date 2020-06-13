import 'package:eventstracker/base/BaseWidget.dart';
import 'package:eventstracker/database/relations/track_event_with_event.dart';
import 'package:eventstracker/service_locator.dart';
import 'package:eventstracker/shared/shared_colors.dart';
import 'package:eventstracker/shared/shared_font_family.dart';
import 'package:eventstracker/ui/widgets/pop_up_confirmation.dart';
import 'package:eventstracker/viewmodels/pages/event_tracker_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventTrackerPage extends StatefulWidget {
  @override
  _EventTrackerPageState createState() => _EventTrackerPageState();
}

class _EventTrackerPageState extends State<EventTrackerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BaseWidget<EventTrackerViewModel>(
        model: locator<EventTrackerViewModel>(),
        onModelReady: (EventTrackerViewModel viewModel) {
          viewModel.getEventTracker();
        },
        builder: (BuildContext context, EventTrackerViewModel viewModel, child) => Scaffold(
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
          body: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (viewModel.onHorizontalDrag(details)) {
                Navigator.pop(context);
              }
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: 20.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Track Events",
                          style: TextStyle(
                            fontFamily: SharedFontFamily.GOTHAM,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        _buildTextConditionWidget(viewModel),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).padding.top + AppBar().preferredSize.height + 57),
                    margin: EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: _buildListConditionWidget(viewModel),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextConditionWidget(EventTrackerViewModel viewModel) {
    if(viewModel.isEdit) return _buildSaveTextWidget(viewModel);
    else return _buildEditTextWidget(viewModel);
  }

  Widget _buildListConditionWidget(EventTrackerViewModel viewModel) {
    if(viewModel.eventTrackers == null || viewModel.eventTrackers.isEmpty) return _buildListEmpty();

    if(viewModel.isEdit) return _buildEditTrackEventList(viewModel);
    else return _buildTrackEventList(viewModel);
  }

  Widget _buildListEmpty() {
    return Center(
      child: Text("Track Event is empty")
    );
  }

  Widget _buildSaveTextWidget(EventTrackerViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return PopUpConfirmationWidget(
              height: 210.0,
              buttonText: "Yes",
              cancelButtonText: "No",
              message: "Save changes?",
              buttonAction: () async {
                viewModel.setEdit(
                  status: false,
                );

                Navigator.pop(context);
              },
            );
          },
        );
      },
      child: Text(
        "Save",
        style: TextStyle(
          fontFamily: SharedFontFamily.GOTHAM,
          fontWeight: FontWeight.w700,
          color: SharedColors.brown,
        ),
      ),
    );
  }

  Widget _buildEditTextWidget(EventTrackerViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.setEdit(
          status: true,
        );
      },
      child: Text(
        "Edit",
        style: TextStyle(
          fontFamily: SharedFontFamily.GOTHAM,
          fontWeight: FontWeight.w700,
          color: SharedColors.brown,
        ),
      ),
    );
  }

  Widget _buildTrackEventList(EventTrackerViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.eventTrackers.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildEventWidget(viewModel, index, false);
      },
    );
  }

  Widget _buildEditTrackEventList(EventTrackerViewModel viewModel) {
    return ReorderableListView(
      children: List.generate(viewModel.eventTrackers.length, (index) => ListTile(
        key: UniqueKey(),
        contentPadding: EdgeInsets.all(0.0),
        title: _buildEventWidget(viewModel, index, true),
      )),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if(newIndex > oldIndex) newIndex -= 1;

          final TrackEventWithEvent newEventTracker = viewModel.eventTrackers.removeAt(oldIndex);
          viewModel.eventTrackers.insert(newIndex, newEventTracker);
        });
      },
    );
  }

  Widget _buildEventWidget(EventTrackerViewModel viewModel, int index, bool isEdit) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20.0,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10.0,),
        elevation: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0,),
                    bottomLeft: Radius.circular(10.0,),
                  ),
                  child: Image.asset(
                    "assets/images/events/${viewModel.eventTrackers[index].event.name}/thumbnail.jpg",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          viewModel.eventTrackers[index].event.name,
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
                          "${viewModel.eventTrackers[index].event.location} | ${viewModel.eventTrackers[index].event.cityLocation}",
                          style: TextStyle(
                            fontFamily: SharedFontFamily.GOTHAM,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: SharedColors.softGrey,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.0,
                        ),
                        width: 168,
                        child: Text(
                          viewModel.eventTrackers[index].event.price == 0 ? "FREE" : "${viewModel.eventTrackers[index].event.price}K",
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
              ],
            ),

            isEdit ? GestureDetector(
              child: Container(
                child: Image.asset(
                  "assets/images/trash-icon.png",
                  width: 22,
                ),
                margin: EdgeInsets.only(right: 10.0,),
              ),
              onTap: () {
                setState(() {
                  viewModel.eventTrackers.removeAt(index);
                });
              },
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
