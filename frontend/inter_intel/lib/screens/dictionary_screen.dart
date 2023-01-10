import 'dart:collection';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {

  @override
  void initState() {
    sortMethod();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var dict = {
      '34': 'thirty-four',
      '90': 'ninety',
      '91': 'ninety-one',
      '21': 'twenty-one',
      '61': 'sixty-one',
      '9': 'nine',
      '2': 'two',
      '6': 'six',
      '3': 'three',
      '8': 'eight',
      '80': 'eighty',
      '81': 'eighty-one',
      'Ninety-Nine': '99',
      'nine-hundred': '900'
    };

    // Extracting the keys of the dict into a list
    var keys = dict.keys.toList();
    const int maxValue = 9999999;
    //sorting the list of keys
    keys.sort((k1, k2) {
      int k1Int = maxValue;
      int k2Int = maxValue;
      try{
        k1Int= int.parse(k1);
      } on FormatException {
      }
      try{
        k2Int= int.parse(k2);
      } on FormatException {
      }
      return k1Int.compareTo(k2Int);
    });
    return Scaffold(
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Colors.pink,
          Colors.pinkAccent,
          Colors.white,
        ],
        secondaryColors: const [
          Colors.white,
          Colors.blueAccent,
          Colors.blue,
        ],
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Dictionary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
              pinned: true,
              leading: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.arrowLeftLong, color: Colors.blue,),
                onPressed: () {

                },
              ),
              backgroundColor: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(2),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          offset: const Offset(0.0, 1.0),
                          blurRadius: 6.0)
                    ],
                  ),
                  child:  ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    var key = keys[index];
                    return Card(
                      child: ListTile(
                        title: Text("$key : ${dict[key]}"),
                      ),
                    );
                  }
              ),
              ),),)
          ],
        ),
      ),
    );
  }

  void sortMethod() {
    var dict = {
      '34': 'thirty-four',
      '90': 'ninety',
      '91': 'ninety-one',
      '21': 'twenty-one',
      '61': 'sixty-one',
      '9': 'nine',
      '2': 'two',
      '6': 'six',
      '3': 'three',
      '8': 'eight',
      '80': 'eighty',
      '81': 'eighty-one',
      'Ninety-Nine': '99',
      'nine-hundred': '900'
    };

    // Extracting the keys of the dict into a list
    var keys = dict.keys.toList();
    const int maxValue = 9999999;
    //sorting the list of keys
    keys.sort((k1, k2) {
      int k1Int = maxValue;
      int k2Int = maxValue;
      try{
        k1Int= int.parse(k1);
      } on FormatException {
      }
      try{
        k2Int= int.parse(k2);
      } on FormatException {
      }
      return k1Int.compareTo(k2Int);
    });

    //iterating the keys in sorted order and printing the key value pair
    for (var key in keys) {
      print('$key : ${dict[key]}');
    }
  }
}