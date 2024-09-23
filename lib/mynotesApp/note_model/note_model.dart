import 'dart:math';

class Note {
  String id;
  String title;
  String note;
  int color;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note(
      {required this.createdAt,
      required this.updatedAt,
      required this.note,
      this.color = 0xFFFFFFFF,
      required this.id,
      required this.title});
}

int generateRandomLightColor() {
  Random random = Random();
  int red = 200 + random.nextInt(56);
  int blue = 200 + random.nextInt(56);
  int green = 200 + random.nextInt(56);
  return (0xFF << 24) | (red << 16) | (green << 8) | blue;
}
