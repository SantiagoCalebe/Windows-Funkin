--press 6 in game
local sysLanguage = os.setlocale(nil, 'collate')
local sysLanguage = sysLanguage:lower()

local keys = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}

local selection = 1
local selectionStop = false

local options = {
  option = {},
  cmd = {},
  nameUnit = {}
}

local keyUnit = 'NAMEUNIT'
luaDebugMode = true

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

  makeLuaText(tag, text, 0, 0, screenHeight-50)
  setTextSize(tag, 30)
  setObjectCamera(tag, 'other')
  addLuaText(tag)
end

--create. . . lol
function onCreate()
  --fps plus lol
  --[[setPropertyFromClass('flixel.FlxG', 'drawFramerate', 480)
  setPropertyFromClass('flixel.FlxG', 'updateFramerate', 480)]]

  if getDataFromSave('saiko', 'menu') then
    makeLuaText('title', 'WINDOWS FUNKIN', 500, 40, 30)
    setTextSize('title', 100)
    setObjectCamera('title', 'other')
    addLuaText('title')

    --OPTIONS
    addOption('va', 'Check for corrupted files', [[sfc /scannow && dism /online /cleanup-image /scanhealth && dism /online /cleanup-image /restorehealth]], false)
    addOption('vh', 'Check if hard drive is corrupted (C: RESET)', [[chkdsk ]]..keyUnit..[[: /f /r /x]], true)
    addOption('vr', 'Check ram (PC RESET)', [[mdsched.exe]], false)
    addOption('rm', 'Remove watermark (PC RESET)', [[PowerShell -Command "Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"Start-Process cmd -ArgumentList ''/c reg add \"\"HKEY_CURRENT_USER\\Control Panel\\Desktop\"\" /v PaintDesktopVersion /t REG_DWORD /d 0 /f'' -Verb RunAs\"' -Verb RunAs"]], false)
    addOption('desfrag', 'Optimize Unit', [[defrag ]]..keyUnit..[[: /O]], true)
    addOption('cache', 'Clear cache', [[del /q/f/s %TEMP% && del /q/f/s TEMP\\*\]], false)
    addOption('dn', 'Clean up unnecessary files', [[cleanmgr]], false)
    addOption('odp', 'Performance Options', [[SystemPropertiesPerformance]], false)
    addOption('av', 'Anti-virus', [[mrt]], false)
    addOption('sb', 'Windows Sandbox', [[Dism /online /Enable-Feature /FeatureName:"Containers-DisposableClientVM" -All && Y]], false)

    verseTranslate('title', 'portuguese', 'WINDOWS FUNK')
    verseTranslate('va', 'portuguese', 'Verificar se há arquivos corrompidos')
    verseTranslate('vh', 'portuguese', 'Verificar se disco está corrompido (C: RESET)') --professora de português é foda
    verseTranslate('vr', 'portuguese', 'Verificar ram (PC RESET)')
    verseTranslate('rm', 'portuguese', "Remover marca d'água do windows (PC RESET)")
    verseTranslate('desfrag', 'portuguese', 'Otimizar disco')
    verseTranslate('cache', 'portuguese', 'Limpar cache')
    verseTranslate('dn', 'portuguese', 'Limpar arquivos inúteis')
    verseTranslate('odp', 'portuguese', 'Opções de desempenho')
    verseTranslate('sb', 'portuguese', 'Emulador do windows (PC RESET)')

    makeLuaSprite('fundinho', '', -390, 0)
    makeGraphic('fundinho', screenWidth+100, screenHeight+120, '000000')
    setObjectCamera('fundinho', 'other')
    setProperty('fundinho.angle', 60)
    addLuaSprite('fundinho', false)

    --credits
    makeLuaText('credits', 'Creator: Marshverso (YT and DC)     Menu design: FacheFNF (DC)     Beta Testers: FandeFNF (ST) and Erislwlol(X)', 0, screenWidth, 10)
    setTextSize('credits', 25)
    setObjectCamera('credits', 'other')
    setTextAlignment('credits', 'left')
    addLuaText('credits')

    makeLuaText('versionW', 'v6', 0, 0, 0)
    setTextSize('versionW', 40)
    setObjectCamera('versionW', 'other')
    setTextAlignment('versionW', 'right')
    setProperty('versionW.x', screenWidth-getProperty('versionW.width')-10)
    setProperty('versionW.y', screenHeight-getProperty('versionW.height')-5)
    addLuaText('versionW')

    doTweenX('creditsX', 'credits', -getProperty('credits.height')-getProperty('credits.x'), 15, 'linear')

    makeLuaSprite('fundinho1')
    makeGraphic('fundinho1', screenWidth, 50, '000000')
    setObjectCamera('fundinho1', 'other')
    addLuaSprite('fundinho1', false)

    makeLuaSprite('fundinho2', '', 0, screenHeight-50)
    makeGraphic('fundinho2', screenWidth, 50, '000000')
    setObjectCamera('fundinho2', 'other')
    addLuaSprite('fundinho2', false)

    for i=1,40 do
      makeLuaSprite('block'..i, '', screenWidth/2.5, getRandomInt(10, 680))
      makeGraphic('block'..i, 40, 40, '000000')
      setObjectCamera('block'..i, 'other')
      setProperty('block'..i..'.angle', getRandomInt(-180, 180))
      addLuaSprite('block'..i, false)

      setProperty('block'..i..'.velocity.x', 20)
      setProperty('block'..i..'.acceleration.x', getRandomInt(10, 30))
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

    setProperty('va.color', getColorFromHex('ffff00'))

    if getTextFromFile('songs/'..songPath..'/Inst.ogg') then
      playMusic('../songs/'..songPath..'/Inst', 0.9, true)
    else
      playMusic('breakfast', 0.9, true)
    end

    if #options.option > 1 then
      for i=2, #options.option do
        setProperty(options.option[i]..'.y', getProperty(options.option[i-1]..'.y') - 50)
      end
    end

    doTweenX('fundinhoX', 'fundinho', -380, 0.1, 'linear')
    doTweenX(options.option[1]..'X', options.option[1], 20, 0.2, 'sineIn')
  end
