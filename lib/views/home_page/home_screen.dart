import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OPEN FASHION'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
          Center(
              child: Text(
            'NEW ARRIVAL',
            style: TextStyle(color: Colors.black),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Text1'),
              Text('Text1'),
              Text('Text1'),
              Text('Text1'),
              Text('Text1'),
            ],
          ),
          GridView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.63,
            ),
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(color: Colors.yellow),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(color: Colors.yellow),
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.yellow),
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.yellow),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Explore more'),
              Icon(Icons.keyboard_arrow_right_rounded),
            ],
          ),
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.blue),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.blue),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.blue),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.blue),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.blue),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.blue),
              ),
            ],
          ),
          Center(child: Text('Collection')),
          Container(
            height: 250,
            decoration: BoxDecoration(color: Colors.green),
          )
        ],
      ),
    );
  }
}
