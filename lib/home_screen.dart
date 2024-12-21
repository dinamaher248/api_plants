import 'package:flutter/material.dart';
import 'api_module.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> Data;

  @override
  void initState() {
    super.initState();
    Data = apiService.fetchData();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plants Data'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final flower = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(flower['common_name'] ?? 'Unknown'),
                    subtitle: Text(flower['scientific_name'] ?? 'Unknown'),
                    leading: flower['image_url'] != null
                        ? Image.network(
                            flower['image_url'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.local_florist),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No plants found'));
          }
        },
      ),
    );
  }
}
