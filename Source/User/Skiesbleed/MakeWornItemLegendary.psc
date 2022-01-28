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

GlobalVariable Property LegendaryWeaponChance Auto Const Mandatory
{The chance that the enemy's weapon will be selected as the legendary item instead of their armor}

Event OnEffectStart(Actor akTarget, Actor akCaster)
    if !AddLegendaryModToEquippedItem(akTarget) && GenerateNewItemIfNoneFound && GenerateNewItemIfNoneFound.GetValueInt() > 0
	    LegendaryItemQuest.GenerateLegendaryItem(akTarget)
    EndIf
EndEvent

bool Function AddLegendaryModToEquippedItem(Actor akTarget)
    bool success = false

    if Utility.RandomInt(0, 100) > LegendaryWeaponChance.GetValueInt()
        debug.trace(self + " is going to make legendary armor")
        success = AddLegendaryModToEquippedItemWithKeyword(akTarget, AllowedArmorKeywords)

        if !success
            debug.trace(self + " falling back to a legendary weapon because making legendary armor failed")
            success = AddLegendaryModToEquippedItemWithKeyword(akTarget, AllowedWeaponKeywords)
        EndIf
    else
        debug.trace(self + " is going to make a legendary weapon")
        success = AddLegendaryModToEquippedItemWithKeyword(akTarget, AllowedWeaponKeywords)

        if !success
            debug.trace(self + " falling back to legendary armor because making a legendary weapon failed")
            success = AddLegendaryModToEquippedItemWithKeyword(akTarget, AllowedArmorKeywords)
        EndIf
    endIf

    return success
EndFunction

bool Function AddLegendaryModToEquippedItemWithKeyword(Actor akTarget, FormList akKeywords)
    debug.trace(self + " looking for eligible equipment to make legendary")

    bool makeWeaponLegendary = Utility.RandomInt(0, 100) > LegendaryWeaponChance.GetValueInt()

    ; Requires F4SE
    Form[] inventory = akTarget.GetInventoryItems()

    Form[] eligibleEquipment = new Form[0]
    int i = 0
    while(i < inventory.length)
        Form  item = inventory[i]

        if item.HasKeywordInFormList(akKeywords) && (!ExcludeKeywordsList || !item.HasKeywordInFormList(ExcludeKeywordsList))
            eligibleEquipment.Add(item)
        endif

        i += 1
    endwhile

    ; If we have at least one eligible item, randomly select one to get a legendary mod
    ; Keep trying until we succeed, in case the item doesn't have the proper attach point, doesn't have any allowed legendary rules, etc
    while eligibleEquipment.length > 0
        int chosenIndex = Utility.RandomInt(0, eligibleEquipment.length - 1)
        debug.trace(akTarget + "Selecting item at index " + chosenIndex + " out of " + eligibleEquipment.length + " total")
        Form itemToMod = eligibleEquipment[chosenIndex]

        if AddLegendaryMod(akTarget, itemToMod)
            ; Attaching a mod to an equipped weapon will prevent the actor from equipping it again, so let's make sure they are using it
            akTarget.EquipItem(itemToMod)
            return true
        else
            eligibleEquipment.Remove(chosenIndex)
        endIf
    endWhile
    
    debug.trace(akTarget + "No equipment found to attach a legendary mod to")
    return false
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