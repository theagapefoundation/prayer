// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CustomNotification _$CustomNotificationFromJson(Map<String, dynamic> json) {
  return _CustomNotification.fromJson(json);
}

/// @nodoc
mixin _$CustomNotification {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_user_id')
  String? get targetUserId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_user')
  PUser? get targetUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'corporate_id')
  String? get corporateId => throw _privateConstructorUsedError;
  @JsonKey(name: 'prayer_id')
  String? get prayerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  String? get groupId => throw _privateConstructorUsedError;
  Group? get group => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomNotificationCopyWith<CustomNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomNotificationCopyWith<$Res> {
  factory $CustomNotificationCopyWith(
          CustomNotification value, $Res Function(CustomNotification) then) =
      _$CustomNotificationCopyWithImpl<$Res, CustomNotification>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'target_user_id') String? targetUserId,
      String message,
      @JsonKey(name: 'target_user') PUser? targetUser,
      @JsonKey(name: 'corporate_id') String? corporateId,
      @JsonKey(name: 'prayer_id') String? prayerId,
      @JsonKey(name: 'group_id') String? groupId,
      Group? group,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  $PUserCopyWith<$Res>? get targetUser;
  $GroupCopyWith<$Res>? get group;
}

/// @nodoc
class _$CustomNotificationCopyWithImpl<$Res, $Val extends CustomNotification>
    implements $CustomNotificationCopyWith<$Res> {
  _$CustomNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? targetUserId = freezed,
    Object? message = null,
    Object? targetUser = freezed,
    Object? corporateId = freezed,
    Object? prayerId = freezed,
    Object? groupId = freezed,
    Object? group = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      targetUserId: freezed == targetUserId
          ? _value.targetUserId
          : targetUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      targetUser: freezed == targetUser
          ? _value.targetUser
          : targetUser // ignore: cast_nullable_to_non_nullable
              as PUser?,
      corporateId: freezed == corporateId
          ? _value.corporateId
          : corporateId // ignore: cast_nullable_to_non_nullable
              as String?,
      prayerId: freezed == prayerId
          ? _value.prayerId
          : prayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PUserCopyWith<$Res>? get targetUser {
    if (_value.targetUser == null) {
      return null;
    }

    return $PUserCopyWith<$Res>(_value.targetUser!, (value) {
      return _then(_value.copyWith(targetUser: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupCopyWith<$Res>? get group {
    if (_value.group == null) {
      return null;
    }

    return $GroupCopyWith<$Res>(_value.group!, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomNotificationImplCopyWith<$Res>
    implements $CustomNotificationCopyWith<$Res> {
  factory _$$CustomNotificationImplCopyWith(_$CustomNotificationImpl value,
          $Res Function(_$CustomNotificationImpl) then) =
      __$$CustomNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'target_user_id') String? targetUserId,
      String message,
      @JsonKey(name: 'target_user') PUser? targetUser,
      @JsonKey(name: 'corporate_id') String? corporateId,
      @JsonKey(name: 'prayer_id') String? prayerId,
      @JsonKey(name: 'group_id') String? groupId,
      Group? group,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  @override
  $PUserCopyWith<$Res>? get targetUser;
  @override
  $GroupCopyWith<$Res>? get group;
}

/// @nodoc
class __$$CustomNotificationImplCopyWithImpl<$Res>
    extends _$CustomNotificationCopyWithImpl<$Res, _$CustomNotificationImpl>
    implements _$$CustomNotificationImplCopyWith<$Res> {
  __$$CustomNotificationImplCopyWithImpl(_$CustomNotificationImpl _value,
      $Res Function(_$CustomNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? targetUserId = freezed,
    Object? message = null,
    Object? targetUser = freezed,
    Object? corporateId = freezed,
    Object? prayerId = freezed,
    Object? groupId = freezed,
    Object? group = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$CustomNotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      targetUserId: freezed == targetUserId
          ? _value.targetUserId
          : targetUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      targetUser: freezed == targetUser
          ? _value.targetUser
          : targetUser // ignore: cast_nullable_to_non_nullable
              as PUser?,
      corporateId: freezed == corporateId
          ? _value.corporateId
          : corporateId // ignore: cast_nullable_to_non_nullable
              as String?,
      prayerId: freezed == prayerId
          ? _value.prayerId
          : prayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomNotificationImpl implements _CustomNotification {
  const _$CustomNotificationImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'target_user_id') this.targetUserId,
      required this.message,
      @JsonKey(name: 'target_user') this.targetUser,
      @JsonKey(name: 'corporate_id') this.corporateId,
      @JsonKey(name: 'prayer_id') this.prayerId,
      @JsonKey(name: 'group_id') this.groupId,
      this.group,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$CustomNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomNotificationImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'target_user_id')
  final String? targetUserId;
  @override
  final String message;
  @override
  @JsonKey(name: 'target_user')
  final PUser? targetUser;
  @override
  @JsonKey(name: 'corporate_id')
  final String? corporateId;
  @override
  @JsonKey(name: 'prayer_id')
  final String? prayerId;
  @override
  @JsonKey(name: 'group_id')
  final String? groupId;
  @override
  final Group? group;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'CustomNotification(id: $id, userId: $userId, targetUserId: $targetUserId, message: $message, targetUser: $targetUser, corporateId: $corporateId, prayerId: $prayerId, groupId: $groupId, group: $group, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.targetUserId, targetUserId) ||
                other.targetUserId == targetUserId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.targetUser, targetUser) ||
                other.targetUser == targetUser) &&
            (identical(other.corporateId, corporateId) ||
                other.corporateId == corporateId) &&
            (identical(other.prayerId, prayerId) ||
                other.prayerId == prayerId) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, targetUserId,
      message, targetUser, corporateId, prayerId, groupId, group, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomNotificationImplCopyWith<_$CustomNotificationImpl> get copyWith =>
      __$$CustomNotificationImplCopyWithImpl<_$CustomNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomNotificationImplToJson(
      this,
    );
  }
}

abstract class _CustomNotification implements CustomNotification {
  const factory _CustomNotification(
          {required final int id,
          @JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'target_user_id') final String? targetUserId,
          required final String message,
          @JsonKey(name: 'target_user') final PUser? targetUser,
          @JsonKey(name: 'corporate_id') final String? corporateId,
          @JsonKey(name: 'prayer_id') final String? prayerId,
          @JsonKey(name: 'group_id') final String? groupId,
          final Group? group,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$CustomNotificationImpl;

  factory _CustomNotification.fromJson(Map<String, dynamic> json) =
      _$CustomNotificationImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'target_user_id')
  String? get targetUserId;
  @override
  String get message;
  @override
  @JsonKey(name: 'target_user')
  PUser? get targetUser;
  @override
  @JsonKey(name: 'corporate_id')
  String? get corporateId;
  @override
  @JsonKey(name: 'prayer_id')
  String? get prayerId;
  @override
  @JsonKey(name: 'group_id')
  String? get groupId;
  @override
  Group? get group;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$CustomNotificationImplCopyWith<_$CustomNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
