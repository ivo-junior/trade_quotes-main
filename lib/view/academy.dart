import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Academy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AcademyState();
  }
}

class _AcademyState extends State<Academy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Academia")),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 3.0),
              ),
              padding: const EdgeInsets.all(16),
              child: Text(
                'Pergunta $index',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          );
        }),
      ),
    );
  }
}
