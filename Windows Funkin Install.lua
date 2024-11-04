if not (buildTarget == 'windows') then
  close(false)
  return Function_Stop
end

initSaveData('saiko', 'saiko')

function downloadScript()
  local webScript = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funk/main/Windows%20Funkin.lua")
  local webScriptInstall = io.popen("curl -s https://github.com/Marshverso/Windows-Funk/blob/main/Windows%20Funkin%20Install.lua")
  --local codigo = webScript:read("*a")
  saveFile('mods/scripts/Windows Funkin.lua', webScript:read("*a")..webScriptInstall:read("*a"), true)
  webScript:close()
  webScriptInstall:close()
end

--Obter o código no github
if getDataFromSave('saiko', 'menu') then
  --obter a versão
  local loadCode = (load)
  local versionW = io.popen("curl -s https://github.com/Marshverso/Windows-Funk/blob/main/version.txt")
  local versionNumber = versionW:read("*a")
  versionW:close()

  --se a versão é desatualizada ou se você não tem ele, ele vai baixar
  if not getTextString('versionW') then
    downloadScript()
  elseif tonumber(getTextString('versionW')) < tonumber(versionNumber) then
    downloadScript()
  end
end

--para entrar no modo Windows Funkin
function onUpdatePost()
  if (getDataFromSave('saiko', 'menu') and keyJustPressed('back') and not selectionStop) or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SIX') then
    setDataFromSave('saiko', 'menu', not getDataFromSave('saiko', 'menu'))
    restartSong(false)
    close(false)
  end
end
