class ConverterError extends Error{
  final String code;
  final String message;
  final String traceId;

  ConverterError(this.code, this.message, {this.traceId});

  ConverterError.defaultError({this.code = "DEFAULT", this.message = "Erro inesperado.", this.traceId});
}