// Mocks generated by Mockito 5.4.0 from annotations
// in shared_dependencies/test/data/uuid_manager_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:uuid/uuid.dart' as _i2;
import 'package:uuid/data.dart';

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUuidValue_0 extends _i1.SmartFake implements _i2.UuidValue {
  _FakeUuidValue_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Uuid].
///
/// See the documentation for Mockito's code generation for more information.
class MockUuid extends _i1.Mock implements _i2.Uuid {
  MockUuid() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String v1({V1Options? config,Map<String, dynamic>? options}) => (super.noSuchMethod(
        Invocation.method(
          #v1,
          [],
          {#options: options},
        ),
        returnValue: '',
      ) as String);
  @override
  List<int> v1buffer(
    List<int>? buffer, {
        V1Options? config,
    Map<String, dynamic>? options,
    int? offset = 0,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #v1buffer,
          [buffer],
          {
            #options: options,
            #offset: offset,
          },
        ),
        returnValue: <int>[],
      ) as List<int>);
  @override
  _i2.UuidValue v1obj({ V1Options? config,Map<String, dynamic>? options}) => (super.noSuchMethod(
        Invocation.method(
          #v1obj,
          [],
          {#options: options},
        ),
        returnValue: _FakeUuidValue_0(
          this,
          Invocation.method(
            #v1obj,
            [],
            {#options: options},
          ),
        ),
      ) as _i2.UuidValue);
  @override
  String v4({V4Options? config,Map<String, dynamic>? options}) => (super.noSuchMethod(
        Invocation.method(
          #v4,
          [],
          {#options: options},
        ),
        returnValue: '',
      ) as String);
  @override
  List<int> v4buffer(
    List<int> buffer, {
        V4Options? config,
    Map<String, dynamic>? options,
    int? offset = 0,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #v4buffer,
          [buffer],
          {
            #options: options,
            #offset: offset,
          },
        ),
        returnValue: <int>[],
      ) as List<int>);
  @override
  _i2.UuidValue v4obj({V4Options? config,Map<String, dynamic>? options}) => (super.noSuchMethod(
        Invocation.method(
          #v4obj,
          [],
          {#options: options},
        ),
        returnValue: _FakeUuidValue_0(
          this,
          Invocation.method(
            #v4obj,
            [],
            {#options: options},
          ),
        ),
      ) as _i2.UuidValue);
  @override
  String v5(
    String? namespace,
    String? name, {V5Options? config,
    Map<String, dynamic>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #v5,
          [
            namespace,
            name,
          ],
          {#options: options},
        ),
        returnValue: '',
      ) as String);
  @override
  List<int> v5buffer(
    String? namespace,
    String? name,
    List<int>? buffer, {V5Options? config,
    Map<String, dynamic>? options,
    int? offset = 0,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #v5buffer,
          [
            namespace,
            name,
            buffer,
          ],
          {
            #options: options,
            #offset: offset,
          },
        ),
        returnValue: <int>[],
      ) as List<int>);
  @override
  _i2.UuidValue v5obj(
    String? namespace,
    String? name, {
        V5Options? config,
    Map<String, dynamic>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #v5obj,
          [
            namespace,
            name,
          ],
          {#options: options},
        ),
        returnValue: _FakeUuidValue_0(
          this,
          Invocation.method(
            #v5obj,
            [
              namespace,
              name,
            ],
            {#options: options},
          ),
        ),
      ) as _i2.UuidValue);
}
