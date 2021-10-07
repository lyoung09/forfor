import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CollapsingTab extends StatefulWidget {
  @override
  _CollapsingTabState createState() => new _CollapsingTabState();
}

class _CollapsingTabState extends State<CollapsingTab> {
  late ScrollController scrollController;

  Widget _buildActions() {
    Widget profile = new GestureDetector(
      onTap: () => showProfile(),
      child: new Container(
        height: 30.0,
        width: 45.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
          image: new DecorationImage(
            image: new ExactAssetImage("assets/icon/buddy.png"),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: Colors.black, width: 2.0),
        ),
      ),
    );

    double scale;
    if (scrollController.hasClients) {
      scale = scrollController.offset / 300;
      scale = scale * 2;
      if (scale > 1) {
        scale = 1.0;
      }
    } else {
      scale = 0.0;
    }

    return new Transform(
      transform: new Matrix4.identity()..scale(scale, scale),
      alignment: Alignment.center,
      child: profile,
    );
  }

  Widget _buildtitle() {
    Widget profile = new GestureDetector(
      onTap: () => showProfile(),
      child: new Container(
        height: 30.0,
        width: 200.0,
        child: Text("userNameuserNameuserNameuserName",
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: TextStyle(color: Colors.black)),
      ),
    );

    double scale;
    if (scrollController.hasClients) {
      scale = scrollController.offset / 500;

      scale = scale * 2;
      if (scale > 1) {
        scale = 1.0;
      }
    } else {
      scale = 0.0;
    }

    return new Transform(
      transform: new Matrix4.identity()..scale(scale, scale),
      alignment: Alignment.center,
      child: profile,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var flexibleSpaceWidget = new SliverAppBar(
      backgroundColor: Colors.orange[50],
      expandedHeight: 350.0,
      pinned: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {},
        color: Colors.black,
      ),
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: _buildtitle(),
          background: Container(
            decoration: BoxDecoration(color: Colors.orange[50]),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Image.asset(
                    "assets/icon/buddy.png",
                  ),
                ),
              ],
            ),
          )),
      actions: <Widget>[
        new Padding(
          padding: EdgeInsets.all(5.0),
          child: _buildActions(),
        ),
      ],
    );

    return Scaffold(
      body: new DefaultTabController(
        length: 2,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              flexibleSpaceWidget,
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.black26,
                    tabs: [
                      Tab(icon: Icon(Icons.add_location), text: "Group"),
                      Tab(icon: Icon(Icons.monetization_on), text: "QnA"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: new TabBarView(
            children: <Widget>[
              new Text("Detail"),
              new Text("Address"),
            ],
          ),
        ),
      ),
    );
  }

  showProfile() {
    Navigator.pushNamed(context, '/profile');
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      decoration: BoxDecoration(color: Colors.orange[50]),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
