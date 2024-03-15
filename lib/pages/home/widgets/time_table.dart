import 'dart:convert';
import 'package:app_button/models/Cartoons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  List<Cartoons>? _cartoons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            var dio = Dio(BaseOptions(responseType: ResponseType.plain));
            var response =
                await dio.get('https://api.sampleapis.com/cartoons/cartoons2D');
            print('Status code: ${response.statusCode}');
            response.headers.forEach((title, values) {
              print('$title: $title');
            });
            print(response.data.toString());

            setState(() {
              List list = jsonDecode(response.data.toString());

              _cartoons = list.map((item) => Cartoons.fromJson(item)).toList();

              // for (var i = 0; i < list.length; i++) {
              //   var map = list![i];
              //   var name = map['name'];
              //   var capital = map['capital'];
              //   var flag = map['media']['flag'];
              //   var population = map['population'];

              //   var country = Country(
              //     name: name,
              //     capital: capital,
              //     population: population,
              //     flag: flag,
              //   );
              //   _countries!.add(country);
              // }
            });
          },
          child: Text('Test API'),
        ),
        Expanded(
          child: _cartoons == null
              ? SizedBox.shrink()
              : ListView.builder(
                  itemCount: _cartoons!.length,
                  itemBuilder: (context, index) {
                    var Cartoons = _cartoons![index];

                    return ListTile(
                      title: Text(Cartoons.title ?? ''),
                      subtitle: Text(
                          'episodes: ' + Cartoons.episodes.toString() ?? ''),
                      trailing: Cartoons.image == ''
                          ? null
                          : Image.network(
                              Cartoons.image ?? '',
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error, color: Colors.red);
                              },
                            ),
                      onTap: () {
                        _showMyDialog(
                          Cartoons.title ?? '',
                          Cartoons.creator ?? [],
                          Cartoons.genre ?? [],
                          Cartoons.episodes ?? 0,
                          Cartoons.image ?? '',
                          Cartoons.runtime_in_minutes ?? 0
                          
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
  Future<void> _showMyDialog(String title,  List creator,List genre,int episodes, String image, int runtime_in_minutes) async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('All episodes: ' + episodes.toString()),
                Text('Runtime_in_minutes: ' + runtime_in_minutes.toString()),
                Text('Creator: ' + creator.toString()),
                Text('Genre: ' + genre.toString()),
                image.isNotEmpty ? Image.network(
                  image,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, color: Colors.red);
                  },
                )
                : Text('No image available'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}
