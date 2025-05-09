class FAQModel {
  String question;
  String answer;
  String id;

  FAQModel({
    this.question = "",
    this.answer = "",
    this.id = "",
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      question: json["question"] ?? "",
      answer: json["answer"] ?? "",
      id: json["_id"] ?? "",
    );
  }
}
