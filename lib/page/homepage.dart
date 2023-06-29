import 'package:animals_database/data/animal_nio_app_inital_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: null,
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.more_vert, color: Colors.white),
          )
        ],
        centerTitle: true,
        title: Text("ANIMAL BIOGRAPHY"),
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        children: animalTypesList
            .map(
              (e) => GestureDetector(
                onTap: () {
                  selectedAnimalType = e;
                  Navigator.pushNamed(context, 'animated');
                },
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 150,
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(e.bgImage),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.20),
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(11),
                        bottomRight: Radius.circular(11),
                      ),
                      color: Colors.black.withOpacity(0.50),
                    ),
                    child: Text(
                      "${e.tableName}Animal",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
      backgroundColor: Color(0xffEDEDED),
    );
  }
}
