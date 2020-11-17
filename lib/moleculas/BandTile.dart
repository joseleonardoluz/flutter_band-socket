import 'package:band_names/models/band.dart';
import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BandTile extends StatelessWidget {
  const BandTile({
    @required this.context,
    @required this.band,
  });

  final BuildContext context;
  final Band band;

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context, listen: false);
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) =>
          socketService.socket.emit('delete-band', {'id': band.id}),
      background: Container(
        padding: EdgeInsets.only(right: 8.0),
        color: Colors.red,
        child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Eliminar',
              style: TextStyle(color: Colors.white),
            )),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color.fromRGBO(27, 22, 50, 1), width: 2)),
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
              //subtitle: Text(band.episodio+' | '+band.fecha+ ' | ' +band.duration),
              trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
              // trailing: Container(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Container(
              //         width: 5,
              //         height: 5,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: Color.fromRGBO(131, 138, 179, 1),
              //         ),
              //       ),

              //       Container(
              //         margin: EdgeInsets.only(top: 2, bottom: 2),
              //         width: 5,
              //         height: 5,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: Color.fromRGBO(131, 138, 179, 1),
              //         ),
              //       ),
              //       Container(
              //         width: 5,
              //         height: 5,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: Color.fromRGBO(131, 138, 179, 1),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              onTap: () =>
                  socketService.socket.emit('vote-band', {'id': band.id}),
            ),
          ),
        ],
      ),
    );
  }
}
