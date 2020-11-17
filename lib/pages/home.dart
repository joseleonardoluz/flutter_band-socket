import 'dart:io';

import 'package:band_names/moleculas/BandTile.dart';
import 'package:band_names/moleculas/ItemVersionRow.dart';
import 'package:band_names/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands', _hnadleActiveBnads);
    super.initState();
  }

  _hnadleActiveBnads(dynamic payload) {
    this.bands = (payload as List).map((band) => Band.fromMap(band)).toList();

    setState(() {
      //redibuja el widget
    });
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.chevron_left,
              ),
              onPressed: () {},
            ),
            Text('Mi colección'),
            Spacer(flex: 3),
            Text('Editar')
          ],
        ),
        backgroundColor: Color.fromRGBO(39, 31, 74, 1),
        elevation: 10,
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 10),
              child: (_socketService.serverStatus == ServerStatus.OnLine)
                  ? Icon(Icons.check_circle, color: Colors.blue)
                  : Icon(Icons.offline_bolt, color: Colors.red))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   child: Text('Descargas',
          //       style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
          // ),
          // Divider(),
          // _itemListaAdd(),
          // _itemListSimple(),
          // Container(
          //   height: 150,
          // ),
          // Divider(),
          // Expanded(
          //   child: ListView.builder(
          //       itemCount: bands.length,
          //       itemBuilder: (context, i) {
          //         return ItemVersionRow(band: bands[i]);
          //       }),
          // ),
                     
          _showGaph(),

          Expanded(
            child: ListView.builder(
                itemCount: bands.length,
                itemBuilder: (context, i) {
                  return BandTile(band: bands[i], context: context);
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addNewBand,
      ),
    );
  }

  Widget _itemListaAdd() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color.fromRGBO(27, 22, 50, 1), width: 2)),
              color: Color.fromRGBO(34, 24, 64, 1)),
          child: ListTile(
              leading: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange,
                ),
              ),
              title: Text(
                'Titulo',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text('40 contenidos',
                  style: TextStyle(color: Colors.white54)),
              trailing: Icon(Icons.keyboard_arrow_right,
                  color: Color.fromRGBO(131, 138, 176, 1))),
        ),
      ],
    );
  }

  Widget _itemListSimple() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color.fromRGBO(27, 22, 50, 1), width: 2)),
              color: Color.fromRGBO(34, 24, 64, 1)),
          child: ListTile(
            title: Text('Playlists',
                style: TextStyle(
                    color: Color.fromRGBO(0, 167, 255, 1),
                    fontSize: 22,
                    fontWeight: FontWeight.w500)),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Color.fromRGBO(131, 138, 176, 1)),
            onTap: () {
              Navigator.of(context).pushNamed('micoleccion');
            },
          ),
        ),
      ],
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isWindows) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('New Band'),
          content: TextField(controller: textController),
          actions: <Widget>[
            MaterialButton(
                child: Text('add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text))
          ],
        ),
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
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
      ),
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.socket.emit('new-band', {'name': name});
    }

    Navigator.pop(context);
  }

  Widget _showGaph() {
    Map<String, double> dataMap = new Map();
    //"Flutter": 5,
    bands.forEach((band) {
      dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
    });

    return Container(
      padding: EdgeInsets.only(bottom: 15),
        width: double.infinity, 
        height: 200, 
        child: PieChart(dataMap: dataMap));
  }
}
