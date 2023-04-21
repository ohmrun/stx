package stx.config.core;

enum abstract Source(String) to String{
  final SourceCli;
  final SourceEnv;
  final SourceJson;
}