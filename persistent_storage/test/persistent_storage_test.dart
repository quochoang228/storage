import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:persistent_storage/_persistent_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/_storage.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late PersistentStorage persistentStorage;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    persistentStorage =
        PersistentStorage(sharedPreferences: mockSharedPreferences);
  });

  group('PersistentStorage', () {
    test('read returns value for given key', () async {
      when(mockSharedPreferences.getString('key')).thenReturn('value');

      final result = await persistentStorage.read(key: 'key');

      expect(result, 'value');
    });

    test('read throws StorageException on error', () async {
      when(mockSharedPreferences.getString('key')).thenThrow(Exception());

      expect(() => persistentStorage.read(key: 'key'),
          throwsA(isA<StorageException>()));
    });

    test('write saves value for given key', () async {
      when(mockSharedPreferences.setString('key', 'value'))
          .thenAnswer((_) async => true);

      await persistentStorage.write(key: 'key', value: 'value');

      verify(mockSharedPreferences.setString('key', 'value')).called(1);
    });

    test('write throws StorageException on error', () async {
      when(() => mockSharedPreferences.setString('key', 'value'))
          .thenThrow(Exception());

      expect(() => persistentStorage.write(key: 'key', value: 'value'),
          throwsA(isA<StorageException>()));
    });

    test('writeBool saves boolean value for given key', () async {
      when(mockSharedPreferences.setBool('key', true))
          .thenAnswer((_) async => true);

      await persistentStorage.writeBool(key: 'key', value: true);

      verify(mockSharedPreferences.setBool('key', true)).called(1);
    });

    test('writeBool throws StorageException on error', () async {
      when(mockSharedPreferences.setBool('key', true)).thenThrow(Exception());

      expect(() => persistentStorage.writeBool(key: 'key', value: true),
          throwsA(isA<StorageException>()));
    });

    test('readBool returns boolean value for given key', () async {
      when(mockSharedPreferences.getBool('key')).thenReturn(true);

      final result = await persistentStorage.readBool(key: 'key');

      expect(result, true);
    });

    test('readBool throws StorageException on error', () async {
      when(mockSharedPreferences.getBool('key')).thenThrow(Exception());

      expect(() => persistentStorage.readBool(key: 'key'),
          throwsA(isA<StorageException>()));
    });

    test('delete removes value for given key', () async {
      when(mockSharedPreferences.remove('key')).thenAnswer((_) async => true);

      await persistentStorage.delete(key: 'key');

      verify(mockSharedPreferences.remove('key')).called(1);
    });

    test('delete throws StorageException on error', () async {
      when(mockSharedPreferences.remove('key')).thenThrow(Exception());

      expect(() => persistentStorage.delete(key: 'key'),
          throwsA(isA<StorageException>()));
    });

    test('clear removes all key-value pairs', () async {
      when(mockSharedPreferences.clear()).thenAnswer((_) async => true);

      final result = await persistentStorage.clear();

      expect(result, true);
    });

    test('clear throws StorageException on error', () async {
      when(mockSharedPreferences.clear()).thenThrow(Exception());

      expect(() => persistentStorage.clear(), throwsA(isA<StorageException>()));
    });

    test('writeList saves list of strings for given key', () async {
      when(mockSharedPreferences.setStringList('key', ['value1', 'value2']))
          .thenAnswer((_) async => true);

      await persistentStorage
          .writeList(key: 'key', value: ['value1', 'value2']);

      verify(mockSharedPreferences.setStringList('key', ['value1', 'value2']))
          .called(1);
    });

    test('writeList throws StorageException on error', () async {
      when(mockSharedPreferences.setStringList('key', ['value1', 'value2']))
          .thenThrow(Exception());

      expect(
          () => persistentStorage
              .writeList(key: 'key', value: ['value1', 'value2']),
          throwsA(isA<StorageException>()));
    });

    test('readList returns list of strings for given key', () async {
      when(mockSharedPreferences.getStringList('key'))
          .thenReturn(['value1', 'value2']);

      final result = await persistentStorage.readList(key: 'key');

      expect(result, ['value1', 'value2']);
    });

    test('readList throws StorageException on error', () async {
      when(mockSharedPreferences.getStringList('key')).thenThrow(Exception());

      expect(() => persistentStorage.readList(key: 'key'),
          throwsA(isA<StorageException>()));
    });
  });
}
