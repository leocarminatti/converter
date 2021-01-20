import 'dart:io';

import 'package:currency_converter/domain/error/converter_error.dart';
import 'package:dio/dio.dart';

const String UNEXPECTED_ERROR = "UNEXPECTED_ERROR";
const String TIMEOUT_ERROR = "TIMEOUT_ERROR";
const String CONNECTIVITY_ERROR = "CONNECTIVITY_ERROR";

class ErrorMapper {
  static final timeOutError = ConverterError(
      TIMEOUT_ERROR, "O tempo de conexão com o servidor foi excedido, verifique sua conexão com a internet.");
  static final connectivityError = ConverterError(
      CONNECTIVITY_ERROR, "Não foi possível estabelecer conexão com o servidor, verifique sua conexão com a internet.");

  static ConverterError toConsultantError(dynamic error) {
    if (error is DioError) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT ||
          error.type == DioErrorType.SEND_TIMEOUT) return timeOutError;
      if (error?.error is SocketException) return connectivityError;
      if (error.response != null) {
        try {
          return ConverterError(error.response.data["code"], error.response.data["message"],
              traceId: error.response.data["traceId"]);
        } catch (e) {
          return ConverterError.defaultError();
        }
      }
    }
    return ConverterError.defaultError();
  }
}