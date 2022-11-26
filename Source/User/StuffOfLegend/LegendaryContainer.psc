Scriptname StuffOfLegend:LegendaryContainer extends ObjectReference

StuffOfLegend:LegendaryContainerQuest Property LegendaryContainerQuest Auto Const Mandatory

bool Property UseLockLevelChances = false Auto Const
{If true, the container will only have a chance at a legendary item if it has a high enough lock level}

AUTO STATE startState

	EVENT OnLoad()
	    LegendaryContainerQuest.AddLegendaryItemToContainer(self)

	    goToState("doNothing")

	ENDEVENT

ENDSTATE

; Make sure we only add the items once
STATE doNothing

	EVENT OnLoad()
	ENDEVENT

ENDSTATE