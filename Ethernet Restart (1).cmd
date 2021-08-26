@echo off

::# Definir DefaultGateway
    :def
    for /f "tokens=3" %%* in (
    'route.exe print ^|findstr "\<0.0.0.0\>"'
    ) Do @Set "DefaultGateway=%%*"

    echo %DefaultGateway%


::# Teste na conexao
    :con

     timeout /t 05
      ping %DefaultGateway% -n 1 | find /i "bytes=32"

      if errorlevel 1 (

        goto :def
        ) else (
        goto :ping
      )




::# Faz ping no DefaultGateway e da restart caso ping nao retornar

    :ping
	   timeout /t 10
	    ping %DefaultGateway% -n 1 | find /i "bytes=32"

      if errorlevel 1 (

        echo "Restart em 10 segundos"
	      timeout /t 10
        shutdown -f -r -t 00
        ) else (
        goto :ping
      )

pause
