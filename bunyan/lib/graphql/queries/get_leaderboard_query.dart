const String getLeaderboard = r'''
query GetLeaderboard($limit: Int, $offset: Int) {
  getLeaderboard(limit: $limit, offset: $offset) {
    id
    name
    place
    regNo
    totalPoints
    badges {
      name
      icon
    }
    badgesCount
    counts {
      events
      jobs
      otherPrograms
      posts
      taskParticipants
    }
  }
}
''';
