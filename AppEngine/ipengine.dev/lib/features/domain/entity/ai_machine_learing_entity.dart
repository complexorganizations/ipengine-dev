class AiMachineLearningEntity {
  final String title;
  final String description;
  AiMachineLearningEntity({this.title, this.description});

  static List<AiMachineLearningEntity> buildingBlocksData = [
    AiMachineLearningEntity(
        title: "AI building blocks",
        description:
            "Easily infuse AI into Applications with custom or pre-triend models"),
    AiMachineLearningEntity(
        title: "AutoML",
        description: "Custom machine learning model training and development"),
    AiMachineLearningEntity(
        title: "Vision AI",
        description:
            "Custom and pre-trained models to detect emotion,text,more"),
    AiMachineLearningEntity(
        title: "Video AI",
        description:
            "Video classification recognition using machine learning."),
    AiMachineLearningEntity(
        title: "Cloud Natural Language",
        description:
            "Sentiment analysis and classification of unstructured text."),
    AiMachineLearningEntity(
        title: "Cloud Translation",
        description: "language detection, translation, and glossary support."),
    AiMachineLearningEntity(
        title: "Media Translation (beta)",
        description:
            "Add dynamic audio translation directly to your content and applications."),
    AiMachineLearningEntity(
        title: "Text-to-Speech",
        description: "Speech syntensis in 220+ voices and 40+ languages"),
    AiMachineLearningEntity(
        title: "Dialogflow",
        description: "Speech syntensis in 220+ voices and 40+ languages"),
    AiMachineLearningEntity(
        title: "AutoML Tables (beta)",
        description: "Speech syntensis in 220+ voices and 40+ languages"),
    AiMachineLearningEntity(
        title: "Cloud Inference API (alpha)",
        description: "Speech syntensis in 220+ voices and 40+ languages"),
    AiMachineLearningEntity(
        title: "Recommendations AI (beta)",
        description: "Speech syntensis in 220+ voices and 40+ languages"),
  ];
  static List<AiMachineLearningEntity> infrastructureData = [
    AiMachineLearningEntity(
        title: "AI Infrastructure",
        description:
            "Easily infuse AI into Applications with custom or pre-triend models"),
    AiMachineLearningEntity(
        title: "Cloud GPUs",
        description:
            "Custom and pre-trained models to detect emotion,text,more"),
    AiMachineLearningEntity(
        title: "Cloud TPU",
        description:
            "Video classification recognition using machine learning."),
  ];
  static List<AiMachineLearningEntity> platformData = [
    AiMachineLearningEntity(
        title: "AI Platform",
        description:
            "Easily infuse AI into Applications with custom or pre-triend models"),
    AiMachineLearningEntity(
        title: "AI Platform Deep Learning VM Image",
        description:
            "Custom and pre-trained models to detect emotion,text,more"),
    AiMachineLearningEntity(
        title: "AI Platform Notebooks",
        description:
            "Video classification recognition using machine learning."),
  ];
}
