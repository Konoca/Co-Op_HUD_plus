# Co-Op HUD+
A mod for The Binding of Isaac: Repentence that changes the HUD to better display information when playing with multiple people. This mod is based on coopHUD by Srokks, which is no longer being updated.

This mod is currently a work-in-progress, please report all issues under "Issues".

## Features
* Renders active items, hearts, pocket items, and trinkets in a readable position for all four players
* Stats for all four players displayed relative to their character info (P1 and P3 on left, P2 and P4 on right)
* Player color coding (P1 Blue, P2 Red, P3 Green, P4 Yellow)
* Press H to switch between Co-Op HUD+ and the default HUD
* Timer always shown at the top of the screen
* Tainted Isaac Inventory correctly displayed for all players
* Tainted ??? Poop Spells correctly displayed for all players
* Tainted Cain Bag of Crafting correctly displayed for all players
* Entirely customizable! (MCM still WIP, but config file can be edited)

## Required Mods
* MinimapAPI (https://steamcommunity.com/sharedfiles/filedetails/?id=1978904635)
    * Needed to display minimap
* Enhanced Boss Bars (https://steamcommunity.com/sharedfiles/filedetails/?id=2635267643)
    * Needed to display boss hp
* Repentogon (https://steamcommunity.com/sharedfiles/filedetails/?id=3127536138)
    * API extender
    * Heads up! This mod can not be installed like a normal mod. Please read the mod description for more info.

## Supported Mods
* External Item Descriptions (https://steamcommunity.com/sharedfiles/filedetails/?id=836319872)
    * Display item name and what they do before picking it up
* Mod Config Menu (https://steamcommunity.com/sharedfiles/filedetails/?id=2681875787)
    * Allow users to customize HUD

## Recommended Mods to Enhance HUD
* Boss Rush Wave Counter (https://steamcommunity.com/sharedfiles/filedetails/?id=2492654252)
    * Displays wave counter for boss rush, similar to Greed mode
* Unintrusive Pause Menu (https://steamcommunity.com/sharedfiles/filedetails/?id=2769063897)
    * Replaces pause menu to allow the level to still be seen 
* Encyclopedia (https://steamcommunity.com/sharedfiles/filedetails/?id=2376005362)
    * Allows players to check their current items and what they do

## Customization
The placement of almost everything can be changed within `coopHUDplus_config.lua`

## Acknowledgements
Srokks (https://steamcommunity.com/id/srokks)
*  coopHUD (https://steamcommunity.com/sharedfiles/filedetails/?id=2731267631) was used to aid in development, specifically:
    * How to overhaul HUD
    * How to create objects in Lua (I literally have never used Lua outside of CC: Tweaked)
    * Item animation file
    * Bethany & T. Bethany charge bar color
    * Stat placement
    * Coin, Key, Bomb, etc. placement

wofsauge (https://steamcommunity.com/id/Wofsauge, https://github.com/wofsauge) 
* TBoI Lua API Documentation (https://wofsauge.github.io/IsaacDocs/rep/index.html)
* reHUD (https://steamcommunity.com/sharedfiles/filedetails/?id=1906405707) was used to aid in development, specifically:
    * Top-Centered Timer

_Kilburn
* Lead developer of Antibirth mod
* Code of theirs was used in reHUD, which I made use of

The Modding of Isaac Discord server (https://discord.gg/KbevtvgD4z)
* Very helpful community
