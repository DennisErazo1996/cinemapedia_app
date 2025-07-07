import 'package:cinemapedia_app/config/theme/theme_context.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = getColorScheme(context);
    final titleStyle = getTextTheme(context);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [

              Icon(Icons.movie_outlined, color: colors.primary, size: 30,),

              const SizedBox(width: 5,),

              Text('Cinemapedia', style: titleStyle.titleMedium,),
              
              const Spacer(),
              
              IconButton(
                onPressed: (){}, 
                icon: Icon(Icons.search, color: colors.primary,)
              )
            ],
          ),
        )
      )
      );
  }
}