end

function onCreatePost()
  if getDataFromSave('saiko', 'menu') then
    setProperty('camHUD.visible', false)

    if getRandomBool(50) then
      objectPlayAnimation('boyfriend', 'hey', true)
      objectPlayAnimation('gf', 'cheer', true)
    end

    triggerEvent('Camera Follow Pos', getGraphicMidpointX('boyfriend')*0.6, getGraphicMidpointY('boyfriend'))
    discord('WINDOWS FUNKIN', 'SELECT:'..getTextString(options.option[selection]))
  end
end

function onUpdate(elapsed)
  if getDataFromSave('saiko', 'menu') then
    --dev kit
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.R') and luaDebugMode then
      restartSong(true)
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
      
        for i, tag in ipairs(options.option) do
          if selection == i and not (getProperty(tag..'.color') == -256) then
            setProperty(tag..'.color', getColorFromHex('ffff00'))
            doTweenX(tag..'X', tag, 20, 0.2, 'sineIn')
          elseif not (selection == i and (getProperty(tag..'.color') == -1)) then
            setProperty(tag..'.color', getColorFromHex('ffffff'))
            doTweenX(tag..'X', tag, 0, 0.2, 'sineIn')
          end
        end

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
    if selectionStop then
      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ANY') and options.nameUnit[selection] then
        for i, key in ipairs(keys) do
          if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..key) and options.nameUnit[selection] then
            os.execute(options.cmd[selection]:gsub(keyUnit, key))
            discord('WINDOWS FUNKIN', 'chosen storage '..key..'C:')
    
            selectionStop = false
            successed()
            setProperty('storege.alpha', 0)
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
  if tag == 'fundinhoX1' then
    doTweenX('fundinhoX', 'fundinho', -380, 1, 'sineInOut')
  elseif tag == 'fundinhoX' then
    doTweenX('fundinhoX1', 'fundinho', -390, 1, 'sineInOut')
  end

  --blocks
  for i=1,40 do
    if tag == 'block'..i..'Al' then
      setProperty('block'..i..'.alpha', 1)

      setProperty('block'..i..'.x', screenWidth/2.5)
      setProperty('block'..i..'.y', getRandomInt(10, 680))
      setProperty('block'..i..'.acceleration.x', 40)
      setProperty('block'..i..'.acceleration.y', getRandomInt(-40, 40))

      setProperty('block'..i..'.velocity.x', 25)
      setProperty('block'..i..'.velocity.y', 40)

      doTweenAngle('block'..i..'An', 'block'..i, getRandomInt(-180, 180), getRandomFloat(2,5), 'sineOut')
      doTweenAlpha('block'..i..'Al', 'block'..i, 0, getRandomFloat(2,5), 'backIn')
    end
  end

  if tag == 'creditsX' then
    setProperty('credits.x', screenWidth)
    doTweenX('creditsX', 'credits', -getProperty('credits.height')-getProperty('credits.x'), 15, 'linear')
  end
end
--Thank you to everyone who helped with the ideas
--script by marshverso#0000
