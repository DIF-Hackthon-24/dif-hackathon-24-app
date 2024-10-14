class ILocalDatabase {
  Future<dynamic> get(String key) {
    throw UnimplementedError();
  }

  Future<dynamic> getAt<T>(int index) {
    throw UnimplementedError();
  }

  Future<int> add<T>(dynamic value) {
    throw UnimplementedError();
  }

  Future<void> put(String key, dynamic value) {
    throw UnimplementedError();
  }

  Future<void> putAt<T>(int index, dynamic value) {
    throw UnimplementedError();
  }
}