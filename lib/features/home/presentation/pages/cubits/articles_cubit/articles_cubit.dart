import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:plant_app/models/article_model.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit() : super(ArticlesInitial());

  final CollectionReference articlesCollection =
      FirebaseFirestore.instance.collection('articles');

  void fetchArticles() async {
    try {
      emit(ArticlesLoading());

      final snapshot = await articlesCollection.get();

      final articles = snapshot.docs
          .map((doc) =>
              ArticleModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      emit(ArticlesSuccess(articles));
    } catch (e) {
      emit(ArticlesError("Failed to load articles: $e"));
    }
  }
}
