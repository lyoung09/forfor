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

  bool transform = false;

  void onItemClick(int index, Inbox obj) {
    //  MyToast.show(obj.name!, context, duration: MyToast.LENGTH_SHORT);
  }
  @override
  void initState() {
    items = Dummy.getInboxData();
    super.initState();
  }

  static const List<String> names = [
    "Sandra",
    "Charlie",
    "Johnson",
    "Trevor",
    "Smith",
  ];
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

    return new Obx(() => Scaffold(
          appBar: AppBar(
              title: Text("채팅", style: TextStyle(fontSize: 30)),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {},
                color: Colors.black,
              ),
              toolbarHeight: 60,
              automaticallyImplyLeading: false,
              backgroundColor:
                  //modeSelection.value ? Colors.blueGrey[600] : Colors.red[600],
                  Colors.grey[400],
              brightness: Brightness.dark,
              titleSpacing: 0,
              iconTheme: IconThemeData(color: Colors.white),
              actions: modeSelection.value
                  ? <Widget>[
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            items.removeWhere((e) => e.selected.value == true);
                            adapter.clearSelection();
                            refreshList.value = !refreshList.value;
                          });
                        },
                      )
                    ]
                  : <Widget>[
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: new Icon(Icons.photo),
                                      title: new Text('즐겨찾기'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.music_note),
                                      title: new Text('개인'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.videocam),
                                      title: new Text('내국인'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      )
                    ]),
          body: adapter.getView(),
        ));
  }
}
