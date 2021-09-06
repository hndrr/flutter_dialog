import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import 'next_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'google_ml_kit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  List<Face>? faces;
  List<Map<String, int>> faceMaps = [];
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // ignore: avoid_print
        print('No image selected.');
      }
    });
  }

  Future<void> getAlbum() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // ignore: avoid_print
        print('No image selected.');
      }
    });
  }

  Future<void> launchCamera() async {
    final file = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(file?.path ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    // for (final face in faces!) {
    //   final x = face.boundingBox.left.toInt();
    //   final y = face.boundingBox.top.toInt();
    //   final w = face.boundingBox.width.toInt();
    //   final h = face.boundingBox.height.toInt();
    //   final thisMap = <String, int>{
    //     'x': x,
    //     'y': y,
    //     'w': w,
    //     'h': h,
    //   };
    //   faceMaps.add(thisMap);
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter dialog'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _image == null
                ? const Text('No image selected.')
                : Stack(children: [
                    Image.file(_image!),
                    // if (faceMaps != null)
                    //   Positioned(
                    //     left: faceMaps[0]['x']!.toDouble(),
                    //     top: faceMaps[0]['y']!.toDouble(),
                    //     child: Container(
                    //       width: faceMaps[0]['w']!.toDouble(),
                    //       height: faceMaps[0]['h']!.toDouble(),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           width: 2,
                    //           color: Colors.blue,
                    //         ),
                    //       ),
                    //       child: Align(
                    //         alignment: Alignment.topLeft,
                    //         child: Container(
                    //           color: Colors.blue,
                    //           child: const Text(
                    //             'hourse -71%',
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                  ]),
            ElevatedButton(
              onPressed: launchCamera,
              child: const Text('Camera'),
              // () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => NextPage(false)),
              //   );
              // },
            ),
            if (_image != null)
              TextButton(
                onPressed: () async {
                  const options = FaceDetectorOptions(
                    mode: FaceDetectorMode.accurate,
                    enableLandmarks: true,
                    enableClassification: true,
                  );
                  final image = InputImage.fromFile(_image!);
                  final detector = GoogleMlKit.vision.faceDetector(options);

                  // print('faces ${faces!.length}');
                  //

                  setState(() async {
                    faces = await detector.processImage(image);
                  });

                  // });
                },
                child: const Text('顔認識する'),
              ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push<Widget>(
                  context,
                  MaterialPageRoute<Widget>(
                      builder: (context) => const NextPage(value: true)),
                );
              },
              child: const Text('遷移後dialog開く'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
