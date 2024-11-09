local versionW = 8.2

local sysLanguage = os.setlocale(nil, 'collate'):lower()

local keys = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}

local selection = 1
local selectionStop = false

local ladoS = getRandomInt(1,2)
local spawnar = {-140, 1420}
local colors = {'00ff99', '6666ff', 'ff3399'}

local options = {
  option = {},
  cmd = {},
  nameUnit = {}
}

local keyUnit = 'NAMEUNIT'

--STOP GAME
function onStartCountdown() if getDataFromSave('saiko', 'menu') then return Function_Stop end end

--verse script translater
function verseTranslate(tag, language, text)
  if sysLanguage:find(language:lower()) then
    setTextString(tag, text)
  end
end

--DISCORD WOW 
function discord(details, state)
  if tonumber(version:sub(1, 3)) >= 0.7 then
    changeDiscordPresence(details, state, nil, false)
  else
    changePresence(details, state, nil, false)
  end
end

--FACILIDADE PARA O DEV
function addOption(tag, text, comand, unit)
  table.insert(options.option, tag)
  table.insert(options.cmd, [[powershell -Command "Start-Process cmd -ArgumentList '/c ]]..comand..[[ /O' -Verb RunAs"]])
  table.insert(options.nameUnit, unit)

  makeLuaText(tag, text, 0, 0, screenHeight-70)
  setTextSize(tag, 30)
  setObjectCamera(tag, 'other')
  addLuaText(tag)

  if #options.option > 1 then
    for i=2, #options.option do
      setProperty(options.option[i]..'.y', getProperty(options.option[i-1]..'.y') - 50)
    end
  end
end

