# Detecting allied actions

It'd be nice to be able to detect when allies do certain things as well as detecting which keys J4 presses. For this reason we need to analyse the packets produced by the LoL client and detect them with AHK or similar. For this reason we shall use WireShark / Microsoft Network Monitoring tool. Disclaimer: Specifically we want to detect >ALLIED< Actions. It might also be nice to detect chases and ganks, to an extent, as these can create some nice events for our voice pack.

On Mac:

```lsof``` can be used to give us some information about data flowing in and out of network ports and processes and files accessed by users. We can filter these with Grep e.g. ``` lsof -u Sancarn | Grep -e ".*League.*" ``` will get all processes currently being accessed by sancarn which contain the word "League". Note the pattern here is RegEx.

While in LoL client ``` lsof -u Sancarn | Grep -e ".*League.*" ``` returns:

```
Sancarns-Pro:~ Sancarn$ lsof -u Sancarn | Grep -e ".*League.*"
COMMAND     PID    USER   FD     TYPE            DEVICE   SIZE/OFF     NODE NAME
UserKerne  1739 Sancarn  cwd      DIR               1,1        136  1668267 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_launcher/releases/0.0.0.191/deploy
UserKerne  1739 Sancarn  txt      REG               1,1    1777688  1668364 /Applications/League of Legends.app/Contents/LoL/RADS/system/UserKernel.app/Contents/MacOS/UserKernel
UserKerne  1739 Sancarn  txt      REG               1,1      53068  1668340 /Applications/League of Legends.app/Contents/LoL/RADS/system/UserKernel.app/Contents/Frameworks/BugSplat.framework/Versions/A/BugSplat
UserKerne  1739 Sancarn  txt      REG               1,1      77804  1668369 /Applications/League of Legends.app/Contents/LoL/RADS/system/UserKernel.app/Contents/Resources/SplashScreen.png
UserKerne  1739 Sancarn  txt      REG               1,1     453372  1668367 /Applications/League of Legends.app/Contents/LoL/RADS/system/UserKernel.app/Contents/Resources/lol.icns
UserKerne  1739 Sancarn   14w     REG               1,1      14453 52013787 /Applications/League of Legends.app/Contents/LoL/RADS/rads_user_kernel.log
LoLLaunch  1746 Sancarn  cwd      DIR               1,1        136  1668267 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_launcher/releases/0.0.0.191/deploy
LoLLaunch  1746 Sancarn  txt      REG               1,1    4619808  1668314 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_launcher/releases/0.0.0.191/deploy/LoLLauncher.app/Contents/MacOS/LoLLauncher
LoLLaunch  1746 Sancarn  txt      REG               1,1       3562  1668320 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_launcher/releases/0.0.0.191/deploy/LoLLauncher.app/Contents/Resources/MainMenu.nib
LoLLaunch  1746 Sancarn  txt      REG               1,1     453372  1668319 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_launcher/releases/0.0.0.191/deploy/LoLLauncher.app/Contents/Resources/lol.icns
LoLLaunch  1746 Sancarn   14w     REG               1,1       5724 52013800 /Applications/League of Legends.app/Contents/LoL/Logs/Patcher Logs/2016-08-26T21-45-42_launcher.log
LoLPatche  1748 Sancarn  cwd      DIR               1,1        136  2320221 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_patcher/releases/0.0.0.63/deploy
LoLPatche  1748 Sancarn  txt      REG               1,1   11645968  2320572 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_patcher/releases/0.0.0.63/deploy/LoLPatcher.app/Contents/MacOS/LoLPatcher
LoLPatche  1748 Sancarn  txt      REG               1,1     964304  2320562 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_patcher/releases/0.0.0.63/deploy/LoLPatcher.app/Contents/MacOS/libRiotLauncher.dylib
LoLPatche  1748 Sancarn  txt      REG               1,1      84360 42916187 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_patcher/releases/0.0.0.63/deploy/LoLPatcher.app/Contents/Frameworks/BugSplat.framework/Versions/A/BugSplat
LoLPatche  1748 Sancarn    4w     REG               1,1      59887 52013804 /Applications/League of Legends.app/Contents/LoL/Logs/Patcher Logs/2016-08-26T21-45-44_LoLPatcher.log
LoLPatche  1748 Sancarn   10w     REG               1,1         43 50395168 /Applications/League of Legends.app/Contents/LoL/lockfile
LolClient  1769 Sancarn  cwd      DIR               1,1        714  1669018 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_air_client/releases/0.0.0.250/deploy/bin
LolClient  1769 Sancarn  txt      REG               1,1      33172 47546753 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_air_client/releases/0.0.0.250/deploy/bin/LolClient
LolClient  1769 Sancarn  txt      REG               1,1       9158  1677516 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_air_client/releases/0.0.0.250/deploy/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/en.lproj/MainMenu.nib/keyedobjects.nib
LolClient  1769 Sancarn  txt      REG               1,1   29232692 47558340 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_air_client/releases/0.0.0.250/deploy/Frameworks/Adobe AIR.framework/Versions/1.0/Adobe AIR_64
LolClient  1769 Sancarn  txt      REG               1,1    7297528 47559326 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_air_client/releases/0.0.0.250/deploy/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/WebKit.dylib
LolClient  1769 Sancarn  txt      REG               1,1   26897280 47559328 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_air_client/releases/0.0.0.250/deploy/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/Flash Player.plugin/Contents/MacOS/FlashPlayer-10.6
LolClient  1769 Sancarn   23r     REG               1,1    1032192 50396292 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_air_client/releases/0.0.0.250/deploy/bin/assets/data/gameStats/gameStats_en_GB.sqlite
LolClient  1769 Sancarn   31r     REG               1,1    1032192 50396292 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_air_client/releases/0.0.0.250/deploy/bin/assets/data/gameStats/gameStats_en_GB.sqlite
LolClient  1769 Sancarn   42r     REG               1,1    1032192 50396292 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_air_client/releases/0.0.0.250/deploy/bin/assets/data/gameStats/gameStats_en_GB.sqlite
```

