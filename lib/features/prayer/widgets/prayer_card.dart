import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/image_list.dart';
import 'package:prayer/features/prayer/models/prayer_model.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/bible/widgets/bible_card_list.dart';
import 'package:prayer/features/pray/widgets/pray_chip.dart';
import 'package:prayer/features/user/widgets/user_chip.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/features/prayer/providers/prayer_provider.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrayerCard extends ConsumerWidget {
  const PrayerCard({
    super.key,
    required this.prayerId,
    this.onTap,
  });

  final void Function()? onTap;
  final String prayerId;

  Widget _buildGroupLabel(
    BuildContext context, {
    required Prayer prayer,
  }) =>
      ShrinkingButton(
        onTap: () => context.push('/groups/${prayer.groupId}'),
        child: Row(
          children: [
            const SizedBox(width: 10),
            FaIcon(
              FontAwesomeIcons.userGroupSimple,
              size: 13,
              color: MyTheme.placeholderText,
            ),
            const SizedBox(width: 5),
            Text(
              prayer.group?.name ?? '',
              style: TextStyle(
                color: MyTheme.placeholderText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget _buildCorporateLabel(
    BuildContext context, {
    required Prayer prayer,
  }) =>
      ShrinkingButton(
        onTap: () {
          context.push('/prayers/corporate/${prayer.corporateId}');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: FaIcon(
                FontAwesomeIcons.solidChevronRight,
                size: 10,
                color: MyTheme.placeholderText,
              ),
            ),
            Text(
              prayer.corporate?.title ?? '',
              style: TextStyle(
                color: MyTheme.placeholderText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget _buidlFooterLatestPray(BuildContext context, {Prayer? prayer}) {
    if (prayer?.pray == null) {
      return const SizedBox();
    }
    return Row(
      children: [
        UserProfileImage(
          profile: prayer!.pray!.profile,
          size: 30,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            S.of(context).someoneHasPrayed(prayer.pray!.username),
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 10),
        if (prayer.pray?.createdAt != null)
          Text(
            Formatter.fromNow(prayer.pray!.createdAt!),
            style: TextStyle(
              color: MyTheme.outline,
            ),
          ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayer = ref.watch(prayerNotifierProvider(prayerId));

    return Skeletonizer(
      enabled: prayer.isLoading || prayer.value == null,
      child: ShrinkingButton(
        onTap: () {
          context.push('/prayers/$prayerId');
          onTap?.call();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prayer.value?.group != null)
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, bottom: 5),
                  child: Row(
                    children: [
                      _buildGroupLabel(context, prayer: prayer.value!),
                      if (prayer.value?.corporate != null)
                        _buildCorporateLabel(context, prayer: prayer.value!),
                    ],
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserChip(
                    anon: prayer.value?.anon == true,
                    uid: prayer.value?.userId,
                    profile: prayer.value?.user?.profile,
                    name: prayer.value?.user?.name,
                    username: prayer.value?.user?.username,
                  ),
                  Spacer(),
                  const SizedBox(width: 10),
                  Text(
                    prayer.value?.createdAt == null
                        ? ''
                        : Formatter.fromNow(prayer.value!.createdAt!),
                    style: TextStyle(color: MyTheme.outline),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AbsorbPointer(
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: ReadMoreText(
                    prayer.value?.value ?? '',
                    trimCollapsedText: S.of(context).readmore,
                    trimLines: 5,
                    moreStyle: TextStyle(
                      color: MyTheme.placeholderText,
                    ),
                    trimMode: TrimMode.Line,
                  ),
                ),
              ),
              if (prayer.value?.verses != null &&
                  prayer.value!.verses.length > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                  child: BibleCardList(
                    verses: prayer.value?.verses ?? [],
                  ),
                ),
              if (prayer.value?.contents != null &&
                  prayer.value!.contents.length > 0)
                Container(
                  padding: const EdgeInsets.fromLTRB(40, 10, 10, 0),
                  child: ImageList(
                      images:
                          prayer.value!.contents.map((e) => e.path).toList()),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buidlFooterLatestPray(
                      context,
                      prayer: prayer.value,
                    ),
                  ),
                  PrayChip(prayerId: prayerId),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
