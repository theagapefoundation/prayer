// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
mixin _$Group {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  PUser? get admin => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get banner => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_id')
  String get adminId => throw _privateConstructorUsedError;
  @JsonKey(name: 'membership_type')
  String get membershipType => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  DateTime? get joinedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'accepted_at')
  DateTime? get acceptedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'invited_at')
  DateTime? get invitedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'banned_at')
  DateTime? get bannedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_banned_at')
  DateTime? get userBannedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'moderator')
  DateTime? get moderator => throw _privateConstructorUsedError;
  List<GroupRule>? get rules => throw _privateConstructorUsedError;
  @JsonKey(name: 'welcome_title')
  String? get welcomeTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'welcome_message')
  String? get welcomeMessage => throw _privateConstructorUsedError;
  Reminder? get reminder => throw _privateConstructorUsedError;
  @JsonKey(name: 'members_count')
  int get membersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'prayers_count')
  int get prayersCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res, Group>;
  @useResult
  $Res call(
      {String id,
      String name,
      PUser? admin,
      String? description,
      String? banner,
      @JsonKey(name: 'admin_id') String adminId,
      @JsonKey(name: 'membership_type') String membershipType,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'joined_at') DateTime? joinedAt,
      @JsonKey(name: 'accepted_at') DateTime? acceptedAt,
      @JsonKey(name: 'invited_at') DateTime? invitedAt,
      @JsonKey(name: 'banned_at') DateTime? bannedAt,
      @JsonKey(name: 'user_banned_at') DateTime? userBannedAt,
      @JsonKey(name: 'moderator') DateTime? moderator,
      List<GroupRule>? rules,
      @JsonKey(name: 'welcome_title') String? welcomeTitle,
      @JsonKey(name: 'welcome_message') String? welcomeMessage,
      Reminder? reminder,
      @JsonKey(name: 'members_count') int membersCount,
      @JsonKey(name: 'prayers_count') int prayersCount});

  $PUserCopyWith<$Res>? get admin;
  $ReminderCopyWith<$Res>? get reminder;
}

