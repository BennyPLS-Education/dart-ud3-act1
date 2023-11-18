import 'screens.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate {
    return '$day/$month/$year';
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen() : super(key: null);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(movie: movie),
                _Overview(movie: movie),
                CastingCards(movieId: movie.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({required this.movie}) : super(key: null);

  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            movie.title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitile({required this.movie}) : super(key: null);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(movie.fullPosterPath),
              height: 150,
              width: 100,
            ),
          ),
          Column(
            children: [
              Text(
                movie.title,
                style: textTheme.headlineSmall,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                softWrap: true,
              ),
              Text(
                movie.originalTitle,
                style: textTheme.titleMedium,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                softWrap: true,
              ),
              movie.stars,
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview({required this.movie}) : super(key: null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Data de llançament :'),
              const SizedBox(width: 5),
              Text(movie.releaseDate?.formattedDate ?? 'No llençada'),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Sinopsi',
              style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          const SizedBox(height: 5),
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
