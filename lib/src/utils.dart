import 'dart:typed_data';

List<int> string2List(String s) => s.runes.toList();
Uint8List string2bytes(String s) => new Uint8List.fromList(s.runes.toList());
