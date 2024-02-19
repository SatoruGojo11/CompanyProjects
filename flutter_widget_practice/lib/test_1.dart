import 'package:flutter/material.dart';

class Test1 extends StatelessWidget {
  const Test1({super.key});

  @override
  Widget build(BuildContext context) {
    final key1 = GlobalKey<FormState>();

    return Scaffold(
      body: Center(
        child: Form(
          key: key1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                  labelText: 'Enter your Username',
                  // errorText: 'Please Enter your name',
                ),
                validator: (value) {
                  return (value?.isEmpty ?? false)
                      ? "Please Enter your name"
                      : null;
                  // if (value == null ) {
                  //   return "Correct";
                  // }
                  // return "Please Enter your name";
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  key1.currentState!.validate();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
