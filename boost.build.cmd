rem set PATH=P:\WinPython-32bit-3.4.4.7Zero\python-3.4.4;P:\WinPython-32bit-3.4.4.7Zero\python-3.4.4\Scripts;%PATH%
set PATH=P:\WinPython-32bit-3.6.2.0Zero\python-3.6.2;P:\WinPython-32bit-3.6.2.0Zero\python-3.6.2\Scripts;%PATH%
rem set PATH=D:\Python34;D:\Python34\Scripts;%PATH%

set VS150COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\

rem http://www.boost.org/build/doc/html/bbv2/overview/invocation.html
set BOOST_ROOT=D:\LIBS\boost\boost-1_65_1_vs2017_wp36
set BOOST_BUILD_ROOT=%BOOST_ROOT%
set BOOST_TARGET_ROOT=%BOOST_ROOT%
set BOOST_BUILD_CONFIG=--debug-configuration  --debug-building --debug-generators -d 5
set BOOST_BUILD_CONFIG=

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
set BOOST_THEADING=multi
set BOOST_RUNTIME_LINK=shared
rem (static|shared)
set BOOST_LINK=shared


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
  threading=%BOOST_THEADING% ^
  runtime-link=%BOOST_RUNTIME_LINK% ^
  link=%BOOST_LINK% ^
  toolset=msvc-%vsMainVersion% ^
  %B2_DEFINES% ^
  stage install

echo "===============Python Libraries Done========================================================="

exit 0

echo "===============Building With test Libraries========================================================="
b2 ^
  --build-dir=%BuildDir% ^
  --prefix=%PrefixDir% ^
  --includedir=%IncludeDir% ^
  --libdir=%LibDir% ^
  --with-test ^
  --build-type=complete ^
  %BOOST_BUILD_CONFIG% ^
  threading=%BOOST_THEADING% ^
  runtime-link=%BOOST_RUNTIME_LINK% ^
  link=%BOOST_LINK% ^
  toolset=msvc-%vsMainVersion% ^
  %B2_DEFINES% ^
  stage install

exit 0

echo "===============Building With regex Libraries========================================================="
b2 ^
  --build-dir=%BuildDir% ^
  --prefix=%PrefixDir% ^
  --includedir=%IncludeDir% ^
  --libdir=%LibDir% ^
  --with-regex ^
  --build-type=complete ^
  %BOOST_BUILD_CONFIG% ^
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
  threading=%BOOST_THEADING% ^
  runtime-link=%BOOST_RUNTIME_LINK% ^
  link=%BOOST_LINK% ^
  toolset=msvc-%vsMainVersion% ^
  %B2_DEFINES% ^
  stage install

:exitlabel

