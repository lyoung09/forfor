import 'package:flutter/material.dart';
import 'package:forfor/model/inbox.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:get/get.dart';
import 'MultiSelector.dart';
import '../../data/dummy.dart';

class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({Key? key}) : super(key: key);

  @override
  _ChatMainScreenState createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  late BuildContext context;
  List<Inbox> items = [];
  var modeSelection = false.obs;
  var refreshList = false.obs;
  var selectionCount = 0.obs;
  final TextEditingController _filter = new TextEditingController();

  void onItemClick(int index, Inbox obj) {
    //  MyToast.show(obj.name!, context, duration: MyToast.LENGTH_SHORT);
  }
  @override
  void initState() {
    items = Dummy.getInboxData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    var adapter = ListMultiSelectionAdapter(context, items, onItemClick);
    adapter.setOnSelectedMode((bool flag, int count) {
      print(
          "setOnSelectedMode : " + flag.toString() + " | " + count.toString());
      modeSelection.value = flag;
      selectionCount.value = count;
    });

    // return new Obx(() => Scaffold(
    //       appBar: AppBar(
    //           toolbarHeight: 60,
    //           automaticallyImplyLeading: false,
    //           backgroundColor:
    //               //modeSelection.value ? Colors.blueGrey[600] : Colors.red[600],
    //               Colors.grey[400],
    //           brightness: Brightness.dark,
    //           titleSpacing: 0,
    //           iconTheme: IconThemeData(color: Colors.white),
    //           actions: modeSelection.value
    //               ? <Widget>[
    //                   IconButton(
    //                     icon: Icon(Icons.delete),
    //                     onPressed: () {
    //                       setState(() {
    //                         items.removeWhere((e) => e.selected.value == true);
    //                         adapter.clearSelection();
    //                         refreshList.value = !refreshList.value;
    //                       });
    //                     },
    //                   )
    //                 ]
    //               : <Widget>[
    //                   IconButton(
    //                     icon: Icon(Icons.search),
    //                     onPressed: () {},
    //                   )
    //                 ]),
    //       body: adapter.getView(),
    //     ));
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                backgroundColor: Colors.grey[800],
                automaticallyImplyLeading: false,
                title: Text('AppBar'),
                actions: modeSelection.value
                    ? <Widget>[
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              items
                                  .removeWhere((e) => e.selected.value == true);
                              adapter.clearSelection();
                              refreshList.value = !refreshList.value;
                            });
                          },
                        )
                      ]
                    : <Widget>[
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        )
                      ],
                centerTitle: true,
                pinned: true,
                floating: true,
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.call), text: 'group'),
                    Tab(icon: Icon(Icons.message), text: 'each'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              adapter.getView(),
              adapter.getView(),
            ],
          ),
        ),
      ),
    );
  }
}
