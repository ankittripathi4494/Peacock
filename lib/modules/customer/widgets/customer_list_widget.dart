// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';

class CustomerListWidget extends StatefulWidget {
  const CustomerListWidget({
    super.key,
  });

  @override
  State<CustomerListWidget> createState() => _CustomerListWidgetState();
}

class _CustomerListWidgetState extends State<CustomerListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20)
          ),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/edit-customer');
            },
            textColor: Colors.white,
            title: Text("Hello ${index + 1}"),
          ),
        );
      },
    );
  }
}
