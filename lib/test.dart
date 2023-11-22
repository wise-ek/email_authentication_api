import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'movies.dart';






class MovieSearchScreen extends StatefulWidget {
  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final apiKey = 'b944d6eba2d3f434fdb9d98457345ae8';
  final apiUrl = 'https://api.themoviedb.org/3/search/movie';
  final imageUrlPrefix = 'https://image.tmdb.org/t/p/w780';

  TextEditingController _searchController = TextEditingController();
  List<Movie> _movies = [];
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter movie title',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _searchMovies();
              },
              child: Text('Search'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  return ListTile(
                    title: Text(movie.title),
                    leading: SizedBox(
                      height: 100,
                        width: 100,
                        child: Image.network(movie.imageUrl)),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            _buildPagination(),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            _loadPage(_currentPage - 1);
          },
          child: Text('Previous'),
        ),
        SizedBox(width: 16.0),
        Text('Page $_currentPage'),
        SizedBox(width: 16.0),
        ElevatedButton(
          onPressed: () {
            _loadPage(_currentPage + 1);
          },
          child: Text('Next'),
        ),
      ],
    );
  }

  Future<void> _searchMovies() async {
    final query = _searchController.text;
    print(apiUrl+"main api url");
    print(apiKey+"main api key");
    print(_currentPage.toString()+"_currentPage");
    final response = await http.get(Uri.parse('$apiUrl?api_key=$apiKey&query=$query&page=$_currentPage'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Movie> movies = [];

      for (var result in data['results']) {
        final title = result['title'];
        final imageUrl = '$imageUrlPrefix${result['poster_path']}';
        final movie = Movie(title: title, imageUrl: imageUrl);
        movies.add(movie);
      }

      setState(() {
        _movies = movies;
      });
    } else {
      // Handle error
      print('Failed to load movies');
    }
  }

  void _loadPage(int page) {
    if (page > 0) {
      setState(() {
        _currentPage = page;
      });
      _searchMovies();
    }
  }
}
