import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_meta_appads_sdk/flutter_meta_appads_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterMetaAppadsSdkPlugin = FlutterMetaAppAdsSdk();
  String? fbAnonId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            children: [
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.initSdk(enableLogging: true),
                ),
                child: const Text("Init SDK"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                child: const Text("Get FB AnonId"),
                onPressed: () async {
                  var anonId = await _flutterMetaAppadsSdkPlugin.getFbAnonId();
                  setState(() {
                    fbAnonId = anonId;
                  });
                },
              ),
              Text("FB ANON ID: ${fbAnonId ?? "Not retrieved AnonId"}"),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.logEvents(
                    FBLogEventCommand(
                      eventName: "test_event",
                      eventParameters: {
                        "my_parameter": "1234",
                      },
                    ),
                  ),
                ),
                child: const Text("Log Event"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.logStandardEvent(
                    FBLogStandardEventCommand(
                      event: FBStandardEvent.contact,
                      parameters: {
                        FBStandardParameter.parameterNameSuccess: "1",
                      },
                    ),
                  ),
                ),
                child: const Text("Log Standard Event"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.logPurchase(
                    FBLogPurchaseCommand(
                      amount: 1,
                      currency: "USD",
                      eventParameter: {
                        "my_parameter": "1234",
                      },
                    ),
                  ),
                ),
                child: const Text("Log Purchase"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.setUserData(
                    FBSetUserDataCommand(
                      type: FBUserDataType.country,
                      value:
                          "6959097001d10501ac7d54c0bdb8db61420f658f2922cc26e46d536119a31126",
                    ),
                  ),
                ),
                child: const Text("Set UserData"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.setAdvertiserTrackingEnabled(
                    isEnabled: true,
                  ),
                ),
                child: const Text("Set Advertiser Tracking Enabled - True"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.setAdvertiserTrackingEnabled(
                    isEnabled: false,
                  ),
                ),
                child: const Text("Set Advertiser Tracking Enabled - False"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.setAdvertiserIDCollectionEnabled(
                    isEnabled: true,
                  ),
                ),
                child:
                    const Text("Set Advertiser ID Collection Enabled - True"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.setAdvertiserIDCollectionEnabled(
                    isEnabled: false,
                  ),
                ),
                child:
                    const Text("Set Advertiser ID Collection Enabled - False"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.setAutoLogAppEventsEnabled(
                    isEnabled: true,
                  ),
                ),
                child:
                    const Text("Set Automatic Event Collection Enabled - True"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.setAutoLogAppEventsEnabled(
                    isEnabled: false,
                  ),
                ),
                child: const Text(
                    "Set Automatic Event Collection Enabled - False"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.setDataProcessingOptions(
                      FBSetDataProcessingOptionsCommand(modes: [])),
                ),
                child: const Text("setDataProcessingOptions - empty modes"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => unawaited(
                  _flutterMetaAppadsSdkPlugin.setDataProcessingOptions(
                    FBSetDataProcessingOptionsCommand(
                      modes: ["LDU"],
                      country: 0,
                      state: 0,
                    ),
                  ),
                ),
                child: const Text(
                    "setDataProcessingOptions - LDU automatic geolocation"),
              ),
            ],
          )),
    );
  }
}
