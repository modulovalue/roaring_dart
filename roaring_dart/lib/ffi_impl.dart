import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'generated_bindings.dart';
import 'interface.dart';

void main() {
  print(
    ffi.DynamicLibrary.open(
      "/Users/modulovalue/Desktop/flutter_mindmap/pkgs/flutter_companion/ziz/roaring_dart/lib/meta/libroaring.dylib",
    ).providesSymbol("bitset_set"),
  );
}

// TODO have a js impl eventually.
final RoaringBitmapFactory roaring_dart_factory = RoaringBitmapFactoryImpl(
  bindings: DartRoaringBitmaps(
    ffi.DynamicLibrary.open(
      "/Users/modulovalue/Desktop/flutter_mindmap/pkgs/flutter_companion/ziz/roaring_dart/lib/meta/libroaring.dylib",
    ),
  ),
);

class RoaringBitmapFactoryImpl implements RoaringBitmapFactory {
  final DartRoaringBitmaps bindings;

  const RoaringBitmapFactoryImpl({
    required this.bindings,
  });

  @override
  RoaringBitmap create_roaring({
    final int? capacity,
  }) {
    return RoaringBitmapImpl(
      bitmap: bindings.roaring_bitmap_create_with_capacity(
        capacity ?? 0,
      ),
      bindings: bindings,
    );
  }

  @override
  RoaringBitset create_bitset({
    final int? capacity,
  }) {
    return RoaringBitsetImpl(
      bitmap: bindings.bitset_create_with_capacity(
        capacity ?? 0,
      ),
      bindings: bindings,
    );
  }
}

class RoaringBitmapImpl implements RoaringBitmap {
  final ffi.Pointer<roaring_bitmap_t> bitmap;
  final DartRoaringBitmaps bindings;

  RoaringBitmapImpl({
    required this.bitmap,
    required this.bindings,
  }) {
    Finalizer(
      (final _) => bindings.roaring_bitmap_free(
        bitmap,
      ),
    ).attach(
      this,
      null,
    );
  }

  @override
  void add(
    final int value,
  ) {
    bindings.roaring_bitmap_add(
      bitmap,
      value,
    );
  }

  @override
  bool contains(
    final int value,
  ) {
    return bindings.roaring_bitmap_contains(
      bitmap,
      value,
    );
  }

  @override
  int select(
    final int value,
  ) {
    return bindings.roaring_bitmap_rank(
      bitmap,
      value,
    );
  }

  @override
  void debug_print() {
    bindings.roaring_bitmap_printf(
      bitmap,
    );
  }

  static final _rank_out = malloc.allocate<ffi.Uint32>(
    ffi.sizeOf<ffi.Uint32>(),
  );

  @override
  int? rank(
    final int value,
  ) {
    if (bindings.roaring_bitmap_select(
      bitmap,
      value,
      _rank_out,
    )) {
      return _rank_out.value;
    } else {
      return null;
    }
  }
}

class RoaringBitsetImpl implements RoaringBitset {
  final ffi.Pointer<bitset_t> bitmap;
  final DartRoaringBitmaps bindings;

  RoaringBitsetImpl({
    required this.bitmap,
    required this.bindings,
  }) {
    Finalizer(
      (final _) => bindings.bitset_free(
        bitmap,
      ),
    ).attach(
      this,
      null,
    );
  }

  @override
  void add(
    final int value,
  ) {
    bindings.bitset_set(
      bitmap,
      value,
    );
  }

  @override
  bool contains(
    final int value,
  ) {
    return bindings.bitset_get(
      bitmap,
      value,
    );
  }

  @override
  void debug_print() {
    bindings.bitset_print(
      bitmap,
    );
  }

  final _out = malloc.allocate<ffi.Size>(
    ffi.sizeOf<ffi.Size>(),
  );

  @override
  Iterable<int> all_set() sync* {
    // const _size = 256;
    // final buffer = calloc.allocate<ffi.Size>(
    //   ffi.sizeOf<ffi.Size>() * _size,
    // );
    // final startfrom = calloc.allocate<ffi.Size>(
    //   ffi.sizeOf<ffi.Size>(),
    // );
    // final howmany = bindings.bitset_next_set_bits(bitmap, buffer, _size, startfrom);
    // for (int i = 0; i < howmany; i++) {
    //   yield buffer[i];
    //   // startfrom.value += howmany;
    // }
    _out.value = 0;
    for (; bindings.bitset_next_set_bit(bitmap, _out); _out.value++) {
      yield _out.value;
    }
  }
}
