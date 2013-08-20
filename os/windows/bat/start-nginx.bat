@ECHO OFF
c:\nginx\nginx.exe
REM 在windows批处理文件里rem就是注释知道么
REM c:\php\php-cgi.exe -b 127.0.0.1:9000 -c c:\php\php.ini
ECHO Starting PHP FastCGI...
set PATH=D:\wamp\bin\php\php5.3.5;%PATH%
c:\RunHiddenConsole.exe D:\wamp\bin\php\php5.3.5\php-cgi.exe -b 127.0.0.1:9000
REM 最好是 c:\RunHiddenConsole.exe D:\wamp\bin\php\php5.3.5\php-cgi.exe -b 127.0.0.1:9000 -c D:\wamp\bin\php\php5.3.5\php.ini
REM 后面的-c参数不要也可以
ping 127.0.0.1 -n 1>NUL
echo Starting nginx
echo .
echo .
echo .
ping 127.0.0.1 >NUL
EXIT