import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:x5_plugin/x5_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('x5_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await X5Plugin.platformVersion, '42');
  });
}
