abstract class RoaringBitmapFactory {
  RoaringBitmap create_roaring({
    final int? capacity,
  });

  RoaringBitset create_bitset({
    final int? capacity,
  });
}

abstract class RoaringBitmap {
  void add(
    final int value,
  );

  bool contains(
    final int value,
  );

  int select(
    final int value,
  );

  int? rank(
    final int value,
  );

  void debug_print();
}

abstract class RoaringBitset {
  void add(
    final int value,
  );

  bool contains(
    final int value,
  );

  void debug_print();

  Iterable<int> all_set();
}
