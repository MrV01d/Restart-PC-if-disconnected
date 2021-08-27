@echo off

::# Sets the DefaultGateway var
    :def
    for /f "tokens=3" %%* in (
    'route.exe print ^|findstr "\<0.0.0.0\>"'
    ) Do @Set "DefaultGateway=%%*"

    echo %DefaultGateway%


::# Connection test
    :con

     timeout /t 05
      ping %DefaultGateway% -n 1 | find /i "bytes=32"

      if errorlevel 1 (

        goto :def
        ) else (
        goto :ping
      )




::# Pings the DefaultGateway and restarts the pc if the ping is not responding

    :ping
	   timeout /t 10
	    ping %DefaultGateway% -n 1 | find /i "bytes=32"

      if errorlevel 1 (

        echo "Restarting the PC"
	      timeout /t 10
        shutdown -f -r -t 00
        ) else (
        goto :ping
      )

pause
