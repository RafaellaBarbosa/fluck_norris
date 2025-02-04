import 'package:fluck_norris/core/utils/string_extensions.dart';
import 'package:fluck_norris/data/models/jokes.dart';
import 'package:fluck_norris/data/repositories/joke_repositories.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/text_styles.dart';
import '../widgets/quote_widget.dart';

class JokePage extends StatefulWidget {
  const JokePage({
    super.key,
    required this.categorie,
    required this.joke,
  });

  final String categorie;
  final JokeModel joke;

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  final JokeRepositories jokeRepositories = JokeRepositories();
  bool isLoading = false;
  late JokeModel newJoke;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    newJoke = widget.joke;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.azulNoturno,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Categoria escolhida: ${widget.categorie.capitalize()}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 22,
          children: [
            Hero(
              tag: 'chuck',
              child: CircleAvatar(
                foregroundImage: AssetImage('assets/chuck.jpg'),
                radius: 80,
              ),
            ),
            getContent(newJoke.value!, isLoading, hasError)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.repeat_one,
          ),
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            try {
              newJoke =
                  await jokeRepositories.getJokesByCategory(widget.categorie);
              setState(() {
                isLoading = false;
              });
            } on Exception {
              setState(() {
                isLoading = false;
                hasError = true;
              });
            }
          }),
    );
  }
}

Widget getContent(String valor, bool isloading, bool hasError) {
  if (hasError) {
    return Text('Erro na busca da piada!', style: TextStyles.errorText);
  }
  if (isloading) {
    return CircularProgressIndicator();
  }
  return QuoteWidget(joke: valor);
}
