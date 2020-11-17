
import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';

class ItemVersionRow extends StatelessWidget {

  final Band band;

  const ItemVersionRow({this.band});

  @override
  Widget build(BuildContext context) {
    final arrowRight = MediaQuery.of(context).size.width * 0.43;
    final texts = MediaQuery.of(context).size.width * 0.05;
    final cardBox = MediaQuery.of(context).size.width * 0.04;

    return Column(
      children: <Widget> [
        Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 1), width: 2)),
            ),
        ),
        Container(
          height: 100,
          width: double.maxFinite,
          color: Color.fromRGBO(23, 24, 46, 1),
          child: Row(
            children: <Widget>[
              Container(
                width: 70,
                height: 70,
                margin: EdgeInsets.only(left: cardBox),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: texts),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Titulo',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text('40 contenidos',
                        style: TextStyle(color: Colors.white54)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: arrowRight),
                child: IconButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('playlist');
                  },
                  icon: Icon(Icons.keyboard_arrow_right,
                      color: Color.fromRGBO(131, 138, 176, 1)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
