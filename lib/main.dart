import 'package:flutter/material.dart';
import 'package:list_app/repository/post_repository.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  void _onTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Inbox'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ],
          currentIndex: _selectedIndex,
          onTap: _onTapped,
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {}, child: const Text('get notification')),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: ((context, index) => ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InformationPage()),
                            );
                          },
                          child: Text(
                            "hi",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MainApp()));
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
              child: FutureBuilder(
                  future: PostRepository.getPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                      // do something till waiting for data, we can show here a loader
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => DetailsPage(
                                          postId: snapshot.data![index].id))));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Text(
                                  snapshot.data![index].title.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      );
                      // we have the data, do stuff here
                    } else {
                      return const Text('no data');
                      // we did not recieve any data, maybe show error or no data available
                    }
                  })),
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  int postId;

  DetailsPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InformationPage())),
        ),
      ),
      body: FutureBuilder(
          future: PostRepository.getPost(postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Card(
                child: Column(
                  children: [
                    Text(
                      snapshot.data!.title.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      snapshot.data!.body.toString(),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('no data');
            }
          }),
    );
  }
}
