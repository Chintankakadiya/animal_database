import 'package:animals_database/data/animal_nio_app_inital_data.dart';
import 'package:flutter/material.dart';

import '../helper/database_helper.dart';
import '../model/app_model.dart';

class AnimalData extends StatefulWidget {
  const AnimalData({super.key});

  @override
  State<AnimalData> createState() => _AnimalDataState();
}

class _AnimalDataState extends State<AnimalData> {
  Future<List<Animal>>? futureAnimalData;

  @override
  Future<List<Animal>> initProcess() async {
    List<Animal> animalData = await DBHelper.dbHelper.fecthData();
    if (animalData.isEmpty) {
      List res = animals.map((e) async {
        return await DBHelper.dbHelper.insertData(
            name: e.name,
            description: e.description,
            image: e.image,
            type: e.type);
      }).toList();
      animalData = await DBHelper.dbHelper.fecthData();
      return DBHelper.dbHelper.fecthData();
    }
    return DBHelper.dbHelper.fecthData();
  }

  @override
  void initState() {
    // TODO: implement initState
    print(selectedAnimalType!.tableName);
    futureAnimalData = initProcess();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          },
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text("Animal Biography"),
      ),
      body: FutureBuilder(
        future: futureAnimalData,
        builder: (BuildContext context, AsyncSnapshot<List<Animal>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR:${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(selectedAnimalType!.bgImage),
                        fit: BoxFit.cover,
                      )),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          Colors.white,
                          Colors.transparent,
                        ])),
                  ),
                ),
                ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 80,
                      width: double.infinity,
                    ),
                    Text(
                      "${selectedAnimalType!.tableName}\nAnimal",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 80),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: animals
                            .map((e) => (e.type ==
                                    selectedAnimalType!.tableName)
                                ? Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    height: 370,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.20),
                                            offset: Offset(0, 0),
                                            blurRadius: 5,
                                            spreadRadius: 3,
                                          ),
                                        ]),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 250,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: NetworkImage(e.image),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                e.description,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container())
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
                      child: Text(
                        "View Other Animals",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Column(
                      children: animalTypesList
                          .map(
                            (e) => (e == selectedAnimalType)
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
                                      selectedAnimalType = e;
                                      Navigator.pushNamed(context, 'animated');
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      height: 100,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: NetworkImage(e.bgImage),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.20),
                                              offset: Offset(0, 0),
                                              blurRadius: 5,
                                              spreadRadius: 3,
                                            )
                                          ]),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(11),
                                            bottomLeft: Radius.circular(11),
                                          ),
                                          color: Colors.black.withOpacity(0.50),
                                        ),
                                        child: Text(
                                          "${e.tableName}Animal",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                          .toList(),
                    )
                  ],
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
