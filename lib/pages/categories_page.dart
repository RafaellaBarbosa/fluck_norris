import 'package:fluck_norris/repositories/joke_repositories.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final jokeRepositories = JokeRepositories();
  late Future<List<String>> futureCategories;
  @override
  void initState() {
    super.initState();
    futureCategories = jokeRepositories.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child:
                    Text('${snapshot.hasError} Erro ao carregar categorias'));
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text('Sem conexão'));
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return Text('Conectado');

            case ConnectionState.done:
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(title: Text(snapshot.data![index])),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
                );
              } else {
                return Text('Sem dados');
              }
          }
        },
      ),
    );
  }
}
