# Stuff of Legend

Stuff of Legend is a Fallout 4 mod that reimagines the legendary drop system for Fallout 4, creating different types of legendary items depending on the legendary enemy type. These drop types are intended to feel more thematic as well as unlocking new gameplay possibilities.

* Animals and bugs drop mutated organs which each grant a long-lasting special ability when consumed. They are highly irradiated, and while cooking will reduce that, you can't completely remove it.
* Feral ghouls drop irradiated trinkets, old personal items that have stayed with them through their transformation and taken on a special ability. Beware, though - they are a constant source of radiation.
* Robots have drop legendary mods, special components with a specific effect that can be used to turn an eligible weapon or armor piece into a legendary one. These mods are one-time use only.
* People carrying their own weapons and armor will have something they already own converted to a legendary item. Don't let your guard down, though, because every now and again one of them may have scavenged something unexpected.
* Trunks at the end of each area and safes with Master locks have a chance to contain a random legendary item, stashed away for safe keeping.

The mod uses ESL-flagged ESPs.

## Using the Mod

It is highly recommended that you download the latest release from [NexusMods](https://www.nexusmods.com/fallout4/mods/66551). You can also see screenshots of the mod in action, post comments, and file any issues you encounter there.

## Building a Release
A release is a zip file that includes the `fomod` directory, which contains the installer information for a FOMOD-compatible mod manager such as [Vortex](https://www.nexusmods.com/about/vortex/), and the `Content` directory, which includes the actual files that make up the mod. To create a release, simply run `release.bat`.

By default, `release.bat` will use the current date as the version. However, you may provide a parameter to include a specific version, such as `release.bat 1.0.0`. This is especially useful in combination with [FOMOD Creation Tool](https://www.nexusmods.com/fallout4/mods/6821), where you can specify a script to run after saving that uses the version included in the FOMOD installer:

```
start /d "C:\path\to\this\directory" release.bat $MODVERSION$
```