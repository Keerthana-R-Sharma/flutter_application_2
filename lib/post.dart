class Post {
  final String content;
  final String topic;
  final List<String> supportComments;
  final List<String> oppositionComments;

  Post(this.content, this.topic)
      : supportComments = [],
        oppositionComments = [];
}
