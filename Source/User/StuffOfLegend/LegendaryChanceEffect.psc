Scriptname StuffOfLegend:LegendaryChanceEffect extends activemagiceffect const
{Makes a worn item legendary (F4SE required). If no worn items have a legendary attach point, can optionally create a new legendary item to add to the target's inventory instead.}

StuffOfLegend:LegendaryChanceQuest Property LegendaryChanceQuest Auto Const Mandatory
{AUTOFILL}

float Property AddToLegendaryChanceModifier Auto Const Mandatory
{How much to add to the legendary chance multiplier (e.g. 0.5 would multiply the legendary chance by 50%)}

Event OnEffectStart(Actor akTarget, Actor akCaster)
    LegendaryChanceQuest.ModChanceMultiplier(AddToLegendaryChanceModifier)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    LegendaryChanceQuest.ModChanceMultiplier(-AddToLegendaryChanceModifier)
EndEvent