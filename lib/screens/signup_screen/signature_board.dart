import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
class SignatureBoard extends StatefulWidget {
  @override
  _SignatureBoardState createState() => _SignatureBoardState();
}

class _SignatureBoardState extends State<SignatureBoard> {

  File? imageFile;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
  }

  Future<Uint8List?> exportSignature()async{
    final exportController= SignatureController(penColor: Colors.black,penStrokeWidth: 2 , exportBackgroundColor: Colors.white,points: _controller.points);
    final signature= await exportController.toPngBytes();
    exportController.dispose();
    return signature;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,title: const Text("Signature Board"),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          //SIGNATURE CANVAS
          Expanded(
            flex: 4,
            child: Signature(
              controller: _controller,
              backgroundColor: Colors.white,
            ),
          ),
          //OK AND CLEAR BUTTONS
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //SHOW EXPORTED IMAGE IN NEW ROUTE
                  IconButton(
                    icon: const Icon(Icons.check),
                    color: Colors.blue,
                    onPressed: () async {
                      if  (_controller.isNotEmpty) {
                        final signature =await exportSignature();

                        if (signature != null) {

                          Uint8List imageInUnit8List = signature;
                          final tempDir = await getTemporaryDirectory();
                          File file = await File('${tempDir.path}/image.png').create();
                          file.writeAsBytesSync(imageInUnit8List);
                          setState(() {
                            imageFile= file;
                          });
                          Navigator.pop(context,file);


                        }

                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.undo),
                    color: Colors.blue,
                    onPressed: () {
                      setState(() => _controller.undo());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.redo),
                    color: Colors.blue,
                    onPressed: () {
                      setState(() => _controller.redo());
                    },
                  ),
                  //CLEAR CANVAS
                  IconButton(
                    icon: const Icon(Icons.clear),
                    color: Colors.blue,
                    onPressed: () {
                      setState(() => _controller.clear());
                    },
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );

  }





}