SET PYTHONHOME=D:\Soft\Python\35\WinPython-32bit-3.5.3.0Zero\python-3.5.3
set PATH=%PYTHONHOME%;%PYTHONHOME%\Scripts;%PATH%


set BOOST_ROOT=D:\LIBS\boost\boost-1_63_0_vs2015_wp35
set BOOST_BUILD_ROOT=%BOOST_ROOT%
set BOOST_TARGET_ROOT=%BOOST_ROOT%
call "%VS140COMNTOOLS%\..\..\VC\bin\vcvars32.bat"
cd /d %BOOST_ROOT%

set vsMainVersion=14.0
set BuildDir=%BOOST_BUILD_ROOT%\build
set PrefixDir=%BOOST_TARGET_ROOT%
set IncludeDir=%BOOST_TARGET_ROOT%\include
set LibDir=%BOOST_TARGET_ROOT%\lib
echo "========================================================================"
rem call bootstrap.bat --with-libraries=python
rem b2 ^
rem  --build-dir=%BuildDir% ^
rem  --prefix=%PrefixDir% ^
rem  --includedir=%IncludeDir% ^
rem  --libdir=%LibDir% ^
rem  --with-python ^
rem  --build-type=complete ^
rem  link=shared ^
rem  toolset=msvc-%vsMainVersion% ^
rem  stage install

call bootstrap.bat
b2 ^
  --build-dir=%BuildDir% ^
  --prefix=%PrefixDir% ^
  --includedir=%IncludeDir% ^
  --libdir=%LibDir% ^
  --build-type=complete ^
  link=shared ^
  toolset=msvc-%vsMainVersion% ^
  stage install
