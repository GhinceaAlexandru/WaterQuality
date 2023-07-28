class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];

  list.add(Question(
    "What is the main benefit of staying hydrated?",
    [
      Answer("Improved digestion", false),
      Answer("Enhanced cognitive function", false),
      Answer("Better temperature regulation", false),
      Answer("Overall well-being", true),
    ],
  ));

  list.add(Question(
    "Which bodily function does water help with?",
    [
      Answer("Blood circulation", true),
      Answer("Muscle growth", false),
      Answer("Bone density", false),
      Answer("Skin elasticity", false),
    ],
  ));

  list.add(Question(
    "What is the role of water in nutrient absorption?",
    [
      Answer("Provides energy", false),
      Answer("Aids in digestion", true),
      Answer("Regulates hormone production", false),
      Answer("Builds muscle mass", false),
    ],
  ));

  list.add(Question(
    "How does water contribute to detoxification?",
    [
      Answer("Boosts immune system", false),
      Answer("Removes toxins from the body", true),
      Answer("Reduces inflammation", false),
      Answer("Stimulates cell regeneration", false),
    ],
  ));

  list.add(Question(
    "What is the optimal range of pH for drinking water?",
    [
      Answer("pH 4-6", false),
      Answer("pH 6-8", true),
      Answer("pH 8-10", false),
      Answer("pH 10-12", false),
    ],
  ));

  list.add(Question(
    "What does TDS stand for in water quality?",
    [
      Answer("Total Dissolved Substances", false),
      Answer("Total Dissolved Solids", true),
      Answer("Total Drinking Standards", false),
      Answer("Total Decomposed Solutes", false),
    ],
  ));

  list.add(Question(
    "Which range of TDS is generally considered optimal for drinking water?",
    [
      Answer("Less than 100 ppm", false),
      Answer("100-300 ppm", false),
      Answer("300-500 ppm", true),
      Answer("500-700 ppm", false),
    ],
  ));

  list.add(Question(
    "What does turbidity refer to in water quality?",
    [
      Answer("Temperature of the water", false),
      Answer("Clarity or haziness of the water", true),
      Answer("Taste of the water", false),
      Answer("pH level of the water", false),
    ],
  ));

  list.add(Question(
    "What is the recommended temperature range for drinking water?",
    [
      Answer("40°F - 50°F", false),
      Answer("50°F - 60°F", true),
      Answer("60°F - 70°F", false),
      Answer("70°F - 80°F", false),
    ],
  ));

  list.add(Question(
    "Which river in Romania is known for its exceptional water quality and natural beauty?",
    [
      Answer("Danube River", false),
      Answer("Jiu River", true),
      Answer("Olt River", false),
      Answer("Mures River", false),
    ],
  ));

  list.add(Question(
    "Which river in Romania is one of the cleanest rivers and flows through the Lotru Mountains?",
    [
      Answer("Moldova River", false),
      Answer("Jiu River", false),
      Answer("Siret River", false),
      Answer("Lotru River", true),
    ],
  ));

  list.add(Question(
    "What is the primary source of water pollution in rivers?",
    [
      Answer("Industrial waste", true),
      Answer("Agricultural runoff", false),
      Answer("Sewage discharge", false),
      Answer("Oil spills", false),
    ],
  ));

  list.add(Question(
    "Which river in Romania is famous for its stunning waterfalls and crystal-clear water?",
    [
      Answer("Timis River", false),
      Answer("Ialomita River", true),
      Answer("Argeș River", false),
      Answer("Prut River", false),
    ],
  ));

  return list;
}
