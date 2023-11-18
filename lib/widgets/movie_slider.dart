import 'widgets.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider() : super(key: null);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context, listen: true);

    if (movieProvider.onDisplayMovies.isEmpty) {
      return const SizedBox(
        width: double.infinity,
        height: 260,
        // color: Colors.red,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 260,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populars',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieProvider.popularMovies.length,
              itemBuilder: (_, int index) => MoviePoster(
                movie: movieProvider.popularMovies[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}
