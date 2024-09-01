# satisfactory-ds
Satisfactory Dedicated Server

Ports needed 7777,15000,15777


References:
https://satisfactory.fandom.com/wiki/Dedicated_servers#Linux

Location for config files:
`/home/steam/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer`

Edit game settings in file `GameUserSettings.ini`:
```
[/Script/FactoryGame.FGGameUserSettings]
mIntValues=(("FG.NetworkQuality", 3)
mFloatValues=(("FG.AutosaveInterval",3600.000000))
...
```
