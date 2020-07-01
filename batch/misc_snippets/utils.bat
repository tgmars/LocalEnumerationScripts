@echo off
REM List all available WMI classes
FOR /F %%A IN ('WMIC /? ^| FINDSTR /R /B /C:"[A-Z][A-Z][A-Z ][A-Z ][A-Z ][A-Z ][A-Z ][A-Z ][A-Z ][A-Z ][A-Z ][A-Z ]" ^| FINDSTR /R /B /V /C:"For more information"') DO (
	FOR /F "tokens=4" %%B IN ('WMIC ALIAS %%A Get Target /Value 2^>NUL ^| FIND "="') DO (
		ECHO.%%B
	)
)