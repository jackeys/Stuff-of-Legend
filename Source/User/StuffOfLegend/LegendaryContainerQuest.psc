Scriptname StuffOfLegend:LegendaryContainerQuest extends Quest

LegendaryItemQuestScript Property LegendaryItemQuest Auto Const Mandatory

LegendaryChance Property DefaultLegendaryChance Auto Mandatory
{Must be provided if UseLockLevelChances is false - this is the chance that a legendary item will be added}

LegendaryChance Property LockExpertChanceLegendaryChance Auto Mandatory
{If the container uses lock levels, an Expert lock has this chance that a legendary item will be added}

LegendaryChance Property LockMasterChanceLegendaryChance Auto Mandatory
{If the container uses lock levels, a Master lock has this chance that a legendary item will be added}

int Property MinimumPlayerLevel = 6 Auto
{If the player isn't at least this level, no legendary items will spawn}

Struct LegendaryChance
    GlobalVariable PercentChance
    int ConsecutiveNoItemCount = 0
    {Used for tracking state - no value should be provided}
EndStruct

bool Function AddLegendaryItemWithChance(StuffOfLegend:LegendaryContainer akContainer, LegendaryChance akChance, LeveledItem akEligibleItems = None)
    if Utility.RandomInt(1, 100) <= akChance.percentChance.getValueInt() || HasBeenTooLongSinceLastItem(akChance)
        debug.trace(self + " adding item to " + akContainer)
        LegendaryItemQuest.GenerateLegendaryItem(akContainer, akEligibleItems)
        akChance.ConsecutiveNoItemCount = 0
    else
        akChance.ConsecutiveNoItemCount = akChance.ConsecutiveNoItemCount + 1
        debug.trace(self + " didn't add an item to " + akContainer + " - increased consecutive no item count " + akChance)
    endIf
EndFunction

bool Function HasBeenTooLongSinceLastItem(LegendaryChance akChance)
    int percentChance = akChance.percentChance.getValueInt()
    if percentChance <= 0
        return false
    endIf

    ; We don't want a player to feel too unlucky, so we won't let the random chance keep rolling against them
    ; For example, if there is a 5% chance, 1/20 containers should have a legendary item
    ; If we've gone 22 containers without giving an item, just give in now
    return akChance.ConsecutiveNoItemCount > (100 / percentChance) + 2
EndFunction

Function AddLegendaryItemToContainer(StuffOfLegend:LegendaryContainer akContainer, LeveledItem akEligibleItems = None)
        if Game.GetPlayer().GetLevel() < MinimumPlayerLevel
            return
        endIf

        if akContainer.UseLockLevelChances
            ; Master
	        if(akContainer.getLockLevel() >= 100)
                AddLegendaryItemWithChance(akContainer, LockMasterChanceLegendaryChance)
            ; Expert
            elseif(akContainer.getLockLevel() >= 75)
                AddLegendaryItemWithChance(akContainer, LockExpertChanceLegendaryChance)
            endIf
        else
            AddLegendaryItemWithChance(akContainer, DefaultLegendaryChance)
        endIf
EndFunction