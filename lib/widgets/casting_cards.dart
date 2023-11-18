import 'widgets.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({required this.movieId}) : super(key: null);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: movieProvider.getCasting(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 200,
            // color: Colors.red,
            child: ListView.builder(
                itemCount: snapshot.data?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) =>
                    _CastCard(casting: snapshot.data![index])),
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error_outline);
        } else {
          return const Center(
              child: CircularProgressIndicator()
          );
        }
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast casting;

  const _CastCard({required this.casting}) : super(key: null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(casting.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            casting.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
