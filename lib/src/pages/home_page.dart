import 'package:flutter/material.dart';
import 'package:qrappreader/src/bloc/scans_bloc.dart';
import 'package:qrappreader/src/models/scan_model.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'package:qrappreader/src/pages/direcciones_page.dart';
import 'package:qrappreader/src/pages/mapas_page.dart';
import 'package:qrappreader/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){
              scansBloc.borrarTodosScan();
            },
          )
        ],
      ),
      body: _setPage(currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {_scanQR(context);},
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context) async {
    ScanResult scanResult;
    String scannedData;

    try {
      scanResult = await BarcodeScanner.scan();
      scannedData = scanResult.rawContent.toString();
    } catch (e) {
      scannedData = null;
    }

    if(scannedData != null) {
      final scan = ScanModel(valor: scannedData);
      scansBloc.agregarScan(scan);

      utils.abrirScan(context, scan);
    }

  }

  Widget _setPage(int paginaActual) {
    switch (paginaActual) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default: return MapasPage();
    }
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Mapas")),
        BottomNavigationBarItem(icon: Icon(Icons.location_on), title: Text("Direcciones")),
      ],
    );
  }
}