--create. . . lol
function onCreate()
  initSaveData('saiko', 'saiko')

  --fps plus lol
  --[[setPropertyFromClass('flixel.FlxG', 'drawFramerate', 480)
  setPropertyFromClass('flixel.FlxG', 'updateFramerate', 480)]]

  if getDataFromSave('saiko', 'menu') then
    setProperty('camGame.visible', false)
    setProperty('camHUD.visible', false)
    setProperty('camOther.alpha', 0)

    makeLuaText('title', 'WINDOWS FUNKIN', screenWidth, 10, 68)
    setTextSize('title', 100)
    setObjectCamera('title', 'other')
    setTextAlignment('title', 'center')
    addLuaText('title')

    doTweenX('titleX', 'title', -10, 3, 'sineOut')

    --OPTIONS
    --translator by FacheFNF
    addOption('va', 'Check files', [[sfc /scannow && dism /online /cleanup-image /scanhealth && dism /online /cleanup-image /restorehealth]], false)
    addOption('vh', 'Check storege', [[chkdsk ]]..keyUnit..[[: /f /r /x]], true)
    addOption('vr', 'Check ram (PC RESET)', [[mdsched.exe]], false)
    addOption('rm', 'Remove watermark (PC RESET)', [[-NoProfile -ExecutionPolicy Bypass -Command \"Start-Process cmd -ArgumentList ''/c reg add \"\"HKEY_CURRENT_USER\\Control Panel\\Desktop\"\" /v PaintDesktopVersion /t REG_DWORD /d]], false)
    addOption('desfrag', 'Optimize storege', [[defrag ]]..keyUnit..[[: /O]], true)
    addOption('cache', 'Clear cache', [[del /q/f/s %TEMP% && del /q/f/s TEMP\\*\]], false)
    addOption('dn', 'Clear junk files', [[cleanmgr]], false)
    addOption('odp', 'Performance Options', [[SystemPropertiesPerformance]], false)
    addOption('av', 'Anti-virus', [[mrt]], false)
    addOption('sb', 'Windows Emulator (PC RESET)', [[Dism /online /Enable-Feature /FeatureName:"Containers-DisposableClientVM" -All && Y]], false)

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
    verseTranslate('sb', 'portuguese', 'Emulador do windows (REINICIAR PC)')

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
    verseTranslate('sb', 'spanish', 'Emulador de windows (REINICIA EL PC)')
    --Lo siento por cualquier cosa mal, lo hice para practicar mi español un poco

    --conserta alinhamento
    for i, tag in ipairs(options.option) do
      setTextAlignment(tag, 'center')
      screenCenter(tag, 'x')
    end
  
    --credits
    makeLuaText('credits', 'Creator: Marshverso (YT and DC)     Menu design: FacheFNF (DC)     Tradutor português: Marshverso (YT and DC)     English Translator: FacheFNF (DC)     Traductores español: Erislwlol(X) y FacheFNF (DC)     Beta Testers: FandeFNF (ST) and Erislwlol(X)', 0, screenWidth, 10)
    setTextSize('credits', 25)
    setObjectCamera('credits', 'other')
    setTextAlignment('credits', 'left')
    addLuaText('credits')

    makeLuaText('log', 'Log [TAB]', 0, 10, 670)
    setTextSize('log', 40)
    setObjectCamera('log', 'other')
    setTextAlignment('log', 'right')
    addLuaText('log')

    makeLuaText('versionW', 'v'..versionW, 0, 0, 0)
    setTextSize('versionW', 40)
    setObjectCamera('versionW', 'other')
    setTextAlignment('versionW', 'right')
    setProperty('versionW.x', screenWidth-getProperty('versionW.width')-10)
    setProperty('versionW.y', screenHeight-getProperty('versionW.height')-10)
    addLuaText('versionW')

    doTweenX('creditsX', 'credits', -getProperty('credits.width'), 15, 'linear')

    for i=1,40 do
      ladoS = getRandomInt(1,2)

      makeLuaSprite('block'..i, '', spawnar[ladoS], getRandomInt(10, 680))
      makeGraphic('block'..i, 40, 40, 'ffffff')
      setProperty('block'..i..'.color', getColorFromHex(colors[getRandomInt(1,#colors)]))
      setObjectCamera('block'..i, 'other')
      setProperty('block'..i..'.angle', getRandomInt(-180, 180))
      addLuaSprite('block'..i, false)

      if ladoS == 1 then 
        setProperty('block'..i..'.velocity.x', 20)
        setProperty('block'..i..'.acceleration.x', getRandomInt(10, 30))
      else
        setProperty('block'..i..'.velocity.x', -20)
        setProperty('block'..i..'.acceleration.x', getRandomInt(-10, -30))
      end

      setProperty('block'..i..'.acceleration.y', getRandomInt(-40, 40))
      
      setProperty('block'..i..'.alpha', getRandomInt(0,1))
      doTweenAngle('block'..i..'An', 'block'..i, getRandomInt(-180, 180), getRandomFloat(2,5), 'sineOut')
      doTweenAlpha('block'..i..'Al', 'block'..i, 0, getRandomFloat(2,5), 'backin')
    end

    makeLuaSprite('sBg')
    makeGraphic('sBg', screenWidth, screenHeight, '000000')
    setObjectCamera('sBg', 'other')
    setProperty('sBg.alpha', 0)
    addLuaSprite('sBg', true)

    makeLuaText('storege', 'ENTER THE LETTER OF THE STORAGE DRIVE', 0, 0, 0)
    setTextSize('storege', 50)
    setObjectCamera('storege', 'other')
    screenCenter('storege', 'xy')
    setProperty('storege.alpha', 0)
    addLuaText('storege')

    makeLuaText('s', 'SUCCESSED', 0, 0, 0)
    setTextSize('s', 80)
    setObjectCamera('s', 'other')
    screenCenter('s', 'x')
    setProperty('s.alpha', 0)
    addLuaText('s')

    makeAnimatedLuaSprite('sGf', 'characters/GF_assets', 0, 0)
    addAnimationByPrefix('sGf', 'hey', 'GF cheer', 18, true)
    setObjectCamera('sGf', 'other')
    screenCenter('sGf', 'xy')
    setProperty('sGf.y', getProperty('sGf.y') + 40)
    setProperty('sGf.alpha', 0)
    addLuaSprite('sGf', true)

    if getTextFromFile('songs/'..songPath..'/Inst.ogg') then
      playMusic('../songs/'..songPath..'/Inst', 0.9, true)
    else
      playMusic('breakfast', 0.9, true)
    end
  end
end

function onCreatePost()
  if getDataFromSave('saiko', 'menu') then
    doTweenAlpha('camOtherAl', 'camOther', 1, 5, 'sineInOut')
    selectionOp()
    discord('WINDOWS FUNKIN', 'SELECT:'..getTextString(options.option[selection]))
  end
end

function selectionOp()
  for i, tag in ipairs(options.option) do
    if selection == i and not (getProperty(tag..'.color') == -256) then
      setProperty(tag..'.color', getColorFromHex('ffff00'))
      doTweenX(tag..'SX', tag..'.scale', 1.1, 0.2, 'sineIn')
      setTextString(tag, '< '..getTextString(tag)..' >')
      screenCenter(tag, 'x')
    elseif not ((selection == i) and (getProperty(tag..'.color') == -1)) then
      setProperty(tag..'.color', getColorFromHex('ffffff'))
      doTweenX(tag..'SX', tag..'.scale', 1, 0.2, 'sineIn')
      setTextString(tag, getTextString(tag):gsub('< ', ''):gsub(' >', ''))
      screenCenter(tag, 'x')
    end
  end
end
  
function onUpdatePost(elapsed)
  if getDataFromSave('saiko', 'menu') then
    --dev kit
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.R') then
      restartSong(true)
    end

    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TAB') then
      os.execute('start https://raw.githubusercontent.com/Marshverso/Windows-Funkin/refs/heads/main/log.txt')
    end

    --selection
    if not selectionStop then
      if keyJustPressed('up') then
        selection = selection + 1
      elseif keyJustPressed('down') then
        selection = selection - 1
      end

      if selection < 1 then
        selection = #options.option
      elseif selection > #options.option then
        selection = 1
      end
  
      --cool color
      if keyJustPressed('up') or keyJustPressed('down') then
        playSound('scrollMenu', 0.7)
        selectionOp()
        discord('WINDOWS FUNKIN', 'SELECT:'..getTextString(options.option[selection]))
      end

      --confirm option
      if keyJustPressed('accept') then
        if options.nameUnit[selection] then
          selectionStop = true
          doTweenAlpha('storegeAl', 'storege', 1, 0.5, 'linear')
          doTweenAlpha('sBgAl', 'sBg', 0.7, 0.5, 'linear')
          discord('WINDOWS FUNKIN', 'Typing storage. . .')
        else
          os.execute(options.cmd[selection])
          discord('WINDOWS FUNKIN', getTextString(options.option[selection]))
          successed()
        end
      end
    end

    --NAME UNIT
    if selectionStop and options.nameUnit[selection] then
      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ANY') then
        for i, key in ipairs(keys) do
          if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..key) then
            os.execute(options.cmd[selection]:gsub(keyUnit, key))
            discord('WINDOWS FUNKIN', 'chosen storage '..key..'C:')
    
            selectionStop = false
            successed()
            setProperty('storege.alpha', 0)
            break
          end
        end

        if keyJustPressed('back') then
          selectionStop = false
          doTweenAlpha('storegeAl', 'storege', 0, 0.5, 'linear')
          doTweenAlpha('sBgAl', 'sBg', 0, 0.5, 'linear')
        end
      end
    end
  end
end

function successed()
  discord('WINDOWS FUNKIN', 'SUCCESSED')
  playSound('confirmMenu', 0.9)

  setProperty('s.alpha', 1)
  setProperty('sGf.alpha', 1)
  setProperty('sBg.alpha', 1)

  doTweenAlpha('sAl', 's', 0, 2, 'backIn')
  doTweenAlpha('sGfAl', 'sGf', 0, 2, 'backIn')
  doTweenAlpha('sBgAl', 'sBg', 0, 2, 'backIn')
end

function onTweenCompleted(tag)
  --blocks
  if tag == 'titleX' then
    if getProperty('title.x') == 10 then
      doTweenX('titleX', 'title', -10, 3, 'sineInOut')
    else
      doTweenX('titleX', 'title', 10, 3, 'sineInOut')
    end
  end

  for i=1,40 do
    if tag == 'block'..i..'Al' then
      ladoS = getRandomInt(1,2)

      setProperty('block'..i..'.alpha', 1)
      setProperty('block'..i..'.color', getColorFromHex(colors[getRandomInt(1,#colors)]))

      setProperty('block'..i..'.x', spawnar[ladoS])
      setProperty('block'..i..'.y', getRandomInt(10, 680))

      if ladoS == 1 then 
        setProperty('block'..i..'.acceleration.x', 40)
        setProperty('block'..i..'.velocity.x', 25)
      else
        setProperty('block'..i..'.acceleration.x', -40)
        setProperty('block'..i..'.velocity.x', -25)
      end

      setProperty('block'..i..'.acceleration.y', getRandomInt(-40, 40))
      setProperty('block'..i..'.velocity.y', 40)

      doTweenAngle('block'..i..'An', 'block'..i, getRandomInt(-180, 180), getRandomFloat(2,5), 'sineOut')
      doTweenAlpha('block'..i..'Al', 'block'..i, 0, getRandomFloat(2,5), 'backIn')
    end
  end

  if tag == 'creditsX' then
    setProperty('credits.x', screenWidth)
    doTweenX('creditsX', 'credits', -getProperty('credits.width'), 15, 'linear')
  end
end

--Thank you to everyone who helped with the ideas
--script by marshverso#0000
