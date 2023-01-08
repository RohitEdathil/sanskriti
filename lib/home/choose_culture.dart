import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanskriti/culture/culture_view.dart';
import 'package:sanskriti/utils/gradient_image_tile.dart';
import 'package:sanskriti/utils/image_builder.dart';

class ChooseCultureScreen extends StatefulWidget {
  const ChooseCultureScreen({super.key});

  @override
  State<ChooseCultureScreen> createState() => _ChooseCultureScreenState();
}

class _ChooseCultureScreenState extends State<ChooseCultureScreen> {
  DataSnapshot? data;

  Future<void> _loadCultures() async {
    final result =
        await FirebaseDatabase.instance.ref().child('cultures').once();

    data = result.snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Choose a culture'),
        ),
        body: FutureBuilder(
          future: _loadCultures(),
          builder: (ctx, snap) {
            if (data == null) {
              return const Center(
                  child: SpinKitSpinningLines(color: Colors.white));
            }

            return SingleChildScrollView(
              child: Column(children: [
                for (var culture in data!.children)
                  GradientTile(
                      imageUrl: culture.child('image').value as String,
                      title: culture.child('name').value as String,
                      onTap: (() => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => CultureView(
                                data: culture,
                              ),
                            ),
                          )))
              ]),
            );
          },
        ));
  }
}
