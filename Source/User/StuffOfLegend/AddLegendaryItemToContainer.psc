Scriptname StuffOfLegend:AddLegendaryItemToContainer extends ObjectReference

LegendaryItemQuestScript Property LegendaryItemQuest Auto Const Mandatory

bool Property UseLockLevelChances = false Auto Const

GlobalVariable Property DefaultLegendaryChance Auto Const
{Must be provided if UseLockLevelChances is false - this is the chance that a legendary item will be added}

GlobalVariable Property LockExpertChanceLegendaryChance Auto Const
{If provided and UseLockLevelChances is true, an Expert lock has this chance that a legendary item will be added}

GlobalVariable Property LockMasterChanceLegendaryChance Auto Const
{If provided and UseLockLevelChances is true, an Master lock has this chance that a legendary item will be added}

LeveledItem Property LegendaryItemToAdd = None Auto Const
{Used to override the eligible legendary items - by default, all eligible legendary items will be used}

Function AddLegendaryItemWithChance(int percentChance)
    if Utility.RandomInt(1, 100) <= percentChance
        LegendaryItemQuest.GenerateLegendaryItem(self, LegendaryItemToAdd)
    endIf
EndFunction

AUTO STATE startState

	EVENT OnLoad()
	    
        if UseLockLevelChances
            ; Master
	        if(self.getLockLevel() >= 100)
                AddLegendaryItemWithChance(LockMasterChanceLegendaryChance.GetValueInt())
            ; Expert
            elseif(self.getLockLevel() >= 75)
                AddLegendaryItemWithChance(LockExpertChanceLegendaryChance.GetValueInt())
            endIf
        else
            AddLegendaryItemWithChance(DefaultLegendaryChance.GetValueInt())
        endIf

	    goToState("doNothing")

	ENDEVENT

ENDSTATE

; Make sure we only add the items once
STATE doNothing

	EVENT OnLoad()
	ENDEVENT

ENDSTATE