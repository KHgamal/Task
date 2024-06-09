import 'package:hive/hive.dart';

part 'repository.g.dart';
@HiveType(typeId: 0)
class Repository {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String owner;
  @HiveField(3)
  final bool isFork;
  @HiveField(4)
  final String repoUrl;
  @HiveField(5)
  final String ownerUrl;

  Repository({
    required this.name,
    required this.description,
    required this.owner,
    required this.isFork,
    required this.repoUrl,
    required this.ownerUrl,
  });
}
