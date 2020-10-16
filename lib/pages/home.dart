import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5, episodio: 'Episodio 10', fecha: '25-09-1990', duration: '02:00'),
    Band(id: '2', name: 'ACDC', votes: 3, episodio: 'Episodio 10', fecha: '25-09-1990', duration: '02:00'),
    Band(id: '3', name: 'Grupo Niche', votes: 2, episodio: 'Episodio 3',fecha: '25-09-1990', duration: '02:00'),
    Band(id: '4', name: 'Binomio de Oro', votes: 12, episodio: 'Episodio 35',fecha: '25-09-1990', duration: '02:00'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                 Icons.chevron_left,              
              ), onPressed: () {  },
            ),
            Text('Mi colección'),
            Spacer(flex: 3),
            Text('Editar')
          ],
        ),
        backgroundColor: Color.fromRGBO(39,31,74, 1),
        elevation: 10,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(
            child: Text('Descargas', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
          ),
          Divider(),

          Expanded(
                child: ListView.builder(
                itemCount: bands.length,
                itemBuilder: (context, i) {
                  return _bandTile(bands[i]);
                }
                ),
          ),
        ],
      ),
          
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.endToStart,
      onDismissed: ( direction ){
     print('Derección: $direction');
      },
      background: Container(
        padding: EdgeInsets.only(right: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text('Eliminar', style: TextStyle(color: Colors.white),)
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color.fromRGBO(27, 22, 50, 1), width: 2)),
              ),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange,  
                ),
                
                child: Text(band.name.substring(0, 2)),
              ),
              title: Text(band.name),
              subtitle: Text(band.episodio+' | '+band.fecha+ ' | ' +band.duration),
              //trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
              trailing: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(                    
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(131, 138, 179, 1), 
                      ),
                    ),
                    
                    Container(
                      margin: EdgeInsets.only(top: 2, bottom: 2),
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(131, 138, 179, 1), 
                      ),
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(131, 138, 179, 1), 
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                print(band.name);
              },
              
            ),
          ),         
        ],
      ),
      
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isWindows) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Band'),
            content: TextField(controller: textController),
            actions: <Widget>[
              MaterialButton(
                  child: Text('add'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addBandToList(textController.text))
            ],
          );
        },
      );
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('New band name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Add'),
                  onPressed: () => addBandToList(textController.text)),
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('Dismiss'),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 4));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
