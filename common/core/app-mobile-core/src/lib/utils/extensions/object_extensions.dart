extension NullChecking on Object? {
  /// Returns true if object is:
  /// - null `Object`
  /// - empty `String`s
  /// - empty `Iterable` (list, set, ...)
  /// - empty `Map` (but will throw when being called on an object value declared `dynamic`
  /// such as `Map<String, dynamic>{'obj': 1}['otherKey']`)
  bool get isEmptyOrNull => _isNull || _isStringObjectEmpty || _isIterableObjectEmpty || _isMapObjectEmpty;

  /// Returns true if object is:
  /// - non null `Object`
  /// - non empty `String`s
  /// - non empty `Iterable` (list, set, ...)
  /// - non empty `Map` (but will throw when being called on an object value declared `dynamic`
  /// such as `Map<String, dynamic>{'obj': 1}['otherKey']`)
  bool get isNotEmptyOrNull {
    if (_isNull) return false;

    if (this is String) return (this as String).isNotEmpty;

    if (this is Iterable) return (this as Iterable).isNotEmpty;

    if (this is Map) return (this as Map).isNotEmpty;

    return true;
  }

  /// Returns true if object is:
  /// - null `Object`
  bool get _isNull => this == null;

  // ------- PRIVATE EXTENSION HELPERS -------
  /// **Private helper**
  ///
  /// If `String` object, return String's method `isEmpty`
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `String`
  bool get _isStringObjectEmpty => (this is String) ? (this as String).isEmpty : false;

  /// **Private helper**
  ///
  /// If `Iterable` object, return Iterable's method `isEmpty`
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `Iterable`
  bool get _isIterableObjectEmpty => (this is Iterable) ? (this as Iterable).isEmpty : false;

  /// **Private helper**
  ///
  /// If `Map` object, return Map's method `isEmpty`
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `Map`
  bool get _isMapObjectEmpty => (this is Map) ? (this as Map).isEmpty : false;
}
