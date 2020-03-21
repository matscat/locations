import 'package:flutter/material.dart';
import 'locationDetail.dart';


class LocationStepper extends StatefulWidget {
  LocationStepper({Key key, this.title, this.location}) : super(key: key);
  final String title;
  final Location location;

  @override
  _LocationStepperState createState() => _LocationStepperState();
}


class _LocationStepperState extends State<LocationStepper> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;


  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.location.locationSteps.length,
      itemBuilder: (context, index) =>
          Column(
            children: [
              new ListTile(
                leading: Icon(Icons.fiber_manual_record),
                title: new Text(widget.location.locationSteps[index].title),
                trailing: Icon(Icons.keyboard_arrow_right),
 //               onTap: (
  //                  final
 //                   location: widget.location, ) {
 //                 ViewStep();
  //              },
              ),
            ],
          ),

    );
  }
}



class ViewStep extends StatefulWidget {
  ViewStep({Key key, this.location, this.index}) : super(key: key);
  final Location location;
  final int index;

  @override
  _ViewStepState createState() => _ViewStepState();
}


class _ViewStepState extends State<ViewStep> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;


  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 20.0, top: 20.0, left: 10.0, right: 10.0),
          child: new Text(widget.location.locationSteps[widget.index].title,
            textAlign: TextAlign.left,
            style: new TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Row(
          children : <Widget>[
            Expanded( flex: 1,
              child: Image.asset(
                widget.location.photo,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ],
    );
  }
}