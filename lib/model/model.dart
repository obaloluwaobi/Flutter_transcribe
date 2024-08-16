import 'package:hive/hive.dart';

part "model.g.dart";

@HiveType(typeId: 1)
class TranscribeModel {
  @HiveField(0)
  String words;
  @HiveField(1)
  String translate;

  TranscribeModel({
    required this.words,
    required this.translate,
  });
}
