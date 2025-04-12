import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/features/home/presentation/pages/cubits/articles_cubit/articles_cubit.dart';
import 'package:plant_app/features/home/presentation/widgets/article_card.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});
  static String id = "ArticlesPage";

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  void initState() {
    super.initState();
    context.read<ArticlesCubit>().fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Articles",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          if (state is ArticlesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ArticlesError) {
            return Center(child: Text(state.error));
          } else if (state is ArticlesSuccess) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                return ArticleCard(article: state.articles[index]);
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
