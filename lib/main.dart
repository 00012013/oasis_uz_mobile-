import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/app/material_app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}
