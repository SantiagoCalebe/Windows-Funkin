if versionW == nil then
  versionW = 0
end

function onCreatePost()
  initSaveData('saiko', 'saiko')

  if not getDataFromSave('saiko', 'menu') then
    return Function_Stop
  end

  -- Obter o código no github
  local versionWindowsFunkin = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funkin/main/Windows%20Funkin.lua")
  local versionNumber = versionWindowsFunkin:read("*l")
  local versionNumber = versionNumber:match("(%d+%.%d+)")
  versionWindowsFunkin:close()

    -- se a versão é desatualizada ou se você não tem ele, ele vai baixar
  if tonumber(versionW) < tonumber(versionNumber) then
    downloadScript()
    runTimer('rwf', 0.1)
  end

  --translator by Marshverso
  verseTranslate('title', 'portuguese', 'WINDOWS FUNK')
  verseTranslate('va', 'portuguese', 'Verificar arquivos')
  verseTranslate('vh', 'portuguese', 'Verificar armazenamento') --professora de português é foda
  verseTranslate('vr', 'portuguese', 'Verificar ram (REINICIAR PC)')
  verseTranslate('rm', 'portuguese', "Remover marca d'água do windows (REINICIAR PC)")
  verseTranslate('desfrag', 'portuguese', 'Otimizar armazenamento')
  verseTranslate('cache', 'portuguese', 'Limpar cache')
  verseTranslate('dn', 'portuguese', 'Limpar arquivos inúteis')
  verseTranslate('odp', 'portuguese', 'Opções de desempenho')
  verseTranslate('ld', 'portuguese', 'Limpar dns')
  verseTranslate('sb', 'portuguese', 'Emulador do windows (REINICIAR PC)')
  verseTranslate('an', 'portuguese', 'Ativar núcleos')

  verseTranslate('storage', 'portuguese', 'DIGITE A LETRA DO SEU ARMAZENAMENTO')

  --translator by Erislwlol and FacheFNF
  verseTranslate('title', 'spanish', 'WINDOWS FUNK')
  verseTranslate('va', 'spanish', 'Buscar archivos dañados')
  verseTranslate('vh', 'spanish', 'Comproba si el disco está dañado') --professora de espanhol é foda
  verseTranslate('vr', 'spanish', 'Comprobar ram (PC RESET)')
  verseTranslate('rm', 'spanish', "Eliminar marca de agua de Windows (REINICIA EL PC)")
  verseTranslate('desfrag', 'spanish', 'Optimice su disco')
  verseTranslate('cache', 'spanish', 'Borrar la caché')
  verseTranslate('dn', 'spanish', 'Eliminar archivos inútiles')
  verseTranslate('odp', 'spanish', 'Opciones de rendimiento')
  verseTranslate('ld', 'spanish', 'Borrar dns')
  verseTranslate('sb', 'spanish', 'Emulador de windows (REINICIA EL PC)')
  verseTranslate('an', 'spanish', 'Habilitar núcleos')

  verseTranslate('storage', 'spanish', 'INGRESA LA LETRA DE TU ALMACENAMIENTO')
  --Lo siento por cualquier cosa mal, lo hice para practicar mi español un poco

  doTweenAlpha('camOtherAl', 'camOther', 1, 5, 'sineInOut')
  selectionOp()
  discord('WINDOWS FUNKIN', 'SELECT:'..getTextString(options.option[selection]))
end

-- baixar script
function downloadScript()
  local webScript = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funkin/main/Windows%20Funkin.lua")
  local webScriptInstall = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funkin/refs/heads/main/Script%20Install.lua")
  saveFile(scriptName, webScript:read("*a")..'\n'..webScriptInstall:read("*a"), true)
  webScript:close()
  webScriptInstall:close()
end

-- para entrar no modo Windows Funkin
function onUpdate()
  if (getDataFromSave('saiko', 'menu') and keyJustPressed('back') and not selectionStop) or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SIX') then
    setDataFromSave('saiko', 'menu', not getDataFromSave('saiko', 'menu'))
    restartSong(false)
    close(false)
  end
end

-- reiniciar caso baixe o script
function onTimerCompleted(tag)
  if tag == 'rwf' then
    restartSong(false)
  end
end
