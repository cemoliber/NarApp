//this page includes our question model

class Question {
  final String id;

  final String title;

  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
  });

  @override
  String toString() {
    return 'Questions(id:$id,title:$title,options:$options)';
  }
}
