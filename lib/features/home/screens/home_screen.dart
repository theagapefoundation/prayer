import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/common/screens/empty_prayers_screen.dart';
import 'package:prayer/features/common/widgets/tab_bar.dart';
import 'package:prayer/features/home/widgets/neighbor_description_card.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/features/prayer/widgets/prayers_screen.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/user/widgets/account_ban_card.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:prayer/features/settings/notifications/providers/notification_provider.dart';
import 'package:prayer/repo/prayer_repository.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 3);
    final bannedAt = ref.watch(authNotifierProvider).valueOrNull?.when(
          signedOut: () => null,
          signedIn: () => null,
          signedUp: (user) => user.bannedAt,
        );
    final homePagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final followersPagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final neighborPagingController =
        usePagingController<String?, String>(firstPageKey: null);

    final hasNewNotification = ref.watch(notificationNotifierProvider).when(
          data: (v) => v,
          loading: () => false,
          error: (_, __) => false,
        );

    return RefreshIndicator(
      edgeOffset: 100,
      notificationPredicate: (notification) => notification.depth == 2,
      onRefresh: () async {
        ref.invalidate(notificationNotifierProvider);
        switch (tabController.index) {
          case 0:
            return homePagingController.refresh();
          case 1:
            return followersPagingController.refresh();
          case 2:
            return neighborPagingController.refresh();
        }
      },
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                toolbarHeight: 40,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Stack(
                    children: [
                      NavigateIconButton(
                        icon: FontAwesomeIcons.bell,
                        onPressed: () {
                          context.push('/notifications');
                        },
                      ),
                      if (hasNewNotification)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircle,
                            color: Colors.red,
                            size: 8,
                          ),
                        ),
                    ],
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: NavigateIconButton(
                      icon: FontAwesomeIcons.gear,
                      onPressed: () => context.push('/settings'),
                    ),
                  ),
                ],
                automaticallyImplyLeading: false,
                title: Text(
                  "Prayer",
                  style: platformThemeData(
                    context,
                    material: (ThemeData data) => data.textTheme.headlineSmall,
                    cupertino: (data) => data.textTheme.navTitleTextStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                floating: false,
                pinned: false,
                snap: false,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(bannedAt == null ? 48 : 128),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        color: Theme.of(context).colorScheme.background,
                        child: CustomTabBar(
                          tabs: [
                            t.general.home,
                            t.general.followers,
                            t.general.neighbor,
                          ],
                          controller: tabController,
                          onTap: (index) {
                            if (tabController.animation?.value == index &&
                                index == 2) {
                              Hive.box('settings')
                                  .put('neighbor.description.shown', true);
                            }
                          },
                        ),
                      ),
                      if (bannedAt != null) AccountBanCard(),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: tabController,
            children: [
              (cursor) =>
                  GetIt.I<PrayerRepository>().fetchHomeFeed(cursor: cursor),
              (cursor) => GetIt.I<PrayerRepository>()
                  .fetchFollowersPrayers(cursor: cursor),
              (cursor) => GetIt.I<PrayerRepository>()
                  .fetchNeighborPrayers(cursor: cursor)
            ]
                .asMap()
                .entries
                .map(
                  (entry) => Builder(
                    builder: (context) {
                      return CustomScrollView(
                        cacheExtent: 5000,
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        slivers: [
                          SliverOverlapInjector(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context)),
                          if (entry.key == 2)
                            SliverToBoxAdapter(
                                child: NeighborDescriptionCard()),
                          PrayersScreen(
                            sliver: true,
                            physics: const NeverScrollableScrollPhysics(),
                            pagingController: switch (entry.key) {
                              0 => homePagingController,
                              1 => followersPagingController,
                              2 => neighborPagingController,
                              _ => homePagingController,
                            },
                            noItemsFoundIndicatorBuilder: switch (entry.key) {
                              1 => (context) => EmptyPrayersScreen(
                                    title: t.empty.followersPrayer.title,
                                    description:
                                        t.empty.followersPrayer.description,
                                    buttonText: t.empty.followersPrayer.button,
                                    onTap: () => context.push(Uri(
                                            path: '/search',
                                            queryParameters: {'type': 'user'})
                                        .toString()),
                                  ),
                              2 => (context) => EmptyPrayersScreen(
                                    title: t.empty.neighbor.title,
                                    description: t.empty.neighbor.description,
                                    buttonText: t.general.pray,
                                    onTap: () => tabController.animateTo(0),
                                  ),
                              _ => null
                            },
                            fetchFn: entry.value,
                          ),
                        ],
                      );
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
