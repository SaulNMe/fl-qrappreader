import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrappreader/src/models/scan_model.dart';


class MapaDetailPage extends StatefulWidget {
  MapaDetailPage({Key key}) : super(key: key);

  @override
  _MapaDetailPageState createState() => _MapaDetailPageState();
}

class _MapaDetailPageState extends State<MapaDetailPage> {

  MapController mapController = new MapController();
  String tipoMapa = 'dark';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              mapController.move(scan.getLanLng(),15);

            },
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearFloating(context),
    );
  }

  Widget _crearFloating(BuildContext context) {
    
    return FloatingActionButton(
      child: Icon(Icons.layers),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if(tipoMapa == 'streets') {
          tipoMapa = 'dark';
        } else if(tipoMapa == 'dark') {
          tipoMapa = 'light';
        } else if(tipoMapa == 'light') {
          tipoMapa = 'outdoors';
        } else if(tipoMapa == 'outdoors') {
          tipoMapa = 'satellite';
        } else {
          tipoMapa = 'streets';
        }
        print(tipoMapa);
        setState((){});
      },
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLanLng(),
        zoom: 15
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate: "https://api.tiles.mapbox.com/v4/"
            "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
      additionalOptions: {
        'accessToken': '',
        'id': 'mapbox.$tipoMapa'
      }
    );
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLanLng(),
          builder: (BuildContext context) {
            return Container(
              child: Icon(
                Icons.location_on,
                size: 55.0,
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        )
      ]
    );
  }

}