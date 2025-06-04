import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando...',
      'Comprando palomitas...',
      'Llamando a mi novia...',
      'Estamos trabajando en ello...',
      'Ya mero...',
      'Esto también puede tardar... :('
    ];

    return Stream.periodic(
      const Duration(milliseconds: 1200),
      (step) => messages[step],
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(height: 10),
          // Text(
          //   'Cargando...',
          //   style: Theme.of(context).textTheme.titleMedium,
          // ),
          StreamBuilder(
            stream: getLoadingMessages(), 
            builder: (context, snapshot) {

              if (!snapshot.hasData) return const Text('Cargando...');

              return Text(
                snapshot.data!,
                style: Theme.of(context).textTheme.bodyMedium,
              ); 
            }
          )
        ],
      ),
    );
  }
}
