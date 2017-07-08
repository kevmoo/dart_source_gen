// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

void main() {
  LibraryElement library;

  setUpAll(() async {
    final resolver = await resolveSource(r'''
      library test_lib;
      
      class Example {}
    ''', inputId: new AssetId('test_lib', 'lib/test_lib.dart'));
    library = resolver.getLibraryByName('test_lib');
  });

  test('should highlight the use of "class Example"', () {
    expect(
        spanForElement(library.getType('Example')).message('Here it is'),
        ''
        'line 3, column 13 of package:test_lib/test_lib.dart: Here it is\n'
        '      class Example {}\n'
        '            ^^^^^^^');
  });
}
