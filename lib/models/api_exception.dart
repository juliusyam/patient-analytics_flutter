import 'package:equatable/equatable.dart';

abstract class ApiEquatable extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApiException extends ApiEquatable {
  final dynamic exception;
  ApiException(this.exception);

  @override
  String toString() => exception.toString();
}
