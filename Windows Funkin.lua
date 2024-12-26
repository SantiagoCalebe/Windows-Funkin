local versionW = 11

local sysLanguage = os.setlocale(nil, 'collate'):lower()

local keys = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}

local colors = {'00ff99', '6666ff', 'ff3399', 'ff00ff', '00ffcc'}

local keyUnit = 'NAMEUNIT'

local option = {
  name = {
    'Check files', 
    'Check storage',
    'Check ram (PC RESET)',
    'Remove watermark',
    'Optimize storage',
    'Clear cache',
    'Clear junk files',
    'Performance options',
    'Anti-virus',
    'Clear dns',
    'Windows Emulator (PC RESET)',
    'storage life',
    'installed applications',
    'update applications',
    'system settings',
    'Remote connection',
    'maintenance (PC RESET)',
    'Update log'
  },

  cmd = {
    [[sfc /scannow && dism /online /cleanup-image /scanhealth && dism /online /cleanup-image /restorehealth]],
    [[chkdsk ]]..keyUnit..[[: /f /r /x]],
    [[mdsched.exe]],
    [[-NoProfile -ExecutionPolicy Bypass -Command \"Start-Process cmd -ArgumentList ''/c reg add \"\"HKEY_CURRENT_USER\\Control Panel\\Desktop\"\" /v PaintDesktopVersion /t REG_DWORD /d]],
    [[defrag ]]..keyUnit..[[: /O]],
    [[del /q/f/s %TEMP% && del /q/f/s TEMP\\*\]],
    [[cleanmgr]],
    [[SystemPropertiesPerformance]],
    [[mrt]],
    [[ipconfig /flushdns]],
    [[Dism /online /Enable-Feature /FeatureName:"Containers-DisposableClientVM" -All && Y]],
    [[wmic diskdrive get status]],
    [[explorer shell:AppsFolder]],
    [[winget upgrade --all]],
    [[msconfig]],
    [[mstsc]],
    [[msdt.exe /id MaintenanceDiagnostic]],
    [[start https://raw.githubusercontent.com/Marshverso/Windows-Funkin/refs/heads/main/log.txt]]
  },

  select = 1,
  stop = false
}

local translation = {
  --traduzido por marshverso
  portuguese = {
    option = {
      'Verificar arquivos',
      'Verificar armazenamento',
      'Verificar ram (REINICIAR PC)',
      "Remover marca d'água do windows",
      'Otimizar armazenamento',
      'Limpar cache',
      'Limpar arquivos inúteis',
      'Opções de desempenho',
      'Anti-virus',
      'Limpar dns',
      'Emulador do Windows (REINICIAR PC)',
      'Vida do armazenamento',
      'Aplicativos instalados',
      'Atualizar aplicativos',
      'Configurações do sistema',
      'Conexão remota',
      'Manutenção (REINICIAR PC)',
      'Lista das atualizações'
    }
  },

  --traduzido por Erislwlol e FacheFNF
  spanish = {
    option = {
    'Buscar archivos dañados',
    'Comproba si el disco está dañado',
    'Comprobar ram (PC RESET)',
    "Eliminar marca de agua de Windows",
    'Optimice su disco',
    'Borrar la caché',
    'Eliminar archivos inútiles',
    'Opciones de rendimiento',
    'Anti-virus',
    'Borrar dns',
    'Emulador de Windows (PC RESET)',
    'Vida del almacenamiento',
    'Aplicaciones instaladas',
    'Actualizar aplicaciones',
    'Configuraciones del sistema',
    'Conexión remota',
    'Mantenimiento (PC RESET)',
    'Registro de actualizaciones'
    }
  }
}

function onStartCountdown() if getDataFromSave('saiko', 'menu') then return Function_Stop end end

function discord(details, state)
  if tonumber(version:sub(1, 3)) >= 0.7 then
    changeDiscordPresence(details, state, nil, false)
  else
    changePresence(details, state, nil, false)
  end
end

function text(tag, text, width, x, y)
  makeLuaText(tag, text, width, x, y)
  setObjectCamera(tag, 'camOther')
  addLuaText(tag)
end

function makeGf(part, x, y, width, height, color)
  makeLuaSprite(part..'gf', nil, x+900, y+300)
  makeGraphic(part..'gf', width, height, color)
  setObjectCamera(part..'gf', 'camOther')
  addLuaSprite(part..'gf')
end

function cmd(cmd)
  io.popen([[powershell -Command "Start-Process cmd -ArgumentList '/c ]]..cmd..[[' -Verb RunAs"]])
  playSound('confirmMenu', 0.9)
end

function selectionOp()
  for i=1, #option.name do
    if option.select == i and not (getProperty(i..'option.color') == -256) then
      setProperty(i..'option.color', getColorFromHex('ffff00'))
      doTweenX(i..'optionSX', i..'.scale', 1.1, 0.2, 'sineIn')
    elseif not ((option.select == i) and (getProperty(i..'option.color') == -1)) then
      setProperty(i..'option.color', getColorFromHex('ffffff'))
      doTweenX(i..'optionSX', i..'option.scale', 1, 0.2, 'sineIn')
    end
  end

  if option.select <= 11 then
    for i=1, #option.name do
      if i <= 11 then
        setProperty(i..'option.visible', true)
      else
        setProperty(i..'option.visible', false)
      end
    end
  else
    for i=1, #option.name do
      if i >= 12 then
        setProperty(i..'option.visible', true)
      else
        setProperty(i..'option.visible', false)
      end
    end
  end
end

function onCreate()
  initSaveData('saiko', 'saiko')

  if not getDataFromSave('saiko', 'menu') then
    return Function_Stop
  end

  setProperty('camGame.visible', false)
  setProperty('camHUD.visible', false)
  setProperty('camOther.alpha', 0)

  text('versionW', 'v'..versionW, 100, 10, 2)
  setTextSize('versionW', 40)
  screenCenter('versionW', 'x')

  text('title', 'WINDOWS\nFUNKIN', 500, screenWidth, 50)
  setTextSize('title', 100)
  setTextAlignment('title', 'center')
  screenCenter('title', 'y')

  text('seta1', '>', 70, 355, 50)
  setProperty('seta1.angle', -90)
  setTextSize('seta1', 50)

  text('seta2', '>', 70, 355, 630)
  setProperty('seta2.angle', 90)
  setTextSize('seta2', 50)

  --add options
  for i, op in ipairs(option.name) do
    if i == 1 or i%12 == 0 then
      text(i..'option', op, 750, 10, 100)
    else
      text(i..'option', op, 750, 10, getProperty((i-1)..'option.y') + 50)
    end

    setObjectOrder(i..'option', 10)
    setTextSize(i..'option', 30)

    if i >= 12 then
      setProperty(i..'option.visible', false)
    end
  end
  
  text('credits', 'Creator: Marshverso (YT and DC)     Menu design: FacheFNF (DC) and Marshverso (YT and DC)     Tradutor português: Marshverso (YT and DC)     English Translators: FacheFNF (DC) and Marshverso (YT and DC)     Traductores español: Erislwlol(X) y FacheFNF (DC)     Beta Testers: FandeFNF (ST) and Erislwlol(X)', 0, screenWidth, screenHeight - 37)
  setTextSize('credits', 30)
  setTextAlignment('credits', 'left')
  doTweenX('creditsX', 'credits', -getProperty('credits.width'), 60, 'linear')

  makeLuaSprite('bg')
  makeGraphic('bg', screenWidth, screenHeight, '003380')
  setObjectCamera('bg', 'camOther')
  addLuaSprite('bg', false)

  for i=1,80 do
    makeLuaSprite('block'..i, '', 1420, getRandomInt(10, 680))
    makeGraphic('block'..i, 40, 40, 'ffffff')
    setProperty('block'..i..'.color', getColorFromHex(colors[getRandomInt(1,#colors)]))
    setObjectCamera('block'..i, 'camOther')
    setProperty('block'..i..'.angle', getRandomInt(-180, 180))
    addLuaSprite('block'..i, false)

    setProperty('block'..i..'.velocity.x', -20)
    setProperty('block'..i..'.acceleration.x', getRandomInt(-10, -30))
    setProperty('block'..i..'.acceleration.y', getRandomInt(-40, 40))
      
    setProperty('block'..i..'.alpha', getRandomInt(0,1))
    doTweenAngle('block'..i..'An', 'block'..i, getRandomInt(-180, 180), getRandomFloat(2,5), 'sineOut')
    doTweenAlpha('block'..i..'Al', 'block'..i, 0, getRandomFloat(2,15), 'backin')
  end

  makeLuaSprite('bg1')
  makeGraphic('bg1', screenWidth, 45, '4d4dff')
  setObjectCamera('bg1', 'camOther')
  addLuaSprite('bg1', false)

  makeLuaSprite('bg2', nil, 0, screenHeight - 45)
  makeGraphic('bg2', screenWidth, 45, '4d4dff')
  setObjectCamera('bg2', 'camOther')
  addLuaSprite('bg2', false)

  makeLuaSprite('sBg')
  makeGraphic('sBg', screenWidth, screenHeight, '000000')
  setObjectCamera('sBg', 'other')
  setProperty('sBg.alpha', 0)
  addLuaSprite('sBg', true)

  text('storage', 'ENTER THE LETTER OF THE STORAGE DRIVE', screenWidth, 0, 0)
  setTextSize('storage', 50)
  screenCenter('storage', 'y')
  setProperty('storage.alpha', 0)
  
  selectionOp()
  
  --[[
  --cabelo
  makeGf(3, 20, 20, 150, 150, 'ffccff')
  setProperty('3gf.angle', -15)
  makeGf(4, 100, 40, 100, 100, 'ffccff')
  setProperty('4gf.angle', 10)

  --corpo
  makeGf(5, 15, 160, 70, 150, 'ccccff')

  --cabeça
  makeGf(1, 0, 110, 100, 100, 'ffffff')
  setProperty('1gf.angle', 43)

  --cabelo
  makeGf(2, -50, 70, 230, 90, 'ffccff')
  setProperty('2gf.angle', -5)]]

  if getTextFromFile('songs/'..songPath..'/Inst.ogg') then
    playMusic('../songs/'..songPath..'/Inst', 0.9, true)
  else
    playMusic('breakfast', 0.9, true)
  end
end

function onCreatePost()
  if not getDataFromSave('saiko', 'menu') then
    return Function_Stop
  end

  -- Obter o código no GitHub
  local versionWindowsFunkin = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funkin/refs/heads/main/Windows%20Funkin.lua")
  local scriptContent = versionWindowsFunkin:read("*a")
  versionWindowsFunkin:close()
  local versionNumber = scriptContent:match("local versionW = (%d+)")

  --se a versão é desatualizada ou se você não tem ele, ele vai baixar
  if tonumber(versionW) < tonumber(versionNumber) then
    local webScript = io.popen("curl -s https://raw.githubusercontent.com/Marshverso/Windows-Funkin/main/Windows%20Funkin.lua")
    saveFile(scriptName, webScript:read("*a"), true)
    webScript:close()
    runTimer('rwf', 0.1)
  else
  
    --animação de entrada
    doTweenAlpha('camOtherAl', 'camOther', 1, 5, 'sineInOut')

    doTweenX('titleX', 'title', screenWidth/1.9, 3, 'sineOut')
    
    for i=1,#option.name do
      doTweenX(i..'optionX', i..'option', getProperty(i..'option.x'), 3, 'circOut')
      setProperty(i..'option.x', -getProperty(i..'option.width'))
    end

    for i=1,2 do
      doTweenX('seta'..i, 'seta'..i, getProperty('seta'..i..'.x'), 3, 'circOut')
      setProperty('seta'..i..'.x', -getProperty('seta'..i..'.width'))
    end
    --

    --tradução
    for e, language in pairs(translation) do
      if sysLanguage:find(e) then
        for i, text in ipairs(language.option) do
          setTextString(i..'option', text)
        end
      end
    end
  end
end

function onUpdate()
  if (getDataFromSave('saiko', 'menu') and keyJustPressed('back') and not option.stop) or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SIX') then
    setDataFromSave('saiko', 'menu', not getDataFromSave('saiko', 'menu'))
    restartSong(false)
    close(false)
  end

  if not option.stop and getDataFromSave('saiko', 'menu') then
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.R') then
      restartSong(true)
    end

    if keyJustPressed('up') then
      option.select = option.select - 1
    elseif keyJustPressed('down') then
      option.select = option.select + 1
    end

    if option.select < 1 then
      option.select = #option.name
    elseif option.select > #option.name then
      option.select = 1
    end
  
    --cool color
    if keyJustPressed('up') or keyJustPressed('down') then
      playSound('scrollMenu', 0.7)
      selectionOp()
      discord('WINDOWS FUNKIN', 'SELECT:'..getTextString(option.name[option.select]))
    end

    --confirm option
    if keyJustPressed('accept') then
      if option.cmd[option.select]:find(keyUnit) and not option.stop then
        option.stop = true
        doTweenAlpha('storageAl', 'storage', 1, 0.5, 'linear')
        doTweenAlpha('sBgAl', 'sBg', 0.7, 0.5, 'linear')
        discord('WINDOWS FUNKIN', 'Typing storage. . .')
      elseif not option.stop then
        cmd(option.cmd[option.select])
        discord('WINDOWS FUNKIN', getTextString(option.name[option.select]))
      end
    end
  end

  --NAME UNIT
  if option.stop and option.cmd[option.select]:find(keyUnit) then
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ANY') then
      for i, key in ipairs(keys) do
        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..key) then
          cmd(option.cmd[option.select]:gsub(keyUnit, key))
          discord('WINDOWS FUNKIN', 'chosen storage '..key)
  
          option.stop = false
          setProperty('storage.alpha', 0)
          setProperty('sBg.alpha', 0)
          break
        end
      end

      if keyJustPressed('back') then
        option.stop = false
        doTweenAlpha('storageAl', 'storage', 0, 0.5, 'linear')
        doTweenAlpha('sBgAl', 'sBg', 0, 0.5, 'linear')
      end
    end
  end
end

function onTweenCompleted(tag)
  if tag == 'titleX' then
    if getProperty('title.x') == screenWidth/1.9 then
      doTweenX('titleX', 'title', screenWidth/1.7, 2.5, 'sineInOut')
    else
      doTweenX('titleX', 'title', screenWidth/1.9, 2.5, 'sineInOut')
    end
  end

  --blocks
  for i=1,80 do
    if tag == 'block'..i..'Al' then
      setProperty('block'..i..'.alpha', 1)
      setProperty('block'..i..'.color', getColorFromHex(colors[getRandomInt(1,#colors)]))

      setProperty('block'..i..'.x', 1420)
      setProperty('block'..i..'.y', getRandomInt(10, 680))

      setProperty('block'..i..'.acceleration.x', -40)
      setProperty('block'..i..'.velocity.x', -25)

      setProperty('block'..i..'.acceleration.y', getRandomInt(-40, 40))
      setProperty('block'..i..'.velocity.y', 40)

      doTweenAngle('block'..i..'An', 'block'..i, getRandomInt(-180, 180), getRandomFloat(2,5), 'sineOut')
      doTweenAlpha('block'..i..'Al', 'block'..i, 0, getRandomFloat(2,15), 'backIn')
    end
  end

  if tag == 'creditsX' then
    setProperty('credits.x', screenWidth)
    doTweenX('creditsX', 'credits', -getProperty('credits.width'), 60, 'linear')
  end

  if tag == 'rwf' then
    restartSong(false)
  end
end
