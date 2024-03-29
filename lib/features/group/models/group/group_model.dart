// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prayer/features/corporate_prayer/models/reminder/reminder_model.dart';
import 'package:prayer/features/group/models/group_rule/group_rule.dart';
import 'package:prayer/model/placeholder.dart';
import 'package:prayer/model/user/user_model.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
class Group with _$Group {
  const Group._();

  const factory Group({
    required String id,
    required String name,
    PUser? admin,
    String? description,
    String? banner,
    @JsonKey(name: 'admin_id') required String adminId,
    @JsonKey(name: 'membership_type') required String membershipType,
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
    @Default(0) @JsonKey(name: 'members_count') int membersCount,
    @Default(0) @JsonKey(name: 'prayers_count') int prayersCount,
  }) = _Group;

  static Group get placeholder => Group(
        id: '1',
        name: "Group",
        adminId: "1",
        membershipType: "open",
        description: LoremIpsum,
        admin: PUser.placeholder,
      );

  factory Group.fromJson(Map<String, Object?> json) => _$GroupFromJson(json);
}
