import 'package:banja/screens/auth/register_page.dart';
import 'package:banja/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Pager extends StatefulWidget {
  const Pager({Key? key}) : super(key: key);

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  @override
  Widget build(BuildContext context) {
    bool status = GetStorage().read('isLoggedIn') ?? false;
    return !status ? const RegisterPage() : const Dashboard();
  }
}
