import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/screens/home/search_screen.dart';
import 'package:prayer/presentation/screens/home/user_screen.dart';
import 'package:prayer/presentation/screens/home_screen.dart';
import 'package:prayer/presentation/widgets/button/fab.dart';
import 'package:prayer/presentation/widgets/notification_bar.dart';
import 'package:prayer/providers/auth/auth_provider.dart';
import 'package:prayer/providers/auth/auth_state.dart';

class HomeTabBar extends HookWidget {
  const HomeTabBar({super.key});

  handleNotification(BuildContext context, RemoteMessage? message) {
    if (message == null) {
      return;
    }
    final data = message.data;
    if (data['prayerId'] != null) {
      context.push('/prayers/${data["prayerId"]}');
    } else if (data['corporateId'] != null) {
      context.push('/prayers/corporateId/${data["corporateId"]}');
    } else if (data['groupId'] != null) {
      context.push('/groups/${data["groupId"]}');
    } else if (data['userId'] != null) {
      context.push(Uri(path: '/users', queryParameters: {'uid': data['userId']})
          .toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final index = useState(0);

    useEffect(() {
      FirebaseMessaging.instance
          .requestPermission(provisional: true)
          .then((value) async {
        talker.debug("Notification settings updated: $value");
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (Platform.isIOS && apnsToken != null || Platform.isAndroid) {
          final fcmToken = await FirebaseMessaging.instance.getToken();
          if (fcmToken != null) {
            talker.debug('Fcm token refreshed: $fcmToken');
            dio.post('/v1/users/fcmToken', data: {'value': fcmToken});
          }
        }
      }).catchError((e) {
        talker.error(
            "Error occured while updating notification settings: $e", e);
      });
      return () {};
    }, []);

    useEffect(() {
      List<StreamSubscription<dynamic>> subscriptions = [];
      subscriptions
          .add(FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        talker.debug('Fcm token refreshed: $fcmToken');
        dio.post('/v1/users/fcmToken', data: {'value': fcmToken});
      }));
      subscriptions.add(FirebaseMessaging.onMessage.listen((initialMessage) {
        if (initialMessage.notification?.body != null) {
          NotificationSnackBar.show(
            context,
            message: initialMessage.notification!.body!,
            onTap: () => handleNotification(context, initialMessage),
          );
        }
      }));
      subscriptions.add(FirebaseMessaging.onMessageOpenedApp.listen(
          (initialMessage) => handleNotification(context, initialMessage)));
      return () {
        subscriptions.forEach((subscription) => subscription.cancel());
      };
    }, []);

    useEffect(() {
      FirebaseMessaging.instance.getInitialMessage().then(
          (initialMessage) => handleNotification(context, initialMessage));
      return () => null;
    }, []);

    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      body: Stack(
        children: [
          IndexedStack(
            index: index.value,
            children: [
              HomeScreen(),
              SearchScreen(),
              UserScreen(
                uid: FirebaseAuth.instance.currentUser!.uid,
                canPop: false,
              ),
            ],
          ),
          FAB(
            onTap: () {
              context.push('/form/prayer');
            },
          ),
        ],
      ),
      bottomNavBar: PlatformNavBar(
        height: 60,
        material3: (context, platform) => MaterialNavigationBarData(
          surfaceTintColor: MyTheme.surface,
          indicatorColor: MyTheme.surface,
          backgroundColor: MyTheme.surface,
        ),
        cupertino: (context, platform) => CupertinoTabBarData(
            inactiveColor: MyTheme.disabled, activeColor: MyTheme.disabled),
        currentIndex: index.value,
        itemChanged: (i) {
          index.value = i;
        },
        backgroundColor: MyTheme.surface,
        items: [
          BottomNavigationBarItem(
              backgroundColor: MyTheme.surface,
              label: '',
              icon: FaIcon(
                FontAwesomeIcons.house,
                size: 20,
                color: index.value == 0 ? MyTheme.onPrimary : MyTheme.disabled,
              )),
          BottomNavigationBarItem(
              label: '',
              icon: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                size: 20,
                color: index.value == 1 ? MyTheme.onPrimary : MyTheme.disabled,
              )),
          BottomNavigationBarItem(
            label: '',
            icon: Consumer(
              builder: (context, ref, _) {
                final state = ref.watch(authNotifierProvider).value;
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: index.value == 2
                          ? MyTheme.onPrimary
                          : MyTheme.disabled,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(state is AuthStateSignedUp
                      ? state.user.profile == null
                          ? 10
                          : 2
                      : 2),
                  child: UserTabButton(
                    index: index.value,
                    profile:
                        state is AuthStateSignedUp ? state.user.profile : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserTabButton extends StatelessWidget {
  const UserTabButton({
    super.key,
    this.profile,
    this.index = 0,
  });

  final String? profile;
  final int index;

  Widget _renderPlaceholder() {
    return FaIcon(
      FontAwesomeIcons.user,
      size: 15,
      color: index == 2 ? MyTheme.onPrimary : MyTheme.disabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    return profile == null
        ? _renderPlaceholder()
        : CachedNetworkImage(
            width: 30,
            height: 30,
            imageUrl: profile!,
            errorWidget: (context, url, error) => Center(
              child: _renderPlaceholder(),
            ),
            imageBuilder: (context, imageProvider) => Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  )),
            ),
          );
  }
}
