import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:list_app/models/post_model.dart';
import 'package:list_app/repository/post_repository.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: ((context, index) => ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InformationPage()),
                      );
                    },
                    child: Text(
                      "hi",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ))),
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
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
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
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Column(children: [
                              Text(snapshot.data![index].id.toString()),
                              Text(snapshot.data![index].title.toString()),
                              Text(snapshot.data![index].body.toString()),
                            ]),
                          ),
                        ),
                      );
                      // we have the data, do stuff here
                    } else {
                      return Text('no data');
                      // we did not recieve any data, maybe show error or no data available
                    }
                  })),
        ),
      ),
    );
  }
}

PostModel test = PostModel(
    userId: 1,
    id: 1,
    title: 'bryce is short',
    body: 'did i ever tell you about the time bryce was really short');
