import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/config/domain/entities/movie.dart';
import 'package:cinemapedia_app/config/helpers/human_formats.dart';
import 'package:cinemapedia_app/config/theme/theme_context.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallbackAction? loadNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    if(widget.loadNextPage != null) return;
    
    if( (scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent) {
      
      widget.loadNextPage!;
      
    }
   
    
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

          if (widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle),

          const SizedBox(
            height: 10,
          ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _Slide(movie: widget.movies[index]),
            ),
            
          ),
        ]));
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyle = getTextTheme(context);  

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

          //imagen
          SizedBox(
            width: 160,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) {

                    if (loadingProgress != null){
                       return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                    }
                    
                    return FadeIn(child: child);
                    //return child;
                  },
                  width: 130,
                  height: 250,
                  fit: BoxFit.cover,
                )),
          ),

          const SizedBox(
            height: 5,
          ),


          //titulo
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,              
              style: textStyle.titleSmall,
            ),
          ),
          
          const SizedBox(
            height: 5,
          ),

          //rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
                const SizedBox(width: 3),
                Text(
                  '${movie.voteAverage}',
                  style: textStyle.bodyMedium?.copyWith(
                    color: Colors.yellow.shade800,
                  ),
                ),
                
                const Spacer(),
                Text(
                  HumanFormats.number(movie.popularity),
                  style: textStyle.bodySmall,
                ),
                const SizedBox(width: 3),
                const Text('K')
                
              ]
            ),
          )



        ]));
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = getTextTheme(context);

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title ?? 'Sin título',
              style: titleStyle.titleLarge,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subTitle ?? 'Ver todo')),
        ],
      ),
    );
  }
}
