import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statemanagement/modules/employee_models/employee_model.dart';
import 'package:riverpod_statemanagement/modules/failure.dart';
import 'package:riverpod_statemanagement/services/api_services_impl.dart';

var demoRepository = Provider<DemoRepository>((ref) => DemoRepository());

class DemoRepository {
  Future<Either<Failure, EmployeeModel>> getEmployeeData() async {
    try {
      final response = await ApiServiceImpl().getRequest(
          endpoint: "https://dummy.restapiexample.com/api/v1/employees");
      if (response.statusCode == 200) {
        return Right(EmployeeModel.fromJson(response.data));
      } else {
        return Left(Failure(message: response.data['message']));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
