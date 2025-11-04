class ResponseModel{

  List<Candidate> candidate;

  ResponseModel({required this.candidate});
}

class Candidate{
  Content content;

  Candidate({required this.content});
}

class Content{
  Part part;

  Content({required this.part});
}

class Part{
  List<Text> text;

  Part({required this.text});
}

class  Text{
  String text;

  Text({required this.text});
}