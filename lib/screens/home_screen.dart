import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen() : super(key: null);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MovieSearch());
            },
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            const MovieSlider(),
          ],
        ),
      ),
    );
  }
}
