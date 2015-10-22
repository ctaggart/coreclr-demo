# restore packages
./paket.bootstrapper.exe
./paket.exe restore

# make sure C# Compiler is on your PATH
$env:path = "C:\Program Files (x86)\MSBuild\14.0\Bin\amd64\csc.exe;$env:path"

# compile against the reference assemblies
if(-not(test-path bin)){ md bin }
csc /nostdlib /noconfig `
  /r:packages\System.Runtime\ref\dotnet\System.Runtime.dll `
  /r:packages\System.Console\ref\dotnet\System.Console.dll `
  /out:bin/HelloWorld.dll HelloWorld.cs

# copy CoreConsole.exe to be HelloWorld.exe
copy packages\Microsoft.NETCore.Runtime.CoreCLR.ConsoleHost-x64\runtimes\win7-x64\native\CoreConsole.exe bin\HelloWorld.exe

# CoreCLR
copy packages\Microsoft.NETCore.Runtime.CoreCLR-x64\runtimes\win7-x64\native\*.dll bin
copy packages\Microsoft.NETCore.Runtime.CoreCLR-x64\runtimes\win7-x64\lib\dotnet\mscorlib.ni.dll bin

# implementations of compile time dependencies
copy packages\System.Runtime\lib\DNXCore50\System.Runtime.dll bin
copy packages\runtime.win7.System.Console\runtimes\win7\lib\dotnet\System.Console.dll bin

# runtime dependencies
copy packages\System.IO\lib\DNXCore50\System.IO.dll bin
copy packages\System.IO.FileSystem.Primitives\lib\dotnet\System.IO.FileSystem.Primitives.dll bin
copy packages\System.Runtime.InteropServices\lib\DNXCore50\System.Runtime.InteropServices.dll bin
copy packages\System.Text.Encoding\lib\DNXCore50\System.Text.Encoding.dll bin
copy packages\System.Threading\lib\DNXCore50\System.Threading.dll bin
copy packages\System.Threading.Tasks\lib\DNXCore50\System.Threading.Tasks.dll bin
copy packages\System.Text.Encoding.Extensions\lib\DNXCore50\System.Text.Encoding.Extensions.dll bin

# run HelloWorld!
./bin/HelloWorld.exe
