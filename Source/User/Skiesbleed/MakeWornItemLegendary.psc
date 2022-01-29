Scriptname Skiesbleed:MakeWornItemLegendary extends activemagiceffect const
{Makes a worn item legendary (F4SE required). If no worn items have a legendary attach point, can optionally create a new legendary item to add to the target's inventory instead.}

LegendaryItemQuestScript Property LegendaryItemQuest Auto Const Mandatory
{AUTOFILL}
Skiesbleed:WornLegendaryItemQuest Property WornLegendaryItemQuest Auto Const Mandatory
{AUTOFILL}

GlobalVariable Property GenerateNewItemIfNoneFound Auto Const Mandatory
{This boolean global determines if a brand new item should be created from the standard legendary drop lists if there are no items in the reference's inventory that can be made legendary}

FormList Property AllowedWeaponKeywords Auto Const Mandatory
{If an item has any of the keywords on this list, it will be considered to be a weapon that can have a legendary mod}

FormList Property AllowedArmorKeywords Auto Const Mandatory
{If an item has any of the keywords on this list, it will be considered to be armor that can have a legendary mod}

FormList Property ExcludeKeywordsList Auto Const
{If any of the keywords in this form list are present on an item, it will be excluded from the eligible equipment for a legendary mod}

GlobalVariable Property LegendaryWeaponChance Auto Const Mandatory
{The chance that the enemy's weapon will be selected as the legendary item instead of their armor}

GlobalVariable Property GeneratedWeaponChance Auto Const Mandatory
{The chance that the enemy will get a new legendary weapon instead of changing their own}

LeveledItem Property GeneratedWeapon Auto Const Mandatory
{The weapon list to use to generate weapons if the chance is rolled}

GlobalVariable Property GeneratedArmorChance Auto Const Mandatory
{The chance that the enemy will get a new legendary armor instead of changing their own}

LeveledItem Property GeneratedArmor Auto Const Mandatory
{The armor list to use to generate armors if the chance is rolled}

GlobalVariable Property UseLegendaryWeaponChanceForGeneratedItems Auto Const Mandatory
{This boolean global variable indicates if a weapon should be generated based on GeneratedWeaponChance instead of just using the base game's list}

GlobalVariable Property MaxItemsMade_Legendary Auto Const Mandatory
{The upper bound for the number of legendary items that will be created. Must be at least 1}

GlobalVariable Property MaxItemsMade_Normal Auto Const Mandatory
{The upper bound for the number of legendary items that will be created. Must be at least 1}

Keyword Property EncTypeLegendary Auto Const Mandatory
{AUTOFILL}

Event OnEffectStart(Actor akTarget, Actor akCaster)
    CreateLegendaryItems(akTarget)
EndEvent

Function CreateLegendaryItems(Actor akTarget)
    Form[] eligibleWeapons = GetEligibleInventoryItems(akTarget, AllowedWeaponKeywords)
    Form[] eligibleArmor = GetEligibleInventoryItems(akTarget, AllowedArmorKeywords)
    int numLegendaries = GetNumberOfLegendariesToCreate(akTarget)
    int i = 0

    debug.trace(self + " is creating " + numLegendaries + " legendaries for " + akTarget)

    while i < numLegendaries
        CreateLegendaryItem(akTarget, eligibleWeapons, eligibleArmor)
        i += 1
    endWhile
EndFunction

Function CreateLegendaryItem(Actor akTarget, Form[] aaEligibleWeapons, Form[] aaEligibleArmor)
    bool success = false

    if Utility.RandomInt(1, 100) <= LegendaryWeaponChance.GetValueInt()
        success = CreateLegendaryWeapon(akTarget, aaEligibleWeapons)
        
        if !success
            if UseLegendaryWeaponChanceForGeneratedItems.GetValueInt() > 0
                debug.trace(self + " generating a new legendary weapon because making a legendary weapon failed")
                LegendaryItemQuest.GenerateLegendaryItem(akTarget, GeneratedWeapon)
                success = true
            else
                debug.trace(self + " falling back to legendary armor because making a legendary weapon failed")
                success = CreateLegendaryArmor(akTarget, aaEligibleArmor)
            EndIf
        EndIf
    else
        success = CreateLegendaryArmor(akTarget, aaEligibleArmor)
        
        if !success
            if UseLegendaryWeaponChanceForGeneratedItems.GetValueInt() > 0
                debug.trace(self + " generating new legendary armor because making legendary armor failed")
                LegendaryItemQuest.GenerateLegendaryItem(akTarget, GeneratedArmor)
                success = true
            else
                debug.trace(self + " falling back to a legendary weapon because making legendary armor failed")
                success = CreateLegendaryWeapon(akTarget, aaEligibleWeapons)
            EndIf
        EndIf
    endIf

    if !success && GenerateNewItemIfNoneFound.GetValueInt() > 0
        debug.trace(self + " generating a new legendary item, since equipment couldn't be made legendary")
	    LegendaryItemQuest.GenerateLegendaryItem(akTarget)
    EndIf
EndFunction

bool Function CreateLegendaryWeapon(Actor akTarget, Form[] aaEligibleWeapons)
    debug.trace(self + " is going to make a legendary weapon")
    
    if Utility.RandomInt(1, 100) <= GeneratedWeaponChance.GetValueInt()
        debug.trace(self + " generating a new legendary weapon")
        LegendaryItemQuest.GenerateLegendaryItem(akTarget, GeneratedWeapon)
        return true
    else
        return AddLegendaryModToEquippedItem(akTarget, aaEligibleWeapons)
    EndIf
EndFunction

bool Function CreateLegendaryArmor(Actor akTarget, Form[] aaEligibleArmor)
    debug.trace(self + " is going to make legendary armor")

    if Utility.RandomInt(1, 100) <= GeneratedArmorChance.GetValueInt()
        debug.trace(self + " generating a new legendary armor")
        LegendaryItemQuest.GenerateLegendaryItem(akTarget, GeneratedArmor)
        return true
    else
        return AddLegendaryModToEquippedItem(akTarget, aaEligibleArmor)
    EndIf
EndFunction

bool Function AddLegendaryModToEquippedItem(Actor akTarget, Form[] aaEligibleEquipment)
    debug.trace(self + " looking for eligible equipment to make legendary")

    ; If we have at least one eligible item, randomly select one to get a legendary mod
    ; Keep trying until we succeed, in case the item doesn't have the proper attach point, doesn't have any allowed legendary rules, etc
    while aaEligibleEquipment.length > 0
        int chosenIndex = Utility.RandomInt(0, aaEligibleEquipment.length - 1)
        debug.trace(akTarget + "Selecting item at index " + chosenIndex + " out of " + aaEligibleEquipment.length + " total")
        Form itemToMod = aaEligibleEquipment[chosenIndex]
        aaEligibleEquipment.Remove(chosenIndex)

        if WornLegendaryItemQuest.AddLegendaryMod(akTarget, itemToMod)
            ; Attaching a mod to an equipped weapon will prevent the actor from equipping it again, so let's make sure they are using it
            akTarget.EquipItem(itemToMod)
            return true
        endIf
    endWhile
    
    debug.trace(akTarget + "No equipment found to attach a legendary mod to")
    return false
EndFunction

int Function GetNumberOfLegendariesToCreate(Actor akTarget)
    if akTarget.HasKeyword(EncTypeLegendary)
        return Utility.RandomInt(1, MaxItemsMade_Legendary.GetValueInt())
    else
        return Utility.RandomInt(1, MaxItemsMade_Normal.GetValueInt())
    endIf
EndFunction

Form[] Function GetEligibleInventoryItems(Actor akActor, FormList akAllowedKeywords)
    ; Requires F4SE
    Form[] inventory = akActor.GetInventoryItems()

    Form[] eligibleEquipment = new Form[0]
    int i = 0
    while(i < inventory.length)
        Form  item = inventory[i]

        if item.HasKeywordInFormList(akAllowedKeywords) && (!ExcludeKeywordsList || !item.HasKeywordInFormList(ExcludeKeywordsList))
            eligibleEquipment.Add(item)
        endif

        i += 1
    endwhile

    return eligibleEquipment
EndFunction