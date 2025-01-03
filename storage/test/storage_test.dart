import 'package:flutter_test/flutter_test.dart';

import 'package:storage/src/storage.dart';

class MockStorage extends Storage {
  final Map<String, dynamic> _storage = {};

  @override
  Future<String?> read({required String key}) async {
    return _storage[key] as String?;
  }

  @override
  Future<List<String>?> readList({required String key}) async {
    return _storage[key] as List<String>?;
  }

  @override
  Future<bool?> readBool({required String key}) async {
    return _storage[key] as bool?;
  }

  @override
  Future<void> write({required String key, required String value}) async {
    _storage[key] = value;
  }

  @override
  Future<void> writeBool({required String key, required bool value}) async {
    _storage[key] = value;
  }

  @override
  Future<void> writeList(
      {required String key, required List<String> value}) async {
    _storage[key] = value;
  }

  @override
  Future<void> delete({required String key}) async {
    _storage.remove(key);
  }

  @override
  Future<void> clear() async {
    _storage.clear();
  }
}

void main() {
  group('Storage Tests', () {
    late Storage storage;

    setUp(() {
      storage = MockStorage();
    });

    test('write and read string value', () async {
      await storage.write(key: 'key1', value: 'value1');
      final result = await storage.read(key: 'key1');
      expect(result, 'value1');
    });

    test('write and read bool value', () async {
      await storage.writeBool(key: 'key2', value: true);
      final result = await storage.readBool(key: 'key2');
      expect(result, true);
    });

    test('write and read list value', () async {
      await storage.writeList(key: 'key3', value: ['value1', 'value2']);
      final result = await storage.readList(key: 'key3');
      expect(result, ['value1', 'value2']);
    });

    test('delete value', () async {
      await storage.write(key: 'key4', value: 'value4');
      await storage.delete(key: 'key4');
      final result = await storage.read(key: 'key4');
      expect(result, null);
    });

    test('clear all values', () async {
      await storage.write(key: 'key5', value: 'value5');
      await storage.writeBool(key: 'key6', value: false);
      await storage.clear();
      final result1 = await storage.read(key: 'key5');
      final result2 = await storage.readBool(key: 'key6');
      expect(result1, null);
      expect(result2, null);
    });
  });
}
