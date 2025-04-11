class Repo {}

typedef RepoFactory = Repo Function();

class RepoConsumer {
  const RepoConsumer({
    required this.repoFactory,
  });

  final RepoFactory repoFactory;
}
