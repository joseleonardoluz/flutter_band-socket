import 'package:band_names/labs/slideshow_page.dart';
import 'package:band_names/pages/miColeccion_page.dart';
import 'package:band_names/pages/playList_page.dart';
import 'package:band_names/pages/slideshow_page.dart';
import 'package:band_names/pages/status.dart';
import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
 
import 'package:band_names/pages/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ( _ ) => SocketService(),
            
            )
        ],

        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home'   : ( _ ) => HomePage(),
          'status' : ( _ ) => StatusPage(),
          'slideshow' : ( _ ) => SlideshowPage(),
          'playlist' : ( _ ) => PlayListPage(),
          'micoleccion' : ( _ ) => MiColeccionPage()
        },
      ),
    );
  }
}