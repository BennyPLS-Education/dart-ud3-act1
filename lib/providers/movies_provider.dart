import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  final _baseUri = 'api.themoviedb.org';
  final _apiKey = '43e0e0b54b7b0fa8c3013adaed36d6ca';
  final _language = 'es-ES';
  final _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    _getPopular();
    _getOnDisplayMovies();
  }

  Future<List<Movie>> search(String query, {bool includeAdult = true}) async {
    var uri = Uri.https(_baseUri, '/3/search/movie', {
      "api_key": _apiKey,
      "language": _language,
      "query": query,
      "include_adult": includeAdult.toString(),
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return [];
    }

    return SearchResponse.fromJson(response.body).results;
  }

  Future<List<Cast>> getCasting(int movieId) async {
    if (casting.containsKey(movieId)) {
      return casting[movieId]!;
    }

    var uri = Uri.https(_baseUri, '/3/movie/$movieId/credits', {
      "api_key": _apiKey,
      "language": _language,
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return [];
    }

    casting[movieId] = CreditsResponse.fromJson(response.body).cast;

    return CreditsResponse.fromJson(response.body).cast;
  }

  void _getPopular() async {
    var uri = Uri.https(_baseUri, '/3/movie/popular', {
      "api_key": _apiKey,
      "language": _language,
      "page": _page,
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return;
    }

    popularMovies = PopularResponse.fromJson(response.body).results;

    notifyListeners();
  }

  void _getOnDisplayMovies() async {
    var uri = Uri.https(_baseUri, '/3/movie/now_playing', {
      "api_key": _apiKey,
      "language": _language,
      "page": _page,
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return;
    }

    onDisplayMovies = NowPlayingResponse.fromJson(response.body).results;

    notifyListeners();
  }
}