/// @nodoc
class _$GroupCopyWithImpl<$Res, $Val extends Group>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? admin = freezed,
    Object? description = freezed,
    Object? banner = freezed,
    Object? adminId = null,
    Object? membershipType = null,
    Object? createdAt = freezed,
    Object? joinedAt = freezed,
    Object? acceptedAt = freezed,
    Object? invitedAt = freezed,
    Object? bannedAt = freezed,
    Object? userBannedAt = freezed,
    Object? moderator = freezed,
    Object? rules = freezed,
    Object? welcomeTitle = freezed,
    Object? welcomeMessage = freezed,
    Object? reminder = freezed,
    Object? membersCount = null,
    Object? prayersCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      admin: freezed == admin
          ? _value.admin
          : admin // ignore: cast_nullable_to_non_nullable
              as PUser?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      adminId: null == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String,
      membershipType: null == membershipType
          ? _value.membershipType
          : membershipType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      acceptedAt: freezed == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      invitedAt: freezed == invitedAt
          ? _value.invitedAt
          : invitedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bannedAt: freezed == bannedAt
          ? _value.bannedAt
          : bannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userBannedAt: freezed == userBannedAt
          ? _value.userBannedAt
          : userBannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      moderator: freezed == moderator
          ? _value.moderator
          : moderator // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rules: freezed == rules
          ? _value.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as List<GroupRule>?,
      welcomeTitle: freezed == welcomeTitle
          ? _value.welcomeTitle
          : welcomeTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      welcomeMessage: freezed == welcomeMessage
          ? _value.welcomeMessage
          : welcomeMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      reminder: freezed == reminder
          ? _value.reminder
          : reminder // ignore: cast_nullable_to_non_nullable
              as Reminder?,
      membersCount: null == membersCount
          ? _value.membersCount
          : membersCount // ignore: cast_nullable_to_non_nullable
              as int,
      prayersCount: null == prayersCount
          ? _value.prayersCount
          : prayersCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PUserCopyWith<$Res>? get admin {
    if (_value.admin == null) {
      return null;
    }

    return $PUserCopyWith<$Res>(_value.admin!, (value) {
      return _then(_value.copyWith(admin: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ReminderCopyWith<$Res>? get reminder {
    if (_value.reminder == null) {
      return null;
    }

    return $ReminderCopyWith<$Res>(_value.reminder!, (value) {
      return _then(_value.copyWith(reminder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupImplCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$GroupImplCopyWith(
          _$GroupImpl value, $Res Function(_$GroupImpl) then) =
      __$$GroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      PUser? admin,
      String? description,
      String? banner,
      @JsonKey(name: 'admin_id') String adminId,
      @JsonKey(name: 'membership_type') String membershipType,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'joined_at') DateTime? joinedAt,
      @JsonKey(name: 'accepted_at') DateTime? acceptedAt,
      @JsonKey(name: 'invited_at') DateTime? invitedAt,
      @JsonKey(name: 'banned_at') DateTime? bannedAt,
      @JsonKey(name: 'user_banned_at') DateTime? userBannedAt,
      @JsonKey(name: 'moderator') DateTime? moderator,
      List<GroupRule>? rules,
      @JsonKey(name: 'welcome_title') String? welcomeTitle,
      @JsonKey(name: 'welcome_message') String? welcomeMessage,
      Reminder? reminder,
      @JsonKey(name: 'members_count') int membersCount,
      @JsonKey(name: 'prayers_count') int prayersCount});

  @override
  $PUserCopyWith<$Res>? get admin;
  @override
  $ReminderCopyWith<$Res>? get reminder;
}

/// @nodoc
class __$$GroupImplCopyWithImpl<$Res>
    extends _$GroupCopyWithImpl<$Res, _$GroupImpl>
    implements _$$GroupImplCopyWith<$Res> {
  __$$GroupImplCopyWithImpl(
      _$GroupImpl _value, $Res Function(_$GroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? admin = freezed,
    Object? description = freezed,
    Object? banner = freezed,
    Object? adminId = null,
    Object? membershipType = null,
    Object? createdAt = freezed,
    Object? joinedAt = freezed,
    Object? acceptedAt = freezed,
    Object? invitedAt = freezed,
    Object? bannedAt = freezed,
    Object? userBannedAt = freezed,
    Object? moderator = freezed,
    Object? rules = freezed,
    Object? welcomeTitle = freezed,
    Object? welcomeMessage = freezed,
    Object? reminder = freezed,
    Object? membersCount = null,
    Object? prayersCount = null,
  }) {
    return _then(_$GroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      admin: freezed == admin
          ? _value.admin
          : admin // ignore: cast_nullable_to_non_nullable
              as PUser?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      adminId: null == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String,
      membershipType: null == membershipType
          ? _value.membershipType
          : membershipType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      acceptedAt: freezed == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      invitedAt: freezed == invitedAt
          ? _value.invitedAt
          : invitedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bannedAt: freezed == bannedAt
          ? _value.bannedAt
          : bannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userBannedAt: freezed == userBannedAt
          ? _value.userBannedAt
          : userBannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      moderator: freezed == moderator
          ? _value.moderator
          : moderator // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rules: freezed == rules
          ? _value._rules
          : rules // ignore: cast_nullable_to_non_nullable
              as List<GroupRule>?,
      welcomeTitle: freezed == welcomeTitle
          ? _value.welcomeTitle
          : welcomeTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      welcomeMessage: freezed == welcomeMessage
          ? _value.welcomeMessage
          : welcomeMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      reminder: freezed == reminder
          ? _value.reminder
          : reminder // ignore: cast_nullable_to_non_nullable
              as Reminder?,
      membersCount: null == membersCount
          ? _value.membersCount
          : membersCount // ignore: cast_nullable_to_non_nullable
              as int,
      prayersCount: null == prayersCount
          ? _value.prayersCount
          : prayersCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupImpl extends _Group {
  const _$GroupImpl(
      {required this.id,
      required this.name,
      this.admin,
      this.description,
      this.banner,
      @JsonKey(name: 'admin_id') required this.adminId,
      @JsonKey(name: 'membership_type') required this.membershipType,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'joined_at') this.joinedAt,
      @JsonKey(name: 'accepted_at') this.acceptedAt,
      @JsonKey(name: 'invited_at') this.invitedAt,
      @JsonKey(name: 'banned_at') this.bannedAt,
      @JsonKey(name: 'user_banned_at') this.userBannedAt,
      @JsonKey(name: 'moderator') this.moderator,
      final List<GroupRule>? rules,
      @JsonKey(name: 'welcome_title') this.welcomeTitle,
      @JsonKey(name: 'welcome_message') this.welcomeMessage,
      this.reminder,
      @JsonKey(name: 'members_count') this.membersCount = 0,
      @JsonKey(name: 'prayers_count') this.prayersCount = 0})
      : _rules = rules,
        super._();

  factory _$GroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final PUser? admin;
  @override
  final String? description;
  @override
  final String? banner;
  @override
  @JsonKey(name: 'admin_id')
  final String adminId;
  @override
  @JsonKey(name: 'membership_type')
  final String membershipType;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'joined_at')
  final DateTime? joinedAt;
  @override
  @JsonKey(name: 'accepted_at')
  final DateTime? acceptedAt;
  @override
  @JsonKey(name: 'invited_at')
  final DateTime? invitedAt;
  @override
  @JsonKey(name: 'banned_at')
  final DateTime? bannedAt;
  @override
  @JsonKey(name: 'user_banned_at')
  final DateTime? userBannedAt;
  @override
  @JsonKey(name: 'moderator')
  final DateTime? moderator;
  final List<GroupRule>? _rules;
  @override
  List<GroupRule>? get rules {
    final value = _rules;
    if (value == null) return null;
    if (_rules is EqualUnmodifiableListView) return _rules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'welcome_title')
  final String? welcomeTitle;
  @override
  @JsonKey(name: 'welcome_message')
  final String? welcomeMessage;
  @override
  final Reminder? reminder;
  @override
  @JsonKey(name: 'members_count')
  final int membersCount;
  @override
  @JsonKey(name: 'prayers_count')
  final int prayersCount;

  @override
  String toString() {
    return 'Group(id: $id, name: $name, admin: $admin, description: $description, banner: $banner, adminId: $adminId, membershipType: $membershipType, createdAt: $createdAt, joinedAt: $joinedAt, acceptedAt: $acceptedAt, invitedAt: $invitedAt, bannedAt: $bannedAt, userBannedAt: $userBannedAt, moderator: $moderator, rules: $rules, welcomeTitle: $welcomeTitle, welcomeMessage: $welcomeMessage, reminder: $reminder, membersCount: $membersCount, prayersCount: $prayersCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.admin, admin) || other.admin == admin) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            (identical(other.membershipType, membershipType) ||
                other.membershipType == membershipType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.acceptedAt, acceptedAt) ||
                other.acceptedAt == acceptedAt) &&
            (identical(other.invitedAt, invitedAt) ||
                other.invitedAt == invitedAt) &&
            (identical(other.bannedAt, bannedAt) ||
                other.bannedAt == bannedAt) &&
            (identical(other.userBannedAt, userBannedAt) ||
                other.userBannedAt == userBannedAt) &&
            (identical(other.moderator, moderator) ||
                other.moderator == moderator) &&
            const DeepCollectionEquality().equals(other._rules, _rules) &&
            (identical(other.welcomeTitle, welcomeTitle) ||
                other.welcomeTitle == welcomeTitle) &&
            (identical(other.welcomeMessage, welcomeMessage) ||
                other.welcomeMessage == welcomeMessage) &&
            (identical(other.reminder, reminder) ||
                other.reminder == reminder) &&
            (identical(other.membersCount, membersCount) ||
                other.membersCount == membersCount) &&
            (identical(other.prayersCount, prayersCount) ||
                other.prayersCount == prayersCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        admin,
        description,
        banner,
        adminId,
        membershipType,
        createdAt,
        joinedAt,
        acceptedAt,
        invitedAt,
        bannedAt,
        userBannedAt,
        moderator,
        const DeepCollectionEquality().hash(_rules),
        welcomeTitle,
        welcomeMessage,
        reminder,
        membersCount,
        prayersCount
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      __$$GroupImplCopyWithImpl<_$GroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupImplToJson(
      this,
    );
  }
}

abstract class _Group extends Group {
  const factory _Group(
      {required final String id,
      required final String name,
      final PUser? admin,
      final String? description,
      final String? banner,
      @JsonKey(name: 'admin_id') required final String adminId,
      @JsonKey(name: 'membership_type') required final String membershipType,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'joined_at') final DateTime? joinedAt,
      @JsonKey(name: 'accepted_at') final DateTime? acceptedAt,
      @JsonKey(name: 'invited_at') final DateTime? invitedAt,
      @JsonKey(name: 'banned_at') final DateTime? bannedAt,
      @JsonKey(name: 'user_banned_at') final DateTime? userBannedAt,
      @JsonKey(name: 'moderator') final DateTime? moderator,
      final List<GroupRule>? rules,
      @JsonKey(name: 'welcome_title') final String? welcomeTitle,
      @JsonKey(name: 'welcome_message') final String? welcomeMessage,
      final Reminder? reminder,
      @JsonKey(name: 'members_count') final int membersCount,
      @JsonKey(name: 'prayers_count') final int prayersCount}) = _$GroupImpl;
  const _Group._() : super._();

  factory _Group.fromJson(Map<String, dynamic> json) = _$GroupImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  PUser? get admin;
  @override
  String? get description;
  @override
  String? get banner;
  @override
  @JsonKey(name: 'admin_id')
  String get adminId;
  @override
  @JsonKey(name: 'membership_type')
  String get membershipType;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'joined_at')
  DateTime? get joinedAt;
  @override
  @JsonKey(name: 'accepted_at')
  DateTime? get acceptedAt;
  @override
  @JsonKey(name: 'invited_at')
  DateTime? get invitedAt;
  @override
  @JsonKey(name: 'banned_at')
  DateTime? get bannedAt;
  @override
  @JsonKey(name: 'user_banned_at')
  DateTime? get userBannedAt;
  @override
  @JsonKey(name: 'moderator')
  DateTime? get moderator;
  @override
  List<GroupRule>? get rules;
  @override
  @JsonKey(name: 'welcome_title')
  String? get welcomeTitle;
  @override
  @JsonKey(name: 'welcome_message')
  String? get welcomeMessage;
  @override
  Reminder? get reminder;
  @override
  @JsonKey(name: 'members_count')
  int get membersCount;
  @override
  @JsonKey(name: 'prayers_count')
  int get prayersCount;
  @override
  @JsonKey(ignore: true)
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
