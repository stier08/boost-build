rem set PATH=P:\Portable_Python_3.2.5.1\App;P:\Portable_Python_3.2.5.1\App\Scripts;%PATH%
set PATH=P:\WinPython-32bit-3.4.4.7Zero\python-3.4.4;P:\WinPython-32bit-3.4.4.7Zero\python-3.4.4\Scripts;%PATH%
rem set PATH=D:\Python34;D:\Python34\Scripts;%PATH%

set VS150COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\


set BOOST_ROOT=D:\LIBS\boost\boost-1_65_1_vs2017_wp34
set BOOST_BUILD_ROOT=%BOOST_ROOT%
set BOOST_TARGET_ROOT=%BOOST_ROOT%
call "%VS150COMNTOOLS%..\..\VC\Auxiliary\Build\vcvars32.bat"
cd /d %BOOST_ROOT%

if exist b2.exe (
echo "b2.exe exists"
) else (
 call bootstrap.bat --with-libraries=python
)
rem call bootstrap.bat

set vsMainVersion=14.1
set BuildDir=%BOOST_BUILD_ROOT%\build
set PrefixDir=%BOOST_TARGET_ROOT%
set IncludeDir=%BOOST_TARGET_ROOT%\include
set LibDir=%BOOST_TARGET_ROOT%\lib

echo "===============Building With Python Libraries========================================================="
b2 ^
  --build-dir=%BuildDir% ^
  --prefix=%PrefixDir% ^
  --includedir=%IncludeDir% ^
  --libdir=%LibDir% ^
  --with-python ^
  --build-type=complete ^
  link=shared ^
  toolset=msvc-%vsMainVersion% ^
  stage install


echo "===============Building Without Python Libraries========================================================="

b2 ^
  --build-dir=%BuildDir% ^
  --prefix=%PrefixDir% ^
  --includedir=%IncludeDir% ^
  --libdir=%LibDir% ^
  --without-python ^
  --without-mpi ^
  link=shared ^
  toolset=msvc-%vsMainVersion% ^
  stage install



