import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final _selectedIndex;
  Details(this._selectedIndex);

  @override
  //_DetailsState createState() => _DetailsState();
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  initState() {
    super.initState();
    print(widget._selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    //return Center(child: Text('Item ${widget._selectedIndex}sub-menu'));
    return Center(child: Text('Item ${widget._selectedIndex}sub-menu'));
  }
}
