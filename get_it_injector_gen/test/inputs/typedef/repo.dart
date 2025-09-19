import 'repo_factory.dart';

class Repo {}

class RepoConsumer {
  const RepoConsumer({required this.repoFactory});

  final RepoFactory repoFactory;
}