However while in-game we see a lot more files are being accessed (shown are the files different from the above):
```
Sancarns-Pro:~ Sancarn$ lsof -u Sancarn | Grep -e ".*League.*"
COMMAND     PID    USER   FD     TYPE            DEVICE   SIZE/OFF     NODE NAME
LolClient  1769 Sancarn   16w     REG               1,1     753205 52014424 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_air_client/releases/0.0.0.250/deploy/bin/logs/LolClient.20160826.214557.log
LeagueofL 48299 Sancarn  cwd      DIR               1,1        238  1677679 /Applications/League of Legends.app/Contents/LoL/RADS/solutions/lol_game_client_sln/releases/0.0.0.223/deploy
LeagueofL 48299 Sancarn  txt      REG               1,1   28173968  1805495 /Applications/League of Legends.app/Contents/LoL/RADS/solutions/lol_game_client_sln/releases/0.0.0.223/deploy/LeagueofLegends.app/Contents/MacOS/LeagueofLegends
LeagueofL 48299 Sancarn  txt      REG               1,1    3067820  1805501 /Applications/League of Legends.app/Contents/LoL/RADS/solutions/lol_game_client_sln/releases/0.0.0.223/deploy/LeagueofLegends.app/Contents/MacOS/libRiotLauncher.dylib
LeagueofL 48299 Sancarn  txt      REG               1,1      84360  1805470 /Applications/League of Legends.app/Contents/LoL/RADS/solutions/lol_game_client_sln/releases/0.0.0.223/deploy/LeagueofLegends.app/Contents/Frameworks/BugSplat.framework/Versions/A/BugSplat
LeagueofL 48299 Sancarn  txt      REG               1,1   31702232  1805488 /Applications/League of Legends.app/Contents/LoL/RADS/solutions/lol_game_client_sln/releases/0.0.0.223/deploy/LeagueofLegends.app/Contents/Frameworks/Cg.framework/Cg
LeagueofL 48299 Sancarn  txt      REG               1,1       4380 33215596 /System/Library/ColorSync/Profiles/Generic Gray Gamma 2.2 Profile.icc
LeagueofL 48299 Sancarn  txt      REG               1,1       1960 33215599 /System/Library/ColorSync/Profiles/Generic RGB Profile.icc
LeagueofL 48299 Sancarn  txt      REG               1,1    3759122 33218426 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/SystemAppearance.car
LeagueofL 48299 Sancarn  txt      REG               1,1       3562  1805507 /Applications/League of Legends.app/Contents/LoL/RADS/solutions/lol_game_client_sln/releases/0.0.0.223/deploy/LeagueofLegends.app/Contents/Resources/MainMenu.nib
LeagueofL 48299 Sancarn  txt      REG               1,1       3144 33215601 /System/Library/ColorSync/Profiles/sRGB Profile.icc
LeagueofL 48299 Sancarn  txt      REG               1,1     245316 33218425 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/GraphiteDarkAppearance.car
LeagueofL 48299 Sancarn  txt      REG               1,1     129990 33218421 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/AccessibilityVibrantLightAppearance.car
LeagueofL 48299 Sancarn  txt      REG               1,1     231386 33218419 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/AccessibilityDarkGraphiteAppearance.car
LeagueofL 48299 Sancarn  txt      REG               1,1     438962 33218427 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/VibrantLightAppearance.car
LeagueofL 48299 Sancarn  txt      REG               1,1    1105296 33322080 /System/Library/PrivateFrameworks/CloudDocs.framework/Versions/A/CloudDocs
LeagueofL 48299 Sancarn  txt      REG               1,1    2356848 48073818 /System/Library/Frameworks/OpenCL.framework/Versions/A/Libraries/ImageFormats/unorm8_bgra.dylib
LeagueofL 48299 Sancarn  txt      REG               1,1      35904 49451695 /private/var/folders/n6/b57bg5554y7bv36xbsfhmqf80000gn/C/com.apple.IntlDataCache.le.kbdx
LeagueofL 48299 Sancarn  txt      REG               1,1    1919257 33218420 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/AccessibilityGraphiteAppearance.car
LeagueofL 48299 Sancarn  txt      REG               1,1   24438480 33245326 /usr/share/icu/icudt53l.dat
LeagueofL 48299 Sancarn  txt      REG               1,1    4939776 51988611 /private/var/folders/n6/b57bg5554y7bv36xbsfhmqf80000gn/0/com.apple.LaunchServices-107501.csstore
LeagueofL 48299 Sancarn  txt      REG               1,1    1966248 33218424 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/GraphiteAppearance.car
LeagueofL 48299 Sancarn  txt      REG               1,1    3504343 33218417 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/AccessibilityAppearance.car
LeagueofL 48299 Sancarn  txt      REG               1,1    3165507 33218422 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/DarkAppearance.car
LeagueofL 48299 Sancarn  txt      REG               1,1    2938766 33218418 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/AccessibilityDarkAppearance.car
LeagueofL 48299 Sancarn  txt      REG               1,1    9240248 33232919 /System/Library/PrivateFrameworks/CoreUI.framework/Versions/A/Resources/SArtFile.bin
LeagueofL 48299 Sancarn  txt      REG               1,1   10506320 48074588 /System/Library/Extensions/AMDRadeonX4000GLDriver.bundle/Contents/MacOS/AMDRadeonX4000GLDriver
LeagueofL 48299 Sancarn  txt      REG               1,1    5393616 33357012 /System/Library/Fonts/HelveticaNeueDeskInterface.ttc
LeagueofL 48299 Sancarn  txt      REG               1,1    5425538 33224462 /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/HIToolbox.framework/Versions/A/Resources/Extras2.rsrc
LeagueofL 48299 Sancarn  txt      REG               1,1     832248 33231457 /System/Library/Keyboard Layouts/AppleKeyboardLayouts.bundle/Contents/Resources/AppleKeyboardLayouts-L.dat
LeagueofL 48299 Sancarn  txt      REG               1,1      76240 48072322 /System/Library/Extensions/AppleHDA.kext/Contents/PlugIns/AppleHDAHALPlugIn.bundle/Contents/MacOS/AppleHDAHALPlugIn
LeagueofL 48299 Sancarn  txt      REG               1,1    6088000 33198477 /System/Library/Components/CoreAudio.component/Contents/MacOS/CoreAudio
LeagueofL 48299 Sancarn  txt      REG               1,1     622960 48077708 /usr/lib/dyld
LeagueofL 48299 Sancarn  txt      REG               1,1  268108312 48133070 /private/var/run/diagnosticd/dyld_shared_cache_i386
LeagueofL 48299 Sancarn    0r     CHR               3,2        0t0      302 /dev/null
LeagueofL 48299 Sancarn    1u     CHR               3,2      0t819      302 /dev/null
LeagueofL 48299 Sancarn    2u     CHR               3,2  0t5557410      302 /dev/null
LeagueofL 48299 Sancarn    3w     REG               1,1     188479 52052477 /Applications/League of Legends.app/Contents/LoL/Logs/Game - R3d Logs/2016-08-29T01-48-47_r3dlog.txt
LeagueofL 48299 Sancarn    4r     REG               1,1  513087426  2978718 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.0/Archive_2.raf.dat
LeagueofL 48299 Sancarn    5r     REG               1,1   84270308 50410414 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.152/Archive_2.raf.dat
LeagueofL 48299 Sancarn    6r     REG               1,1  102226089 50410386 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.227/Archive_1.raf.dat
LeagueofL 48299 Sancarn    7r     REG               1,1   64986356 50410607 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.226/Archive_1.raf.dat
LeagueofL 48299 Sancarn    8r     REG               1,1   42673356  3218927 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.74/Archive_1.raf.dat
LeagueofL 48299 Sancarn    9r     REG               1,1   38304291  2978728 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.15/Archive_2.raf.dat
LeagueofL 48299 Sancarn   10r     REG               1,1   13179329 50410529 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.195/Archive_2.raf.dat
LeagueofL 48299 Sancarn   11r     REG               1,1   17286595 49798625 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.166/Archive_4.raf.dat
LeagueofL 48299 Sancarn   12r     REG               1,1   48723138  2978726 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.12/Archive_2.raf.dat
LeagueofL 48299 Sancarn   13r     REG               1,1   23734539  2978754 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.61/Archive_3.raf.dat
LeagueofL 48299 Sancarn   14r     REG               1,1   21241358  3218925 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.69/Archive_1.raf.dat
LeagueofL 48299 Sancarn   15r     REG               1,1   34154154  3218941 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.131/Archive_1.raf.dat
LeagueofL 48299 Sancarn   16r     REG               1,1   26917187 50410602 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.223/Archive_1.raf.dat
LeagueofL 48299 Sancarn   17r     REG               1,1   37789314 50410532 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.196/Archive_1.raf.dat
LeagueofL 48299 Sancarn   18r     REG               1,1   53380110 50410484 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.178/Archive_1.raf.dat
LeagueofL 48299 Sancarn   19r     REG               1,1   31945464  2978775 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.91/Archive_3.raf.dat
LeagueofL 48299 Sancarn   20r     REG               1,1   48694475 50410593 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.221/Archive_1.raf.dat
LeagueofL 48299 Sancarn   21r     REG               1,1   20335096 50410406 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.142/Archive_4.raf.dat
LeagueofL 48299 Sancarn   22r     REG               1,1   18610165 50410552 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.203/Archive_1.raf.dat
LeagueofL 48299 Sancarn   23r     REG               1,1   78831718 49798664 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.175/Archive_3.raf.dat
LeagueofL 48299 Sancarn   24r     REG               1,1   17329637 50270703 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.156/Archive_1.raf.dat
LeagueofL 48299 Sancarn   25r     REG               1,1   42875166 50410548 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.201/Archive_1.raf.dat
LeagueofL 48299 Sancarn   26r     REG               1,1   50344330  2978740 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.39/Archive_3.raf.dat
LeagueofL 48299 Sancarn   27r     REG               1,1   42154705  2978746 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.48/Archive_3.raf.dat
LeagueofL 48299 Sancarn   28r     REG               1,1   64216295  2978744 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.46/Archive_3.raf.dat
LeagueofL 48299 Sancarn   29r     REG               1,1   34893445  3218929 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.77/Archive_1.raf.dat
LeagueofL 48299 Sancarn   30r     REG               1,1   14737023  2978748 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.51/Archive_2.raf.dat
LeagueofL 48299 Sancarn   31r     REG               1,1   80175918 50410581 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.216/Archive_1.raf.dat
LeagueofL 48299 Sancarn   32r     REG               1,1       2242 46936947 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.143/Archive_2.raf.dat
LeagueofL 48299 Sancarn   33r     REG               1,1   35042592 50410562 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.208/Archive_1.raf.dat
LeagueofL 48299 Sancarn   34r     REG               1,1   90353949 50410458 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.170/Archive_3.raf.dat
LeagueofL 48299 Sancarn   35r     REG               1,1  154176042 50410430 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.163/Archive_4.raf.dat
LeagueofL 48299 Sancarn   36r     REG               1,1   39605065 50410537 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.197/Archive_1.raf.dat
LeagueofL 48299 Sancarn   37r     REG               1,1   60641743 50270683 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.151/Archive_1.raf.dat
LeagueofL 48299 Sancarn   38r     REG               1,1   13629769 49798597 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.159/Archive_2.raf.dat
LeagueofL 48299 Sancarn   39r     REG               1,1   27992108 50410427 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.159/Archive_1.raf.dat
LeagueofL 48299 Sancarn   40r     REG               1,1   15476845  2978730 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.18/Archive_1.raf.dat
LeagueofL 48299 Sancarn   41r     REG               1,1   60107460 50410576 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.215/Archive_1.raf.dat
LeagueofL 48299 Sancarn   42r     REG               1,1   43333017 50410571 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.213/Archive_1.raf.dat
LeagueofL 48299 Sancarn   43r     REG               1,1    7498528 50410556 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.204/Archive_1.raf.dat
LeagueofL 48299 Sancarn   44r     REG               1,1   14683722 50410513 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.186/Archive_3.raf.dat
LeagueofL 48299 Sancarn   45r     REG               1,1   94671171 50410465 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.170/Archive_5.raf.dat
LeagueofL 48299 Sancarn   46r     REG               1,1   28527073 50410510 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.186/Archive_2.raf.dat
LeagueofL 48299 Sancarn   47r     REG               1,1   53327066 50410501 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.179/Archive_3.raf.dat
LeagueofL 48299 Sancarn   48r     REG               1,1   27085314  3218933 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.85/Archive_1.raf.dat
LeagueofL 48299 Sancarn   49r     REG               1,1   70131654 50410496 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.179/Archive_1.raf.dat
LeagueofL 48299 Sancarn   50r     REG               1,1   57271385  2978722 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.2/Archive_1.raf.dat
LeagueofL 48299 Sancarn   51r     REG               1,1   36412416  2978752 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.58/Archive_4.raf.dat
LeagueofL 48299 Sancarn   52r     REG               1,1   18972555  2978732 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.22/Archive_2.raf.dat
LeagueofL 48299 Sancarn   53r     REG               1,1  157358781 50410439 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.164/Archive_2.raf.dat
LeagueofL 48299 Sancarn   54r     REG               1,1   47553381 50410454 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.169/Archive_2.raf.dat
LeagueofL 48299 Sancarn   55r     REG               1,1   27491962 50410541 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.199/Archive_1.raf.dat
LeagueofL 48299 Sancarn   56r     REG               1,1   35416151 50270751 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.175/Archive_1.raf.dat
LeagueofL 48299 Sancarn   57r     REG               1,1   20489501 50410420 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.155/Archive_1.raf.dat
LeagueofL 48299 Sancarn   58r     REG               1,1   24781773 50270700 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.155/Archive_3.raf.dat
LeagueofL 48299 Sancarn   59r     REG               1,1   48170941 50410480 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.177/Archive_4.raf.dat
LeagueofL 48299 Sancarn   60r     REG               1,1   10619428 50270736 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.166/Archive_1.raf.dat
LeagueofL 48299 Sancarn   61r     REG               1,1  368150001  2978783 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.119/Archive_3.raf.dat
LeagueofL 48299 Sancarn   62r     REG               1,1   17657214  2978738 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.37/Archive_2.raf.dat
LeagueofL 48299 Sancarn   63r     REG               1,1   15896510 50410559 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.206/Archive_1.raf.dat
LeagueofL 48299 Sancarn   64r     REG               1,1   45715590 50410598 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.222/Archive_1.raf.dat
LeagueofL 48299 Sancarn   65r     REG               1,1   19376484  2978777 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.93/Archive_3.raf.dat
LeagueofL 48299 Sancarn   66r     REG               1,1   43310956 50410567 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.211/Archive_1.raf.dat
LeagueofL 48299 Sancarn   67r     REG               1,1   35207069  2978736 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.34/Archive_2.raf.dat
LeagueofL 48299 Sancarn   68r     REG               1,1   34797224  3218931 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.81/Archive_2.raf.dat
LeagueofL 48299 Sancarn   69r     REG               1,1  112386194 49798651 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.174/Archive_2.raf.dat
LeagueofL 48299 Sancarn   70r     REG               1,1   38818993 50270679 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.146/Archive_4.raf.dat
LeagueofL 48299 Sancarn   71r     REG               1,1   29174452  2978801 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.136/Archive_3.raf.dat
LeagueofL 48299 Sancarn   72r     REG               1,1   36201292  3218939 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.128/Archive_1.raf.dat
LeagueofL 48299 Sancarn   73r     REG               1,1   21262444  2978771 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.88/Archive_2.raf.dat
LeagueofL 48299 Sancarn   74r     REG               1,1   27332113 50410545 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.200/Archive_1.raf.dat
LeagueofL 48299 Sancarn   75r     REG               1,1   53006969  2978787 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.125/Archive_3.raf.dat
LeagueofL 48299 Sancarn   76r     REG               1,1   24422123 50410471 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.172/Archive_2.raf.dat
LeagueofL 48299 Sancarn   77r     REG               1,1    3233548 50270804 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.190/Archive_1.raf.dat
LeagueofL 48299 Sancarn   78r     REG               1,1   28419005 50410517 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.187/Archive_3.raf.dat
LeagueofL 48299 Sancarn   79r     REG               1,1   24403893  2978781 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.117/Archive_3.raf.dat
LeagueofL 48299 Sancarn   80r     REG               1,1   38536621 50410410 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.146/Archive_1.raf.dat
LeagueofL 48299 Sancarn   81r     REG               1,1   27123972  2978803 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.136/Archive_4.raf.dat
LeagueofL 48299 Sancarn   82r     REG               1,1   23859485  2978797 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.135/Archive_3.raf.dat
LeagueofL 48299 Sancarn   83r     REG               1,1   25832243  2978799 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.135/Archive_4.raf.dat
LeagueofL 48299 Sancarn   84r     REG               1,1   17513589 50410402 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.142/Archive_2.raf.dat
LeagueofL 48299 Sancarn   85r     REG               1,1   48914720  3218937 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.122/Archive_1.raf.dat
LeagueofL 48299 Sancarn   86r     REG               1,1    4904955  2978734 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.28/Archive_2.raf.dat
LeagueofL 48299 Sancarn   87r     REG               1,1   22279544  2978764 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.80/Archive_2.raf.dat
LeagueofL 48299 Sancarn   88r     REG               1,1   27458054 50410506 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.184/Archive_1.raf.dat
LeagueofL 48299 Sancarn   89r     REG               1,1   55091721  3230521 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.138/Archive_2.raf.dat
LeagueofL 48299 Sancarn   90r     REG               1,1   62766650 50410489 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.178/Archive_4.raf.dat
LeagueofL 48299 Sancarn   91r     REG               1,1   30634454 50410520 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.187/Archive_4.raf.dat
LeagueofL 48299 Sancarn   92r     REG               1,1   30535556  2978791 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.129/Archive_3.raf.dat
LeagueofL 48299 Sancarn   93r     REG               1,1    4477739  1885924 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.60/Archive_1.raf.dat
LeagueofL 48299 Sancarn   94r     REG               1,1   24876814 50410587 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.217/Archive_1.raf.dat
LeagueofL 48299 Sancarn   95r     REG               1,1   58286338  3230519 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.138/Archive_1.raf.dat
LeagueofL 48299 Sancarn   96r     REG               1,1   14375407 49518884 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.184/Archive_3.raf.dat
LeagueofL 48299 Sancarn   97r     REG               1,1   50105294  2978724 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.8/Archive_2.raf.dat
LeagueofL 48299 Sancarn   98r     REG               1,1   61373150  3218935 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.113/Archive_2.raf.dat
LeagueofL 48299 Sancarn   99r     REG               1,1   28336592  2978758 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.71/Archive_2.raf.dat
LeagueofL 48299 Sancarn  100r     REG               1,1   16386273 50410526 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.193/Archive_1.raf.dat
LeagueofL 48299 Sancarn  101r     REG               1,1   34728469 50410476 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.177/Archive_3.raf.dat
LeagueofL 48299 Sancarn  102r     REG               1,1   17117606 50410524 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.192/Archive_2.raf.dat
LeagueofL 48299 Sancarn  103r     REG               1,1   20568383  2978750 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.55/Archive_2.raf.dat
LeagueofL 48299 Sancarn  104r     REG               1,1   24497779 50410590 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.218/Archive_1.raf.dat
LeagueofL 48299 Sancarn  105r     REG               1,1   21763230 48156358 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.190/Archive_4.raf.dat
LeagueofL 48299 Sancarn  106r     REG               1,1   21371139 50410423 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.156/Archive_4.raf.dat
LeagueofL 48299 Sancarn  107r     REG               1,1      10617  2978805 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.137/Archive_1.raf.dat
LeagueofL 48299 Sancarn  108r     REG               1,1       6082 46937150 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.209/Archive_1.raf.dat
LeagueofL 48299 Sancarn  109r     REG               1,1       1533 46272180 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.207/Archive_1.raf.dat
LeagueofL 48299 Sancarn  110r     REG               1,1      12606  2978742 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.42/Archive_2.raf.dat
LeagueofL 48299 Sancarn  111r     REG               1,1    4408448 49296275 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.163/Archive_3.raf.dat
LeagueofL 48299 Sancarn  112r     REG               1,1      10963 45487426 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.151/Archive_2.raf.dat
LeagueofL 48299 Sancarn  113r     REG               1,1         32  1803931 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.75/Archive_2.raf.dat
LeagueofL 48299 Sancarn  114r     REG               1,1     433516  2392779 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.70/Archive_1.raf.dat
LeagueofL 48299 Sancarn  115r     REG               1,1    6860839  3218943 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.139/Archive_2.raf.dat
LeagueofL 48299 Sancarn  116r     REG               1,1     195957  7958389 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.153/Archive_2.raf.dat
LeagueofL 48299 Sancarn  117r     REG               1,1       8041  1803947 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.89/Archive_2.raf.dat
LeagueofL 48299 Sancarn  118r     REG               1,1     168359  2327624 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.111/Archive_1.raf.dat
LeagueofL 48299 Sancarn  119r     REG               1,1       6725  1803881 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.23/Archive_2.raf.dat
LeagueofL 48299 Sancarn  120r     REG               1,1       4039 50270713 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.162/Archive_2.raf.dat
LeagueofL 48299 Sancarn  121r     REG               1,1       9619 47809101 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.202/Archive_1.raf.dat
LeagueofL 48299 Sancarn  122r     REG               1,1       1197 45487592 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.193/Archive_3.raf.dat
LeagueofL 48299 Sancarn  123r     REG               1,1   18427221  1803953 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.92/Archive_2.raf.dat
LeagueofL 48299 Sancarn  124r     REG               1,1     418628 50270810 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.192/Archive_4.raf.dat
LeagueofL 48299 Sancarn  125r     REG               1,1      39440  3218923 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.58/Archive_1.raf.dat
LeagueofL 48299 Sancarn  126r     REG               1,1       1448  2978773 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.90/Archive_1.raf.dat
LeagueofL 48299 Sancarn  127r     REG               1,1     994584 31187678 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.169/Archive_3.raf.dat
LeagueofL 48299 Sancarn  128r     REG               1,1      89170 10397077 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.168/Archive_1.raf.dat
LeagueofL 48299 Sancarn  129r     REG               1,1     331846  1803935 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.78/Archive_2.raf.dat
LeagueofL 48299 Sancarn  130r     REG               1,1      17724  6428309 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.154/Archive_2.raf.dat
LeagueofL 48299 Sancarn  131r     REG               1,1    3056591  8026009 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.165/Archive_2.raf.dat
LeagueofL 48299 Sancarn  132r     REG               1,1       4862  7311933 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.157/Archive_2.raf.dat
LeagueofL 48299 Sancarn  133r     REG               1,1      11746 49798779 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client/filearchives/0.0.0.220/Archive_1.raf.dat
LeagueofL 48299 Sancarn  134u  KQUEUE                                       count=2, state=0x2
LeagueofL 48299 Sancarn  135r     REG               1,1    3759122 33218426 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/SystemAppearance.car
LeagueofL 48299 Sancarn  136r     REG               1,1    1966248 33218424 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/GraphiteAppearance.car
LeagueofL 48299 Sancarn  137r     REG               1,1    3504343 33218417 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/AccessibilityAppearance.car
LeagueofL 48299 Sancarn  138r     REG               1,1    1919257 33218420 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/AccessibilityGraphiteAppearance.car
LeagueofL 48299 Sancarn  139r     REG               1,1    3165507 33218422 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/DarkAppearance.car
LeagueofL 48299 Sancarn  140r     REG               1,1     245316 33218425 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/GraphiteDarkAppearance.car
LeagueofL 48299 Sancarn  141r     REG               1,1    2938766 33218418 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/AccessibilityDarkAppearance.car
LeagueofL 48299 Sancarn  142r     REG               1,1     231386 33218419 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/AccessibilityDarkGraphiteAppearance.car
LeagueofL 48299 Sancarn  143r     REG               1,1     438962 33218427 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/VibrantLightAppearance.car
LeagueofL 48299 Sancarn  144r     REG               1,1     129990 33218421 /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/AccessibilityVibrantLightAppearance.car
LeagueofL 48299 Sancarn  145w     REG               1,1          0 49801017 /Applications/League of Legends.app/Contents/LoL/RADS/solutions/lol_game_client_sln/releases/0.0.0.223/deploy/RandomGenerator0.log
LeagueofL 48299 Sancarn  146u    IPv4 0x911349989830ff9        0t0      TCP localhost:63508->localhost:8394 (ESTABLISHED)
LeagueofL 48299 Sancarn  147w     REG               1,1       8192 52052478 /Applications/League of Legends.app/Contents/LoL/Logs/Network Logs/2016-08-29T01-48-47_netlog.txt
LeagueofL 48299 Sancarn  148u    IPv4 0x9113499826fca19        0t0      UDP *:55642
LeagueofL 48299 Sancarn  149r     REG               1,1    5425538 33224462 /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/HIToolbox.framework/Versions/A/Resources/Extras2.rsrc
LeagueofL 48299 Sancarn  150u   systm                          0t0          
LeagueofL 48299 Sancarn  151u    unix 0x91134999644cb41        0t0          ->0x91134999644ccd1
LeagueofL 48299 Sancarn  152u     REG               1,1       1008 52052486 /Users/Sancarn/Library/Saved Application State/com.riotgames.LeagueofLegends.GameClient.savedState/data.data
LeagueofL 48299 Sancarn  153w     REG               1,1        373 52052487 /Users/Sancarn/Library/Saved Application State/com.riotgames.LeagueofLegends.GameClient.savedState/windows.plist
LeagueofL 48299 Sancarn  154u     REG               1,1       3520 52052488 /Users/Sancarn/Library/Saved Application State/com.riotgames.LeagueofLegends.GameClient.savedState/window_1.data
LeagueofL 48299 Sancarn  155w     REG               1,1          0 49801105 /Applications/League of Legends.app/Contents/LoL/RADS/solutions/lol_game_client_sln/releases/0.0.0.223/deploy/RandomGenerator1.log
LeagueofL 48299 Sancarn  156r     REG               1,1    8483156 46937328 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client_en_gb/managedfiles/0.0.0.216/DATA/Sounds/Wwise/VO/en_US/Shared/Announcer_Global_Female1_VO_audio.wpk
LeagueofL 48299 Sancarn  157r     REG               1,1     751266 44741857 /Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client_en_gb/managedfiles/0.0.0.208/DATA/Sounds/Wwise/VO/en_US/Characters/Annie/Skins/Base/Annie_Base_VO_audio.wpk
```

