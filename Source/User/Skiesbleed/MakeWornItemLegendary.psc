Scriptname Skiesbleed:MakeWornItemLegendary extends activemagiceffect
{Makes a worn item legendary (F4SE required). If no worn items have a legendary attach point, can optionally create a new legendary item to add to the target's inventory instead.}

LegendaryItemQuestScript Property LegendaryItemQuest Auto Const Mandatory
{AUTOFILL}

GlobalVariable Property GenerateNewItemIfNoneFound Auto Const
{If provided, this boolean global determines if a brand new item should be created from the standard legendary drop lists if there are no items in the reference's inventory that can be made legendary}

FormList Property AllowedWeaponKeywords Auto Const Mandatory
{If an item has any of the keywords on this list, it will be considered to be a weapon that can have a legendary mod}

FormList Property AllowedArmorKeywords Auto Const Mandatory
{If an item has any of the keywords on this list, it will be considered to be armor that can have a legendary mod}

FormList Property ExcludeKeywordsList Auto Const
{If any of the keywords in this form list are present on an item, it will be excluded from the eligible equipment for a legendary mod}

Event OnEffectStart(Actor akTarget, Actor akCaster)
    if !AddLegendaryModToEquippedItem(akTarget) && GenerateNewItemIfNoneFound && GenerateNewItemIfNoneFound.GetValueInt() > 0
	    LegendaryItemQuest.GenerateLegendaryItem(akTarget)
    EndIf
EndEvent

bool Function AddLegendaryModToEquippedItem(Actor akTarget)
    debug.trace(self + " looking for eligible equipment to make legendary")

    ; Requires F4SE
    Form[] inventory = akTarget.GetInventoryItems()

    Form[] eligibleEquipment = new Form[0]
    int i = 0
    while(i < inventory.length)
        Form  item = inventory[i]

        if (item.HasKeywordInFormList(AllowedWeaponKeywords) || item.HasKeywordInFormList(AllowedArmorKeywords)) && (!ExcludeKeywordsList || !item.HasKeywordInFormList(ExcludeKeywordsList))
            debug.trace(akTarget + "Item " + item + " in inventory has an eligible keyword for a legendary mod")
            eligibleEquipment.Add(item)
        endif

        i += 1
    endwhile

    bool success = false

    ; If we have at least one eligible item, randomly select one to get a legendary mod
    int numPieces = eligibleEquipment.length
    if numPieces > 0
        int chosenIndex = Utility.RandomInt(0, numPieces - 1)
        debug.trace(akTarget + "Selecting item at index " + chosenIndex + " out of " + numPieces + " total")
        Form itemToMod = eligibleEquipment[chosenIndex]
        success = AddLegendaryMod(akTarget, itemToMod)
        ; Attaching a mod to an equipped weapon will prevent the actor from equipping it again, so let's make sure they are using it
        akTarget.EquipItem(itemToMod)
    else
        debug.trace(akTarget + "No equipment found to attach a legendary mod to")
    endif

    return success
EndFunction

bool Function AddLegendaryMod(ObjectReference akRecipient, Form  item, FormList ListOfSpecificModsToChooseFrom = None, FormList ListOfSpecificModsToDisallow = None)
	debug.trace(akRecipient + "Attaching legendary mod to inventory item " + item)

	; Create a temporary reference so we can use the base game's legendary item quest and all of its legendary mod rules
	ObjectReference itemObject = akRecipient.PlaceAtMe(item, aiCount = 1, abForcePersist = false, abInitiallyDisabled = true, abDeleteWhenAble = false)
	
	;GET THE MODS WE CAN INSTALL ON THIS ITEM
	ObjectMod[] AllowedMods = LegendaryItemQuest.GetAllowedMods(itemObject, ListOfSpecificModsToChooseFrom, ListOfSpecificModsToDisallow)

	itemObject.Delete()

    bool success = false

	;ROLL A DIE AND PICK A MOD
	int max = AllowedMods.Length
	if max > 0
		int dieRoll = Utility.RandomInt(0, max - 1)

		ObjectMod legendaryMod = AllowedMods[dieRoll]

		debug.trace(akRecipient + " Attaching " + legendaryMod + " to inventory item " + item)

		success = akRecipient.AttachModToInventoryItem(item, legendaryMod)

		if !success
			debug.trace(akRecipient + " Failed to attach " + legendaryMod + " to "+ item)
		endif
		
	else
		debug.trace(akRecipient + " AddLegendaryMod() could not find any appropriate Legendary Mods to add to item: " + item)
	endif

    return success
EndFunction