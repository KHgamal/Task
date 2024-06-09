import '../../domain/entities/repository.dart';

class RepositoryModel extends Repository {
  RepositoryModel({
    required super.name,
    required super.description,
    required super.owner,
    required super.isFork,
    required super.repoUrl,
    required super.ownerUrl,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'],
      description: json['description'] ?? '',
      owner: json['owner']['login'],
      isFork: json['fork'] ?? false,
      repoUrl: json['html_url'],
      ownerUrl: json['owner']['html_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'owner': owner,
      'isFork': isFork,
      'repoUrl': repoUrl,
      'ownerUrl': ownerUrl,
    };
  }
}
