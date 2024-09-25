// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:async';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/blocs/internet/internet_state.dart';
import 'package:pecockapp/global/utils/utils.dart';
import 'package:pecockapp/global/widgets/app_bar_widget.dart';
import 'package:pecockapp/global/widgets/bottom_nav_bar.dart';
import 'package:pecockapp/global/widgets/dialog.dart';
import 'package:pecockapp/global/widgets/drawer.dart';

class DashboardScreen extends StatefulWidget {
  late Map<String, dynamic>? argus;
  DashboardScreen({
    super.key,
    this.argus,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int screenNumber = 0;
  AdmobInterstitial? interstitialAd; // Declare the variable first
  @override
  void initState() {
    switchToDashboard();
    super.initState();
  }

  switchToDashboard() async {
    interstitialAd = AdmobInterstitial(
      adUnitId:
          AdmobInterstitial.testAdUnitId, // Replace with your actual ad unit ID
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.loaded) {
          interstitialAd
              ?.show(); // Use the nullable variable safely with '?' operator
        } else if (event == AdmobAdEvent.closed) {
          interstitialAd?.dispose();
        }
      },
    );

    interstitialAd?.load(); // Load the interstitial ad

    await FirebaseAnalytics.instance.logBeginCheckout(
        value: 10.0,
        currency: 'USD',
        items: [
          AnalyticsEventItem(
              itemName: 'Socks', itemId: 'xjw73ndnw', price: 10.0),
        ],
        coupon: '10PERCENTOFF');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetLost) {
          Timer(Durations.medium4, () {
            Navigator.pushReplacementNamed(context, '/internet-disconnect');
          });
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            CustomAlertDialog.showCustomDialogForGeneral(context,
                title: const Text("Do you want to close app??"),
                actions: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      exit(0);
                    },
                    label: const Text("Yes"),
                    icon: const Icon(Icons.check_box_rounded),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: const Text("No"),
                    icon: const Icon(Icons.cancel_rounded),
                  ),
                ]);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.blue],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBarWidget.appBarWidgetMethod(
              context,
              title: AdmobBanner(
                  adUnitId: AdmobBanner.testAdUnitId,
                  adSize: AdmobBannerSize.BANNER),
            ),
            drawer: MyDrawer.getDrawerWidget(context),
            body: const Center(
              child: Text("Dashboard Screen"),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: FloatingActionButton(
                onPressed: () async {
                  AdmobReward? admobReward;
                  admobReward = AdmobReward(
                    adUnitId: AdmobReward.testAdUnitId,
                    listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
                      if (event == AdmobAdEvent.loaded) {
                        admobReward
                            ?.show(); // Use the nullable variable safely with '?' operator
                      } else if (event == AdmobAdEvent.closed) {
                        admobReward?.dispose();
                      }
                    },
                  );
                  admobReward.load();
                },
                child: Icon(Icons.ad_units), // An icon to represent the action
              ),
            ),
            bottomNavigationBar:
                BottomNavBarWidget.bottomNavBar(context, screenNumber, (d) {
              setState(() {
                screenNumber = d;
              });
              if (screenNumber == 0) {
                Navigator.pushReplacementNamed(context, '/dashboard');
              } else if (screenNumber == 1) {
                Navigator.pushReplacementNamed(context, '/customer-list');
              } else if (screenNumber == 2) {
                Navigator.pushReplacementNamed(context, '/business');
              } else if (screenNumber == 3) {
                Navigator.pushReplacementNamed(context, '/profile');
              }
            }),
          ),
        ),
      ),
    );
  }
}
