Scriptname StuffOfLegend:MergeNamingRulesQuest extends Quest

struct NamingMerge
    InstanceNamingRules Destination
    InstanceNamingRules Source
EndStruct

NamingMerge[] Property NamingMergeRules Auto Const Mandatory
int Property MergeDelaySeconds = 120 Auto Const Mandatory
{Delay before the merge should occur on start-up, useful when merging out of common lists that other quests will inject into}

Event OnQuestInit()
    if MergeDelaySeconds > 0
        StartTimer(MergeDelaySeconds)
    else
        MergeNamingRules()
        Stop()
    endIf
EndEvent

Function MergeNamingRules()
    int i = 0
    while i < NamingMergeRules.Length
        NamingMerge mergeRule = NamingMergeRules[i]
        debug.trace(self + " Merging " + mergeRule.Source + " into " + mergeRule.Destination)
        mergeRule.Destination.MergeWith(mergeRule.Source)
        i += 1
    EndWhile
EndFunction

Event OnTimer(int aiTimerID)
    MergeNamingRules()
    Stop()
EndEvent