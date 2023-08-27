import 'package:tmdb_demo/entity/movie_entity.dart';

class ActorDetailEntity {
  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  String? birthday;
  String? deathday;
  int? gender;
  String? homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  double? popularity;
  String? profilePath;
  MovieCredits? movieCredits;

  ActorDetailEntity(
      {this.adult,
      this.alsoKnownAs,
      this.biography,
      this.birthday,
      this.deathday,
      this.gender,
      this.homepage,
      this.id,
      this.imdbId,
      this.knownForDepartment,
      this.name,
      this.placeOfBirth,
      this.popularity,
      this.profilePath,
      this.movieCredits});

  ActorDetailEntity.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    alsoKnownAs = json['also_known_as'].cast<String>();
    biography = json['biography'];
    birthday = json['birthday'];
    deathday = json['deathday'];
    gender = json['gender'];
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    placeOfBirth = json['place_of_birth'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    movieCredits = json['movie_credits'] != null ? MovieCredits.fromJson(json['movie_credits']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['also_known_as'] = alsoKnownAs;
    data['biography'] = biography;
    data['birthday'] = birthday;
    data['deathday'] = deathday;
    data['gender'] = gender;
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['place_of_birth'] = placeOfBirth;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    if (movieCredits != null) {
      data['movie_credits'] = movieCredits!.toJson();
    }
    return data;
  }
}

class MovieCredits {
  List<MovieEntity>? cast;
  List<Crew>? crew;

  MovieCredits({this.cast, this.crew});

  MovieCredits.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      cast = <MovieEntity>[];
      json['cast'].forEach((v) {
        cast!.add(MovieEntity.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crew = <Crew>[];
      json['crew'].forEach((v) {
        crew!.add(Crew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cast != null) {
      data['cast'] = cast!.map((v) => v.toJson()).toList();
    }
    if (crew != null) {
      data['crew'] = crew!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Crew {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? creditId;
  String? department;
  String? job;

  Crew(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.creditId,
      this.department,
      this.job});

  Crew.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    creditId = json['credit_id'];
    department = json['department'];
    job = json['job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['credit_id'] = creditId;
    data['department'] = department;
    data['job'] = job;
    return data;
  }
}
