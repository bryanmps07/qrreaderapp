import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:qrreaderapp/src/models/scan_model.dart';


class MapaPage extends StatelessWidget {

  final map = new MapController();

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
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(scan)
    );
  }

  Widget _crearFlutterMap( ScanModel scan ) {

    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores( scan )
      ],
    );

  }

  _crearMapa() {

    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {
        'accessToken':'pk.eyJ1IjoiYnJ5YW5tcHMwNyIsImEiOiJja2I2eWEyeXMwMGkyMnRucXpqaXBobTJuIn0.u2cxv6LYE9Q65OIHjDAgmg',
        'id': 'mapbox/streets-v11' 
        //streets-v11, outdoors-v11, light-v10, satellite-v9, satellite-streets-v11, dark-v10
        }
);


  }

  _crearMarcadores( ScanModel scan ) {


    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLatLng(),
          builder: ( context ) => Container(
            child: Icon( 
              Icons.location_on,
              size:  70.0,
              color: Theme.of(context).primaryColor,
            ),
          )
        )
      ]
    );

  }

}
