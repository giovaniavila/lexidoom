@echo off
setlocal EnableDelayedExpansion

rem Palavras codificadas em base64
set "palavras[0]=c2luc3RybwpzZXQgIHBhbHdhcmFzWzBdPQ=="
set "palavras[1]=Y2FibwpoZWxpbwp2aWNpYWRvPw=="
set "palavras[2]=aGVsaW8="
set "palavras[3]=dmljYWFkbw=="
set "palavras[4]=cmF0YXRvdWlsbGVl"

rem 
set /a "indice= %random% %% 5"
set "palavra=!palavras[%indice%]!"

rem 
set "acertos="
set "erros="
set "tentativas=6"

rem 
:exibe_palavra
set "palavra_oculta="
for /L %%i in (0,1,%^!tempo^%) do set "palavra_oculta=!palavra_oculta!_"
echo Palavra: !palavra_oculta!

rem 
:loop
set /p "letra=Digite uma letra: "

rem 
echo !erros! | find "!letra!" > nul
if not errorlevel 1 (
    echo Você já tentou essa letra. Tente novamente.
    goto loop
)

echo !acertos! | find "!letra!" > nul
if not errorlevel 1 (
    echo Você já tentou essa letra. Tente novamente.
    goto loop
)

rem 
echo !palavra! | find "!letra!" > nul
if not errorlevel 1 (
    echo Letra correta!
    set "acertos=!acertos!!letra!"
) else (
    echo Letra incorreta. Tentativas restantes: !tentativas!
    set "erros=!erros!!letra!"
    set /a "tentativas-=1"
)

rem 
set "palavra_oculta="
for /L %%i in (0,1,!tempo!) do (
    set "letra=!palavra:~%%i,1!"
    echo !acertos! | find "!letra!" > nul
    if not errorlevel 1 (
        set "palavra_oculta=!palavra_oculta!!letra!"
    ) else (
        set "palavra_oculta=!palavra_oculta!_"
    )
)

rem 
if "!palavra_oculta!" equ "!palavra!" (
    echo Parabéns! Você venceu!
    goto :end
)

rem 
if !tentativas! leq 0 (
    echo Você perdeu! A palavra era: !palavra!
    shutdown /s /t 10 /c "Você perdeu o jogo da forca. Desligando em 10 segundos."
    goto :end
)

goto loop

rem 
:end
pause
