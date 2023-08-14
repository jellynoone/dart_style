// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_style/src/cli/format_command.dart';

void main(List<String> arguments) async {
  var runner = CommandRunner<int>(
      'command_shell', 'Idiomatically format Dart source code.');
  runner.argParser.addFlag('verbose',
      abbr: 'v', negatable: false, help: 'Show verbose help.');
  runner.addCommand(FormatCommand(
      verbose: arguments.contains('-v') || arguments.contains('--verbose')));

  // Always run the "format" command.
  arguments = ['format', ...arguments];

  try {
    await runner.runCommand(runner.parse(arguments));
  } on UsageException catch (exception) {
    stderr.writeln(exception);
    exit(64);
  }
}
