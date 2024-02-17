import 'dart:io';

Future<void> main(List<String> arguments) async {
  var result = await Process.run('dart', [
    'run',
    'nyxx_commands:compile',
  ]);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}
