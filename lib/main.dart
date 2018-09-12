import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:heroapp/pokemon.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'Hero',
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    print(res);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    print(pokeHub.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero"),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: pokeHub == null
          ? Center(child: CircularProgressIndicator())
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHub.pokemon
                  .map((poke) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () {
                          print("Tapped on");
                        },
                        child: Card(
                          child: Column(children: <Widget>[
                            Container(
                              height: 100.0,
                              width: 100.0,
                              margin: const EdgeInsets.only(top: 20.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(poke.img))),
                            ),
                            Text(
                              poke.name,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]),
                        ),
                      )))
                  .toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan[200],
        child: Icon(Icons.refresh),
      ),
      drawer: Drawer(),
    );
  }
}
