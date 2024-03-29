import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class GroupBannerImage extends StatelessWidget {
  const GroupBannerImage({
    super.key,
    this.banner,
  });

  final String? banner;

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.5,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return banner != null
        ? ShrinkingButton(
            onTap: () {
              context.push(
                  Uri(path: '/image', queryParameters: {'imageUrl': banner})
                      .toString());
            },
            child: CachedNetworkImage(
              imageUrl: banner!,
              errorWidget: (context, url, error) => _buildPlaceholder(context),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.cover,
            ),
          )
        : _buildPlaceholder(context);
  }
}

class UserBannerImage extends StatelessWidget {
  const UserBannerImage({
    super.key,
    this.banner,
  });

  final String? banner;

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return banner != null
        ? ShrinkingButton(
            onTap: () {
              context.push(
                  Uri(path: '/image', queryParameters: {'imageUrl': banner})
                      .toString());
            },
            child: CachedNetworkImage(
              imageUrl: banner!,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => _buildPlaceholder(context),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
          )
        : _buildPlaceholder(context);
  }
}

enum UserProfileImageClickActionType { profile, picture }

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    this.profile,
    this.uid,
    this.size = 100,
    this.clickActionType = UserProfileImageClickActionType.picture,
    this.imageRadius,
  }) : assert((clickActionType == UserProfileImageClickActionType.profile &&
                uid != null) ||
            clickActionType == UserProfileImageClickActionType.picture);

  final String? profile;
  final String? uid;
  final double size;
  final UserProfileImageClickActionType clickActionType;
  final BorderRadius? imageRadius;

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: imageRadius != null ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: imageRadius,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (profile != null) {
      return ShrinkingButton(
        onTap: () {
          if (clickActionType == UserProfileImageClickActionType.picture) {
            context.push(
                Uri(path: '/image', queryParameters: {'imageUrl': profile})
                    .toString());
          } else {
            context.push(
                Uri(path: '/users', queryParameters: {'uid': uid}).toString());
          }
        },
        child: CachedNetworkImage(
          imageUrl: profile!,
          width: size,
          height: size,
          errorWidget: (context, url, error) => _buildPlaceholder(context),
          imageBuilder: (context, imageProvider) => Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider),
              shape: imageRadius != null ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: imageRadius,
            ),
          ),
        ),
      );
    } else {
      return _buildPlaceholder(context);
    }
  }
}
