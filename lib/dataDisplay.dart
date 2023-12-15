import 'package:flutter/material.dart';
import 'apiModel.dart';

class dataDisplay extends StatelessWidget {
  final ApiModel apiData;

  dataDisplay({required this.apiData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Public APIs',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 121, 191),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.cyan.shade100,
        ),
        body: Container(
          color: Colors.cyan.shade100,
          child: ListView.builder(
            itemCount: apiData.entries.length,
            itemBuilder: (context, index) {
              Entry entry = apiData.entries[index];
              return Card(
                color: Color.fromARGB(255, 0, 121, 191),
                margin: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _showDetails(context, entry);
                  },
                  child: ListTile(
                    title: Text(
                      entry.api,
                      style: TextStyle(
                        color: Colors.cyan.shade100,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category: ${entry.category}',
                          style: TextStyle(
                            color: Colors.cyan.shade100,
                          ),
                        ),
                        Text(
                          'Description: ${entry.description}',
                          style: TextStyle(
                            color: Colors.cyan.shade100,
                          ),
                        ),
                        Text(
                          'HTTPS: ${entry.https ? 'Yes' : 'No'}',
                          style: TextStyle(
                            color: Colors.cyan.shade100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  void _showDetails(BuildContext context, Entry entry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EntryDetailsPage(entry: entry),
      ),
    );
  }
}

class EntryDetailsPage extends StatelessWidget {
  final Entry entry;

  const EntryDetailsPage({required this.entry});

  @override
  Widget build(BuildContext context) {
    String apiName = entry.api;
    String imageUrl;

    if (apiName == 'AdoptAPet') {
      imageUrl =
          'https://images.ctfassets.net/sfnkq8lmu5d7/1NaIFGyBn0qwXYlNaCJSEl/ad59ce5eefa3c2322b696778185cc749/2021_0825_Kitten_Health.jpg?w=1000&h=750&q=70&fm=webp';
    } else if (apiName == 'Axolotl') {
      imageUrl = 'https://promova.com/content/wild_animals_name_0075f4c56a.png';
    } else {
      imageUrl = "";
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${entry.api} API',
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 121, 191),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.cyan.shade100,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                imageUrl,
                height: 180,
              ),
              SizedBox(height: 16),
              Text('Description: ${entry.description}'),
              Text('Auth: ${entry.auth}'),
              Text('HTTPS: ${entry.https ? 'Yes' : 'No'}'),
              Text('Category: ${entry.category}'),
              Text('Cors: ${entry.cors}'),
              Text('Link: ${entry.link}'),
            ],
          ),
        ),
        backgroundColor: Colors.cyan.shade100,
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color.fromARGB(255, 0, 121, 191)),
              ),
              child: Text(
                'Back to API List',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 121, 191),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )));
  }
}
