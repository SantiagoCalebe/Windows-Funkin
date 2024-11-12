if versionW == nil then
  versionW = 0
end

if not (buildTarget == 'windows') then
  removeLuaScript(scriptName, true)
end

initSaveData('saiko', 'saiko')

-- baixar script
function downloadScript()
  local webScript = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funkin/main/Windows%20Funkin.lua")
  local webScriptInstall = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funkin/refs/heads/main/Script%20Install.lua")
  saveFile(scriptName, webScript:read("*a")..'\n'..webScriptInstall:read("*a"), true)
  webScript:close()
  webScriptInstall:close()
end

-- Obter o código no github
if getDataFromSave('saiko', 'menu') then
  -- obter a versão
  local versionWindowsFunkin = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funkin/main/Windows%20Funkin.lua")
  local versionNumber = versionWindowsFunkin:read("*l")
  local versionNumber = versionNumber:match("(%d+%.%d+)")
  versionWindowsFunkin:close()

  -- se a versão é desatualizada ou se você não tem ele, ele vai baixar
  if tonumber(versionW) < tonumber(versionNumber) then
    downloadScript()
    runTimer('rwf', 0.1)
  end
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
