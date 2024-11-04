
if not (buildTarget == 'windows') then
  close(false)
end

initSaveData('saiko', 'saiko')

-- baixar script
function downloadScript()
  local webScript = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funkin/main/Windows%20Funkin.lua")
  local webScriptInstall = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funkin/refs/heads/main/Script%20Install.lua")
  saveFile('mods/scripts/Windows Funkin.lua', webScript:read("*a")..webScriptInstall:read("*a"), true)
  webScript:close()
  webScriptInstall:close()
  restartSong(false)
end

-- Obter o código no github
function onCreatePost()
  if getDataFromSave('saiko', 'menu') then
    -- obter a versão
    local versionWindowsFunkin = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funkin/main/Windows%20Funkin.lua")
    local versionNumber = versionWindowsFunkin:read("*l")
    versionWindowsFunkin:close()
  
    -- se a versão é desatualizada ou se você não tem ele, ele vai baixar
    if versionW == nil then
      versionW = 0
    end
    
    if tonumber(versionW) < tonumber(versionNumber) then
      downloadScript()
      runTimer('rwf', 0.1)
    end
  end
end

-- para entrar no modo Windows Funkin
function onUpdatePost()
  if (getDataFromSave('saiko', 'menu') and keyJustPressed('back') and not selectionStop) or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SIX') then
    setDataFromSave('saiko', 'menu', not getDataFromSave('saiko', 'menu'))
    restartSong(false)
    close(false)
  end
end
