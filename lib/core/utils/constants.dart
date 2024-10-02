class Constants {
  static String summarizePrompt(String summaryLength) => """
  Summarize this book like professionally wisely at $summaryLength length!
  Enlighten the main topic and message of the book!
  Give the response in a markdown format!
  """;
}

enum SummaryLength { short, medium, long }
