import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus{
  OnLine,
  OffLine,
  Connecting
}

class SocketService  with ChangeNotifier{
  
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

 ServerStatus get serverStatus => this._serverStatus;
 IO.Socket get socket => this._socket;

  SocketService(){
     this._initConfig();
  }

  void _initConfig(){
    this._socket = IO.io('http://172.16.20.23:3000/', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
   this._socket.on('connect', (_) { 
      print('conectado');
     this._serverStatus = ServerStatus.OnLine;   
     notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      print('desconectado');
     this._serverStatus = ServerStatus.OffLine;   
     notifyListeners();
    });

    // socket.on('nuevo-mensaje', ( payload ) {
    //   print('nuevo-mensaje: $payload');
    //   print(payload['nombre']);
    //  print(payload['mensaje']);
    //  notifyListeners();
    // });

  }
}