import 'package:flutter/material.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';

class GroupSearch extends StatefulWidget {
  final SimpleHiddenDrawerController controller;
  GroupSearch({Key? key, required this.controller});

  @override
  GroupSearchState createState() => new GroupSearchState();
}

class GroupSearchState extends State<GroupSearch> {
  bool finishLoading = true;
  bool showClear = false;
  final TextEditingController inputController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: TextField(
          autofocus: true,
          maxLines: 1,
          controller: inputController,
          style: new TextStyle(color: Colors.grey[800], fontSize: 18),
          keyboardType: TextInputType.text,
          onSubmitted: (term) {
            setState(() {
              finishLoading = false;
            });
            delayShowingContent();
          },
          onChanged: (term) {
            setState(() {
              showClear = (term.length > 2);
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '그룹 내 찾고 싶은 검색어를 입력하세요',
            hintStyle: TextStyle(fontSize: 20.0),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            widget.controller.toggle();
          },
        ),
        actions: <Widget>[
          showClear
              ? IconButton(
                  icon: const Icon(Icons.close, color: MyColors.grey_90),
                  onPressed: () {
                    inputController.clear();
                    showClear = false;
                    setState(() {});
                  },
                )
              : Container(),
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          opacity: finishLoading ? 1.0 : 0.0,
          duration: Duration(milliseconds: 100),
          child: buildContent(context),
        ),
        AnimatedOpacity(
          opacity: finishLoading ? 0.0 : 1.0,
          duration: Duration(milliseconds: 100),
          child: buildLoading(context),
        ),
      ],
    );
  }

  Widget buildLoading(BuildContext context) {
    return Align(
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
      alignment: Alignment.center,
    );
  }

  Widget buildContent(BuildContext context) {
    return Align(
      child: Container(
        width: 180,
        height: 100,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("No result",
                style: MyText.headline(context)!.copyWith(
                    color: Colors.grey[500], fontWeight: FontWeight.bold)),
            Container(height: 5),
            Text("Try input more general keyword",
                textAlign: TextAlign.center,
                style:
                    MyText.medium(context).copyWith(color: Colors.grey[500])),
          ],
        ),
      ),
      alignment: Alignment.center,
    );
  }

  void delayShowingContent() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        finishLoading = true;
      });
    });
  }
}
