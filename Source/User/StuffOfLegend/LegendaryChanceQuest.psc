Scriptname StuffOfLegend:LegendaryChanceQuest extends Quest

Event OnQuestInit()
    SetLegendaryChance()
    Stop()
EndEvent

Function SetLegendaryChance()
    float chance = GetLegendaryChanceByLevel() * LegendaryChanceMultiplier.GetValue()
    debug.trace(self + " Setting legendary chance to " + chance + " (multiplier = " + LegendaryChanceMultiplier.GetValue() + ")")
    ChanceLegendary.SetValue(chance)
EndFunction

int Function GetLegendaryChanceByLevel()
    if game.GetPlayer().GetLevel() > 50
        return 20
    elseif game.GetPlayer().GetLevel() > 40
        return 18
    elseif game.GetPlayer().GetLevel() > 30
        return 15
    elseif game.GetPlayer().GetLevel() > 20
        return 12
    elseif game.GetPlayer().GetLevel() > 5
        return 10
    endif
EndFunction

Function ModChanceMultiplier(float afAmountToAdd)
    LegendaryChanceMultiplier.SetValue(LegendaryChanceMultiplier.GetValue() + afAmountToAdd)
    SetLegendaryChance()
EndFunction

GlobalVariable Property ChanceLegendary Auto Const
GlobalVariable Property LegendaryChanceMultiplier Auto Const