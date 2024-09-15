// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/utils/image_list.dart';
import 'package:pecockapp/global/widgets/auto_schedule_task.dart';
import 'package:pecockapp/global/widgets/toast.dart';
import 'package:pecockapp/modules/customer/bloc/customer_bloc.dart';
import 'package:pecockapp/modules/customer/bloc/customer_event.dart';
import 'package:pecockapp/modules/customer/bloc/customer_state.dart';

class CustomerListWidget extends StatefulWidget {
  const CustomerListWidget({
    super.key,
  });

  @override
  State<CustomerListWidget> createState() => _CustomerListWidgetState();
}

class _CustomerListWidgetState extends State<CustomerListWidget> {
  @override
  void initState() {
    fetchCustomerList();
    super.initState();
  }

  fetchCustomerList() {
    BlocProvider.of<CustomerBloc>(context).add(CustomerListFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        if (state is DeleteCustomerSuccessState) {
          return AutoScheduleTaskWidget.taskScheduler(context, task: () {
            Navigator.pushReplacementNamed(context, '/customer-list');

            ToastedNotification.successToast(context,
                description: state.successMessage);
          }, taskWaitDuration: Durations.medium3);
        }
        if (state is DeleteCustomerFailedState) {
          return AutoScheduleTaskWidget.taskScheduler(context, task: () {
            Navigator.pushReplacementNamed(context, '/customer-list');

            ToastedNotification.errorToast(context,
                description: state.failedMessage);
          }, taskWaitDuration: Durations.medium3);
        }
        if (state is CustomerListLoadedState) {
          return ListView.builder(
            itemCount: state.customerListResponseData?.length ?? 0,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  state.customerListResponseData![index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/edit-customer',
                        arguments: {'data': data});
                  },
                  textColor: Colors.white,
                  title: Text(data['name']),
                  subtitle: Text(data['mobile']),
                  trailing: IconButton(
                      style:
                          IconButton.styleFrom(foregroundColor: Colors.white),
                      onPressed: () {
                        BlocProvider.of<CustomerBloc>(context).add(
                            DeleteCustomerEvent(
                                customerId: data['id'].toString()));
                      },
                      icon: const Icon(
                        CupertinoIcons.delete,
                        size: 30,
                      )),
                ),
              );
            },
          );
        }
        if (state is CustomerListLoadingFailedState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageList.noInternetImage,
                  width: 150,
                  height: 150,
                ),
                Text(
                  state.errorMessage ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    );
  }
}
