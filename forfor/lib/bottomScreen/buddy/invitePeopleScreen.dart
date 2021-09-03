import 'package:flutter/material.dart';
import 'package:forfor/model/scientist.dart';
import 'package:forfor/widget/custom_dialog.dart';
import 'package:intrinsic_grid_view/intrinsic_grid_view.dart';

class InvitePersonScreen extends StatefulWidget {
  const InvitePersonScreen({Key? key}) : super(key: key);

  @override
  _InvitePersonScreenState createState() => _InvitePersonScreenState();
}

class _InvitePersonScreenState extends State<InvitePersonScreen> {
  int? _index;
  List<ScientistModel> fetchScientists() {
    return <ScientistModel>[
      ScientistModel(
          'Alain Aspect',
          'https://res.cloudinary.com/highereducation/image/upload/w_120,h_160,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/alain-aspect.jpg',
          "Alain Aspect holds the Augustin Fresnel Chair at the Institut d'Optique."),
      ScientistModel(
          'David Baltimore',
          'https://res.cloudinary.com/highereducation/image/upload/w_125,h_175,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/david-baltimore.jpg',
          "David Baltimore is currently Professor of Biology at the California Institute of Technology."),
      ScientistModel(
          'John Tyler Bonner',
          'https://res.cloudinary.com/highereducation/image/upload/w_120,h_137,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/john-tyler-bonner.jpg',
          "John Tyler Bonner is one of the world's leading biologists, primarily known for his work in the use of cellular slime molds to understand evolution."),
      ScientistModel(
          'Dennis Bray',
          'https://res.cloudinary.com/highereducation/image/upload/w_130,h_170,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/dennis-bray.jpg',
          "Dennis Bray is a professor emeritus in the Department of Physiology, Development, and Neuroscience at the University of Cambridge."),
      ScientistModel(
          'Sydney Brenner',
          'https://res.cloudinary.com/highereducation/image/upload/w_130,h_170,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/sydney-brenner.jpg',
          "Sydney Brenner is a biologist and the winner of the 2002 Nobel Prize in Physiology or Medicine,"),
      ScientistModel(
          'Pierre Chambon',
          'https://res.cloudinary.com/highereducation/image/upload/w_160,h_160,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/pierre-chambon.jpg',
          "Pierre Chambon is professor at the University of Strasbourg's Institute for Advanced Study."),
      ScientistModel(
          'Simon Conway Morris',
          'https://res.cloudinary.com/highereducation/image/upload/w_130,h_170,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/simon-conway-morris.jpg',
          "Simon Conway Morris is Chair of Evolutionary Palaeobiology in the Earth Sciences Department at Cambridge University."),
      ScientistModel(
          'Mildred S. Dresselhaus',
          'https://res.cloudinary.com/highereducation/image/upload/w_160,h_160,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/mildred-dresselhouse.jpg',
          "Mildred S. Dresselhaus is a professor of physics and electrical engineering"),
      ScientistModel(
          'Allen J. Bard',
          'https://res.cloudinary.com/highereducation/image/upload/w_160,h_165,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/allan-j-bard.jpg',
          'Allen J. Bard is a professor at the University of Texas, where he also serves as director of the Center for Electrochemistry and holds the Norman Hackerman-Welch Regents Chair. He received his Ph.D. from Harvard University in 1958.'),
      ScientistModel(
          'Timothy Berners-Lee',
          'https://res.cloudinary.com/highereducation/image/upload/w_130,h_175,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/timothy-berners-lee.jpg',
          'Timothy Berners-Lee is a computer scientist, best known as the inventor of the World Wide Web. He was honored as the "Inventor of the World Wide Web" during the 2012 Summer Olympics opening ceremony.'),
      ScientistModel(
          'Gerald M. Edelman',
          'https://res.cloudinary.com/highereducation/image/upload/w_160,h_145,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/gerald-m-edelman1.jpg',
          "Gerald M. Edelman is a biologist, immunologist, and neuroscientist."),
      ScientistModel(
          'Ronald M. Evans',
          'https://res.cloudinary.com/highereducation/image/upload/w_130,h_180,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/ronald-m-evans.jpg',
          "Ronald M. Evans is the March of Dimes Chair in Molecular and Developmental Biology at the Salk Institute for Biological Studies in San Diego."),
      ScientistModel(
          'Jane Goodall',
          'https://res.cloudinary.com/highereducation/image/upload/w_130,h_170,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/jane-goodall.jpg',
          "Jane Goodall is a primatologist, ethologist, and anthropologist."),
      ScientistModel(
          'Leroy Hood',
          'https://res.cloudinary.com/highereducation/image/upload/w_140,h_160,c_fill,f_auto,fl_lossy,q_auto/v1/TheBestSchools.org/leroy-hood.jpg',
          "Leroy Hood is co-founder and President of the Institute for Systems Biology.")
    ];
  }

  Widget _buildGridView(ScientistModel scientist) {
    double radius = 5.0;

    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: "Custom Dialog Demo",
                descriptions:
                    "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                img: Image.network('${scientist.image}'),
                text: "Yes",
              );
            });
      },
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          elevation: 30,
          shadowColor: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 5, bottom: 8),
                    child: ClipOval(
                      child: Image.network(
                        "${scientist.image}",
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 4, left: 15, bottom: 8, top: 8),
                    child: Text(
                      scientist.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4, left: 8, bottom: 8),
                child: Text(
                  scientist.desc,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Divider(color: Colors.black, height: 1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 5, // to apply margin in the main axis of the wrap
                  runSpacing: 5,
                  children: <Widget>[
                    Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Text('Elizabeth'),
                      avatar: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/icon/gender.png')),
                    ),
                    Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Text('Evans C'),
                    ),
                    Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Text('Anderson Thomas'),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<ScientistModel> scientists = fetchScientists();
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("초대하기",
                      style: TextStyle(color: Colors.black, fontSize: 30)),
                ),
                Spacer(),
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Divider(color: Colors.black, height: 1),
            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _index = 1;
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: height * 0.1,
                        width: width * 0.2,
                        child: Text("K-pop")),
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: height * 0.1,
                      width: width * 0.2,
                      child: Text("K-pop")),
                  Container(
                      alignment: Alignment.center,
                      height: height * 0.1,
                      width: width * 0.2,
                      child: Text("K-pop")),
                  Container(
                      alignment: Alignment.center,
                      height: height * 0.1,
                      width: width * 0.2,
                      child: Text("K-pop")),
                  Container(
                      alignment: Alignment.center,
                      height: height * 0.1,
                      width: width * 0.2,
                      child: Text("K-pop")),
                  Container(
                      alignment: Alignment.center,
                      height: height * 0.1,
                      width: width * 0.2,
                      child: Text("K-pop")),
                  Container(
                      alignment: Alignment.center,
                      height: height * 0.1,
                      width: width * 0.2,
                      child: Text("K-pop")),
                ],
              ),
            ),

            IntrinsicGridView.vertical(
                padding:
                    EdgeInsets.only(top: 16, bottom: 12, left: 8, right: 8),
                // columnCount: 3,
                verticalSpace: 10,
                horizontalSpace: 10,
                children: [
                  for (var scientist in scientists) _buildGridView(scientist),
                ]), // IntrinsicGridView.vertical
          ],
        ),
      ),
    );
  }
}
