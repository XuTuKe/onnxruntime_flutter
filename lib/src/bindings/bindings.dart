import 'dart:ffi';
import 'dart:io';
import 'package:onnxruntime/src/bindings/onnxruntime_bindings_generated.dart';

final DynamicLibrary _dylib = () {
  if (Platform.isAndroid) {
    return DynamicLibrary.open('libonnxruntime.so');
  }

  if (Platform.isIOS) {
    return DynamicLibrary.process();
  }

  if (Platform.isLinux) {
    return DynamicLibrary.open('libonnxruntime.so.1.16.1');
  } else if (Platform.isMacOS) {
    return DynamicLibrary.open('libonnxruntime.1.16.1.dylib');
  } else if (Platform.isWindows) {
    return DynamicLibrary.open('onnxruntime-x64.dll');
  }

  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// OnnxRuntime Bindings
final onnxRuntimeBinding = OnnxRuntimeBindings(_dylib);
