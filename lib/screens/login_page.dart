import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  final _emailCtr = TextEditingController();
  final _passCtr = TextEditingController();

  void _submit() {
    if (_form.currentState!.validate()) {
      context.read<NewsProvider>().setLogin(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Welcome', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailCtr,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (v) => (v != null && v.contains('@')) ? null : 'Enter valid email',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passCtr,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (v) => (v != null && v.isNotEmpty) ? null : 'Enter password',
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(onPressed: _submit, child: const Text('LOGIN')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
