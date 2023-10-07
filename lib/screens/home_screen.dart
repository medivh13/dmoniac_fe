import 'package:flutter/material.dart';
import 'package:demoniac_fe/models/article.dart';
import 'package:demoniac_fe/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Article>> futureArticles = Future.value([]);

  TextEditingController userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: userIdController,
              decoration: InputDecoration(
                labelText: 'Masukkan user_id',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10), // Menambah jarak antara input field dan tombol
          ElevatedButton(
            onPressed: () {
              int userId = int.tryParse(userIdController.text) ?? 2;
              futureArticles = _apiService.getArticlesByUserId(userId);
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text('Dapatkan Data', style: TextStyle(fontSize: 16)),
            ),
          ),
          SizedBox(height: 10), // Menambah jarak antara tombol dan daftar artikel
          Expanded(
            child: FutureBuilder<List<Article>>(
              future: futureArticles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('Tidak ada data yang ditemukan.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Article article = snapshot.data![index];

                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text('User Name: ${article.userName}'),
                          subtitle: Text('Stadium: ${article.stadium.toString()}'),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Tanggal Pemeriksaan:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(article.createdAt),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