These files should be analysed for changes while playing a game of LoL. Try to spot patterns etc. These may be a nice client side comprimise, without having to analyse packets.

# Assuming we do need to analyse packets...

Using Wireshark:
Use filter ``` ip.addr == 185.40.66.171 ``` to filter out Source/Destination of Riot Games Limited (EUW).
Use filter ``` ip.src == 185.40.66.171 ``` to filter Riot Server to PC Client messages.
Use filter ``` ip.dst == 185.40.66.171 ``` to filter PC Client to Riot Server messages.

From here we have the oppertunity to test certain things. Activate ability, call events like pings etc. And then we can analyse the packets sent to Riot's server from us. We can also analyse packets sent to use from Riot - allied pings for example.

# Other dirty analysis

For a sound pack, in the end, we don't need a full proof mechanism which is 100% accurate. We would like to determine when certain events occur, however these events can largely be seen through the UI. For example which champion have you picked?

![PickChamp](http://i.imgur.com/M2C677E.png)

From the main menu you can even get people's names and from an OCR you can extract text in game:

![InGameOCR](http://i.imgur.com/MkDK82w.jpg)

returns

```
1W“? 12/0/0 ‘44 “46:51
FPS:I58 331m

[10:55] Gnarph LaDiv (Kog‘May/J4 o i think
[ jsrp‘gakn 5 jew (Leona): not evﬁﬁ cod oneseitherme

[12:5 I] svyyvﬁaﬁm wShyvm is o mmg spree!

[13:49] Gnarph (Kog‘Maw) signalsgghaf gmwes are missing

[ :57] FTUmP Mahou (Ahri) 15 on a 45:35 spree!

11:36] Gnarph (Kog’Maw) has cfmmxisgr’ mm bounty! (Team Gold:
1506) 1 $1”

315.50] Sancarn (Leona) Elgnals thatjnemles are missing

’783 '0

F1117 Q47
7410.77 ‘71036
0 ’3 397

’ Image;
A.- E. k/- \
\ 1705/1 u;
611/611 M'
```

from an online OCR. Data harvesting like this may be an option for extracting some information out of the LoL client. Similarly image searching could be used to determine, which champion is being used, when the active champion is out of mana, health, and also how much health the team has accross the board. These are all things the player has access to via his/her senses
