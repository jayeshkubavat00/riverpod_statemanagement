import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statemanagement/modules/demo_repository_impl.dart';
import 'package:riverpod_statemanagement/modules/employee_models/employee_model.dart';
import 'package:riverpod_statemanagement/modules/enum/employee_enum.dart';

var employeeProvider =
    ChangeNotifierProvider.autoDispose((ref) => EmployeeProvider(ref));

class EmployeeProvider extends ChangeNotifier {
  Ref ref;
  EmployeeProvider(this.ref) {
    getEmployeeData();
  }
  EmployeeEnum employeeEnum = EmployeeEnum.initial;
  late EmployeeModel employeeModel;
  EmployeeModel? get employee => employeeModel;

  getEmployeeData() async {
    await ref.read(demoRepository).getEmployeeData().then(
      (response) {
        employeeEnum = EmployeeEnum.dataLoading;
        notifyListeners();
        response.fold(
          (error) => {throw error},
          (res) => {
            if (res.data != null)
              {
                employeeModel = EmployeeModel(
                  data: res.data,
                  message: res.message,
                  status: res.status,
                ),
                employeeEnum = EmployeeEnum.dataLoaded,
                notifyListeners(),
              }
            else
              {
                employeeEnum = EmployeeEnum.dataError,
                throw Exception(res.message.toString()),
              }
          },
        );
      },
    );
  }
}
