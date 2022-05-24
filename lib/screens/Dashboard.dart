import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/ProductsModel.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardAppState createState() => _DashboardAppState();
}

class _DashboardAppState extends State<Dashboard> {
  Future<List<ProductsModel>>? loadedData;

  Future<List<ProductsModel>> _getElectronics() async {
    var url = "https://fakestoreapi.com/products";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // success
      List decodedResponse = json.decode(response.body);

      // var d=decodedResponse.map((data) => ProductsModel.fromJson(data)).toList();
      print(decodedResponse[1]);
      return decodedResponse
          .map((data) => ProductsModel.fromJson(data))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    loadedData = _getElectronics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductsModel>>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error " + snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    //height: 1
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Image.network(snapshot.data![index].image!),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Name : " + snapshot.data![index].title!,
                          style: const TextStyle(
                              fontSize: 12,
                              height: 2,
                              color: Colors.redAccent,
                              fontStyle: FontStyle.italic),
                        ),
                        Text(
                          "Price : ${snapshot.data![index].price!} ",
                          style: const TextStyle(
                              fontSize: 12,
                              height: 2,
                              color: Colors.redAccent,
                              fontStyle: FontStyle.italic),
                        ),
                        Text(
                          "category : " + snapshot.data![index].category!,
                          style: const TextStyle(
                              fontSize: 12,
                              height: 2,
                              color: Colors.redAccent,
                              fontStyle: FontStyle.italic),
                        ),
                        Text(
                          "description : " + snapshot.data![index].description!,
                          style: const TextStyle(
                              fontSize: 12,
                              height: 2,
                              color: Colors.redAccent,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: loadedData,
      ),
    );
  }
}
