@echo off
"C:\\Users\\Nguyen Phi Nhung\\AppData\\Local\\Android\\Sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\groovy" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=21" ^
  "-DANDROID_PLATFORM=android-21" ^
  "-DANDROID_ABI=x86" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86" ^
  "-DANDROID_NDK=C:\\Users\\Nguyen Phi Nhung\\AppData\\Local\\Android\\Sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\Nguyen Phi Nhung\\AppData\\Local\\Android\\Sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\Nguyen Phi Nhung\\AppData\\Local\\Android\\Sdk\\ndk\\27.0.12077973\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\Nguyen Phi Nhung\\AppData\\Local\\Android\\Sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=D:\\KY_THUAT_LAP_TRINH\\LTDD\\doan_29_4\\doan\\doan\\doan\\android\\app\\build\\intermediates\\cxx\\Debug\\663p6s5k\\obj\\x86" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=D:\\KY_THUAT_LAP_TRINH\\LTDD\\doan_29_4\\doan\\doan\\doan\\android\\app\\build\\intermediates\\cxx\\Debug\\663p6s5k\\obj\\x86" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BD:\\KY_THUAT_LAP_TRINH\\LTDD\\doan_29_4\\doan\\doan\\doan\\android\\app\\.cxx\\Debug\\663p6s5k\\x86" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
