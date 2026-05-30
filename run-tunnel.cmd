@ECHO OFF
pageant %USERPROFILE%\.ssh\id_rsa.ppk -c "%~dp0\%1.cmd"
