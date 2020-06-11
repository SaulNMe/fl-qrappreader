import 'package:flutter/material.dart';
import 'package:qrappreader/src/bloc/scans_bloc.dart';
import 'package:qrappreader/src/models/scan_model.dart';
import 'package:qrappreader/src/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {
  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {

    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scanStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final scans = snapshot.data;
        if(scans.length == 0) {
          return Center(child: Text('No hay información'),);
        } 
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.grey,),
            onDismissed: (dir) => {
              scansBloc.borrarScan(scans[index].id)
            },
            child: ListTile(
              onTap: (){ utils.abrirScan(context,scans[index]);},
              leading: Icon(Icons.map, color:  Theme.of(context).primaryColor,),
              title: Text(scans[index].valor),
              subtitle: Text('ID: ${scans[index].id}'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
            ),
          );
         },
        );
      },
    );
  }
}