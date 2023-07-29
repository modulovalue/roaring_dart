import '../ffi_impl.dart';

// To build dylib invoke:
//   * cc  -O3 -std=c11 -shared -o libroaring.dylib -fPIC roaring.c
// To build headers invoke:
//   * dart run ffigen --config config.yaml
// TODO add this to the header
// ignore_for_file: type=lint, unused_element, unused_field
void main() {
  print("=== Roaring Bitmap ===");
  _roaring();
  print("=== Roaring Bitset ===");
  _bitset();
}

void _roaring() {
  final factory = roaring_dart_factory;
  final bs = factory.create_roaring();
  bs.add(1);
  bs.add(3);
  bs.add(5);
  bs.add(6);
  // for (int i = 100; i < 1000; i++) bs.add(i);
  // print(bs.contains(500));
  print(bs.contains(0));
  print("Contains: " + [for (int i = 0; i < 6; i++) bs.contains(i)].toString());
  print("Select: " + [for (int i = 0; i < 6; i++) bs.select(i)].toString());
  print("Rank: " + [for (int i = 0; i < 6; i++) bs.rank(i)].toString());
  // TODO bulk iterator
  // TODO bulk add?
}

void _bitset() {
  final factory = roaring_dart_factory;
  final bs = factory.create_bitset();
  bs.add(1);
  bs.add(3);
  bs.add(5);
  bs.add(6);
  // for (int i = 100; i < 1000; i++) bs.add(i);
  // print(bs.contains(500));
  print(bs.contains(0));
  print("Contains: " + [for (int i = 0; i < 6; i++) bs.contains(i)].toString());
  // print("Select: " + [for (int i = 0; i < 6; i++) bs.select(i)].toString());
  print("All: " + bs.all_set().toString());
  // TODO bulk iterator
  // TODO bulk add?
}