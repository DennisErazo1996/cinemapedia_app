
import 'package:flutter/material.dart';

ColorScheme getColorScheme( BuildContext context ) => Theme.of(context).colorScheme;
TextTheme getTextTheme( BuildContext context ) => Theme.of(context).textTheme;
Size getScreenSize( BuildContext context ) => MediaQuery.of(context).size;

