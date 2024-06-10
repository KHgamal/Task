import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../../core/constants/constants.dart';
import '../../../../core/error/failure.dart';
import '../models/repository_model.dart';


abstract class RepositoryRemoteDataSource {
  Future<List<RepositoryModel>> fetchRepositories(int page, int perPage);
}

class RepositoryRemoteDataSourceImpl implements RepositoryRemoteDataSource {
  static const String _baseUrl = 'https://api.github.com/users/square/repos';

  @override
  Future<List<RepositoryModel>> fetchRepositories(int page, int perPage) async {
    final response = await http.get(Uri.parse('$_baseUrl?page=$page&per_page=$perPage'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
    //  var box =Hive.box(kHiveBoxname);
    // box.addAll(values)
      return jsonData.map((json) => RepositoryModel.fromJson(json)).toList();
    } else {
      throw ServerFailure('Failed to load repositories');
    }
  }
}
