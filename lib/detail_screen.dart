import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'tourism_place.dart';

class DetailScreen extends StatefulWidget {
  final int albumIdx ;

  const DetailScreen({Key? key, required this.albumIdx}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  bool toggle = false;

  Widget build(BuildContext context) {
    final TourismPlace tourism_place = tourismPlaceList[widget.albumIdx];
    return Scaffold(
        appBar: AppBar(
          title: Text(tourism_place.name),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                icon:
                toggle ? Icon(Icons.favorite_border) : Icon(Icons.favorite),
                onPressed: () {
                  setState(() {
                    toggle = !toggle;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async {
                    if (!await launch(tourism_place.imageAsset)
                    ) throw 'Could not launch ${tourism_place.imageAsset}';
                  }
              ),
            )
          ],
        ),
        body: ListView(children: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      tourism_place.name,
                      style:
                      TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Text("Tiket Masuk = ${tourism_place.ticketPrice}"),
                    Text("${tourism_place.location}"),
                    Text("${tourism_place.openDays} | ${tourism_place.openTime}"),
                    Text(tourism_place.description),
                    ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                color: Colors.lightBlue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text(
                          "# |",
                          style: TextStyle(color: Colors.white),
                        ),
                        title: Text(
                          "Gambar Lainnya",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                    child: SizedBox(height: 400, child: _build_tourismlist())),
              )
            ],
          )
        ]));
  }
  Widget _build_tourismlist() {
    TourismPlace tourism_place = tourismPlaceList[widget.albumIdx];
    return ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text("${index + 1} |"),
                        title: Text("${tourism_place.name}"),
                      ),
                      Image.network(tourism_place.imageUrls[index]),
                    ],
                  ),
                )
            ),
          );
        },
        itemCount: tourism_place.imageUrls.length);
  }
}