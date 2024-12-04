abstract class DatabaseRepository {
  // users

  Future<void> save(String key, String value);
  Future<String?> load(String key);
  Future<void> delete(String key);
  Future<bool> contains(String key);
}
