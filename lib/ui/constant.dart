import 'package:flutter/material.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

///基地址
const String kBaseUrl = 'https://api.themoviedb.org/3';

///图片展示基地址
const String kImageBaseUrl = 'https://image.tmdb.org/t/p/w500';

/// API访问令牌
const String kAccessToken =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZDliMTQ4MWJjYWYyNzdmNmYwMWRlYTNmZTAzZjE1NiIsInN1YiI6IjY0ZTgyNWFkZjJjZjI1MDEwMGY3OGRhMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.r--dmFt04g0n58Czglh6T500mAHCzfiD01HSa5WOMgI';
