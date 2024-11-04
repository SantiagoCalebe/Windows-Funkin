
if not (buildTarget == 'windows') then
  close(false)
end

initSaveData('saiko', 'saiko')

--baixar script
function downloadScript()
  local webScript = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funk/main/Windows%20Funkin.lua")
  local webScriptInstall = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funk/refs/heads/main/Windows%20Funkin%20Install.lua")
  saveFile('mods/scripts/Windows Funkin.lua', webScript:read("*a")..'\n'..webScriptInstall:read("*a"), true)
  webScript:close()
  webScriptInstall:close()
end

--Obter o código no github
if getDataFromSave('saiko', 'menu') then
  --obter a versão
  local loadCode = (load)
  local versionWindowsFunkin = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funk/refs/heads/main/version.txt")
  local versionNumber = versionWindowsFunkin:read("*a")

  --se a versão é desatualizada ou se você não tem ele, ele vai baixar
  if versionW == nil then
    versionW = 0
  end
  
  if versionW < tonumber(versionNumber) then
    downloadScript()
    runTimer('rwf', 0.1)
  end

  versionW:close()
end

--para entrar no modo Windows Funkin
function onUpdatePost()
  if (getDataFromSave('saiko', 'menu') and keyJustPressed('back') and not selectionStop) or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SIX') then
    setDataFromSave('saiko', 'menu', not getDataFromSave('saiko', 'menu'))
    restartSong(false)
    close(false)
  end
end

--reniciar caso baixe o script
function onTimerCompleted(tag)
  if tag == 'rwf' then
    restartSong(false)
  end
end
