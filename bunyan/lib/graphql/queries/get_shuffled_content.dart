const String getShuffledContent = r'''
query GetShuffledContent($eventLimit: Int, $jobLimit: Int, $postLimit: Int) {
  getShuffledContent(eventLimit: $eventLimit, jobLimit: $jobLimit, postLimit: $postLimit) {
    posts {
      id
      title
      mahallu {
        name
      }
      fileURL
      likes
      active
      description
      updatedAt
    }
    jobs {
      id
      title
      active
      description
      skills
      postedDate
      location
    }
    events {
      id
      active
      online
      posterURL
      startingDate
      title
      mahallu {
        id
        regNo
        name
      }
      location
      updatedAt
      description
    }
  }
}
''';
