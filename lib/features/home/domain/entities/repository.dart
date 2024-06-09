class Repository {
  final String name;
  final String description;
  final String owner;
  final bool isFork;
  final String repoUrl;
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
