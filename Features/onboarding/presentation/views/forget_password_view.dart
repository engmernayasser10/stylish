import 'package:flutter/material.dart';
import 'package:stylish/Features/onboarding/presentation/views/widgets/forget_password_view_body.dart';

class ForgetPassView extends StatelessWidget {
  const ForgetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ForgetPassViewBody()));
  }
}
