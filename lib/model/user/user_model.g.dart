// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PUserImpl _$$PUserImplFromJson(Map<String, dynamic> json) => _$PUserImpl(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      username: json['username'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String?,
      profile: json['profile'] as String?,
      banner: json['banner'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      followedAt: json['followed_at'] == null
          ? null
          : DateTime.parse(json['followed_at'] as String),
      bannedAt: json['banned_at'] == null
          ? null
          : DateTime.parse(json['banned_at'] as String),
      blockedAt: json['blocked_at'] == null
          ? null
          : DateTime.parse(json['blocked_at'] as String),
      verseId: json['verse_id'] as int?,
      followingsCount: json['followings_count'] as int? ?? 0,
      followersCount: json['followers_count'] as int? ?? 0,
      prayersCount: json['prayers_count'] as int? ?? 0,
      praysCount: json['prays_count'] as int? ?? 0,
    );

Map<String, dynamic> _$$PUserImplToJson(_$PUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'username': instance.username,
      'name': instance.name,
      'bio': instance.bio,
      'profile': instance.profile,
      'banner': instance.banner,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'followed_at': instance.followedAt?.toIso8601String(),
      'banned_at': instance.bannedAt?.toIso8601String(),
      'blocked_at': instance.blockedAt?.toIso8601String(),
      'verse_id': instance.verseId,
      'followings_count': instance.followingsCount,
      'followers_count': instance.followersCount,
      'prayers_count': instance.prayersCount,
      'prays_count': instance.praysCount,
    };
