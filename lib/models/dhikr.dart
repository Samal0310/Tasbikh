import 'package:hive_flutter/hive_flutter.dart';

class Dhikr {
  int counter;
  String title;
  DateTime date;

  Dhikr({
    required this.counter,
    required this.title,
    required this.date,
  });
}

class DhikrAdapter extends TypeAdapter<Dhikr> {
  @override
  final typeId = 0;

  @override
  Dhikr read(BinaryReader reader) {
    return Dhikr(
      counter: reader.readInt(),
      title: reader.readString(),
      date: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, Dhikr obj) {
    writer.writeInt(obj.counter);
    writer.writeString(obj.title);
    writer.writeInt(obj.date.millisecondsSinceEpoch);
  }
}

// List<Dhikr> fakeDB = [];
