import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingTab extends StatefulWidget {
  @override
  _SettingTabState createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  String appName = 'DocIT';
  String version = '1.0.0';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data'),
    );
  }
}
