import 'package:fluck_norris/core/utils/app_colors.dart';
import 'package:fluck_norris/core/utils/string_extensions.dart';
import 'package:fluck_norris/core/utils/text_styles.dart';
import 'package:fluck_norris/data/repositories/joke_repositories.dart';
import 'package:flutter/material.dart';

import '../widgets/loading_widget.dart';
import 'joke_page.dart';

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
      appBar: AppBar(
        backgroundColor: AppColors.azulNoturno,
        leading: Hero(
          tag: 'chuck',
          child: CircleAvatar(
            foregroundImage: AssetImage('assets/chuck.jpg'),
          ),
        ),
        title: Text(
          "Escolha a categoria",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
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
              return LoadingWidget(
                labelLoading: 'Carregando Categorias...',
              );
            case ConnectionState.active:
              return Text('Conectado');

            case ConnectionState.done:
              if (snapshot.hasData) {
                final categories = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                    itemCount: categories!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          final joke = await jokeRepositories
                              .getJokesByCategory(categories[index]);
                          if (context.mounted) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => JokePage(
                                categorie: categories[index],
                                joke: joke,
                              ),
                            ));
                          }
                        },
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: AppColors.azulProfundo,
                        title: Text(snapshot.data![index].capitalize(),
                            style: TextStyles.subTitleText),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text('${index + 1}',
                              style: TextStyles.subTitleText),
                        ),
                        dense: true,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.azulNoturno,
                        height: 8,
                      );
                    },
                  ),
                );
              } else {
                return Text(
                  'Sem dados',
                );
              }
          }
        },
      ),
    );
  }
}
