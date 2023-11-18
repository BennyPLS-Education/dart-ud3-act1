import 'widgets.dart';

class MovieSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.search(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data as List<Movie>;

          if (movies.isEmpty) {
            return const Center(
              child: Text('No hi ha resultats'),
            );
          }

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: moviesProvider.popularMovies.length,
            itemBuilder: (_, int index) => MoviePoster(
              movie: movies[index],
            ),
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error_outline);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.search(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data as List<Movie>;

          if (movies.isEmpty) {
            return const Center(
              child: Text('No hi ha resultats'),
            );
          }

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: moviesProvider.popularMovies.length,
            itemBuilder: (_, int index) => MoviePoster(
              movie: movies[index],
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('No hi ha resultats'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
