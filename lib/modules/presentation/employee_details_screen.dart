// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statemanagement/modules/enum/employee_enum.dart';
import 'package:toast/toast.dart';

import '../providers/employee_provider.dart';

class EmployeeDetailsScreen extends ConsumerWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(employeeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Employee Details")),
      body: SafeArea(
        child: data.employeeEnum == EmployeeEnum.dataLoading ||
                data.employeeEnum == EmployeeEnum.initial
            ? const Center(child: CircularProgressIndicator())
            : data.employeeEnum == EmployeeEnum.dataError
                ? Center(child: Text(data.employee!.message.toString()))
                : ListView.builder(
                    itemCount: data.employee!.data!.length,
                    itemBuilder: (context, index) {
                      final empData = data.employee!.data![index];
                      return ListTile(
                        title: Text(
                          "Employee Name: ${empData.employeeName}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          "Age: ${empData.id} \nSalary: ${empData.employeeSalary}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, size: 20),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 20),
                              onPressed: () {
                                if (empData.id != null) {
                                } else {
                                  Toast.show(
                                    "Employee ID is missing",
                                    duration: 2,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
