rem https://stackoverflow.com/questions/2715164/how-can-i-decode-the-boost-library-naming
set PYTHONHOME=%PORTABLE_WS_APP_HOME%\Winpython64-3.8.7.0dot\python-3.8.7.amd64
rem set PYTHONHOME=P:\WinPython-32bit-3.4.4.7Zero\python-3.4.4
set PATH=%PYTHONHOME%;%PYTHONHOME%\Scripts;%PATH%
rem set PATH=D:\Python34;D:\Python34\Scripts;%PATH%

set VS160COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\

rem http://www.boost.org/build/doc/html/bbv2/overview/invocation.html
set BOOST_ROOT=E:\LIBS\boost\boost-1_75_0_vs2019_toolset_v142_wp38
set BOOST_BUILD_ROOT=%BOOST_ROOT%
set BOOST_TARGET_ROOT=%BOOST_ROOT%
set BOOST_BUILD_CONFIG=
set BOOST_BUILD_CONFIG=--debug-configuration  --debug-building --debug-generators -d 2
SET BOOST_ARCHITECTURE=x86
SET BOOST_ADDRESS_MODEL=64
python -c "from sys import *; print('version=%d.%d\nplatform=%s\nprefix=%s\nexec_prefix=%s\nexecutable=%s' % (version_info[0],version_info[1],platform,prefix,exec_prefix,executable))" 2>&1


call "%VS160COMNTOOLS%..\..\VC\Auxiliary\Build\vcvars32.bat"
cd /d %BOOST_ROOT%

if exist b2.exe (
echo "b2.exe exists"
) else (
 call bootstrap.bat --with-libraries=python
)
rem call bootstrap.bat

set vsMainVersion=14.2
set BuildDir=%BOOST_BUILD_ROOT%\build
set PrefixDir=%BOOST_TARGET_ROOT%
set IncludeDir=%BOOST_TARGET_ROOT%\include
set LibDir=%BOOST_TARGET_ROOT%\lib
set BOOST_THEADING=multi
rem https://stackoverflow.com/questions/7508369/boost-libs-building-difference-between-runtime-link-and-link-options
set BOOST_RUNTIME_LINK=static
rem (static|shared)
set BOOST_LINK=static


if "%BOOST_LINK%"=="static" (
set B2_DEFINES=define=BOOST_TEST_NO_MAIN define=BOOST_TEST_ALTERNATIVE_INIT_API
) else (
set B2_DEFINES=
)


:dobuilding

echo "===============Building With Python Libraries========================================================="
b2 ^
  --build-dir=%BuildDir% ^
  --prefix=%PrefixDir% ^
  --includedir=%IncludeDir% ^
  --libdir=%LibDir% ^
  --with-python ^
  --build-type=complete ^
  %BOOST_BUILD_CONFIG% ^
  architecture=%BOOST_ARCHITECTURE% ^
  address-model=%BOOST_ADDRESS_MODEL% ^
  threading=%BOOST_THEADING% ^
  runtime-link=%BOOST_RUNTIME_LINK% ^
  link=%BOOST_LINK% ^
  toolset=msvc-%vsMainVersion% ^
  %B2_DEFINES% ^
  stage install

echo "===============Python Libraries Done========================================================="


echo "===============Building With test Libraries========================================================="
b2 ^
  --build-dir=%BuildDir% ^
  --prefix=%PrefixDir% ^
  --includedir=%IncludeDir% ^
  --libdir=%LibDir% ^
  --with-test ^
  --build-type=complete ^
  %BOOST_BUILD_CONFIG% ^
  architecture=%BOOST_ARCHITECTURE% ^
  address-model=%BOOST_ADDRESS_MODEL% ^
  threading=%BOOST_THEADING% ^
  runtime-link=%BOOST_RUNTIME_LINK% ^
  link=%BOOST_LINK% ^
  toolset=msvc-%vsMainVersion% ^
  %B2_DEFINES% ^
  stage install



echo "===============Building With regex Libraries========================================================="

b2 ^
  --build-dir=%BuildDir% ^
  --prefix=%PrefixDir% ^
  --includedir=%IncludeDir% ^
  --libdir=%LibDir% ^
  --with-regex ^
  --build-type=complete ^
  %BOOST_BUILD_CONFIG% ^
  architecture=%BOOST_ARCHITECTURE% ^
  address-model=%BOOST_ADDRESS_MODEL% ^
  threading=%BOOST_THEADING% ^
  runtime-link=%BOOST_RUNTIME_LINK% ^
  link=%BOOST_LINK% ^
  toolset=msvc-%vsMainVersion% ^
  %B2_DEFINES% ^
  stage install

echo "===============Building Without Python Libraries========================================================="

b2 ^
  --build-dir=%BuildDir% ^
  --prefix=%PrefixDir% ^
  --includedir=%IncludeDir% ^
  --libdir=%LibDir% ^
  --without-python ^
  --without-mpi ^
  %BOOST_BUILD_CONFIG% ^
  architecture=%BOOST_ARCHITECTURE% ^
  address-model=%BOOST_ADDRESS_MODEL% ^
  threading=%BOOST_THEADING% ^
  runtime-link=%BOOST_RUNTIME_LINK% ^
  link=%BOOST_LINK% ^
  toolset=msvc-%vsMainVersion% ^
  %B2_DEFINES% ^
  stage install

:exitlabel

