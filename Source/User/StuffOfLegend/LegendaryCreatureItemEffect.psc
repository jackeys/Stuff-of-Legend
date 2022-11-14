Scriptname StuffOfLegend:LegendaryCreatureItemEffect extends activemagiceffect const
{Makes a worn item legendary (F4SE required). If no worn items have a legendary attach point, can optionally create a new legendary item to add to the target's inventory instead.}

LegendaryItemQuestScript Property LegendaryItemQuest Auto Const Mandatory
{AUTOFILL}
StuffOfLegend:WornLegendaryItemQuest Property WornLegendaryItemQuest Auto Const Mandatory
{AUTOFILL}

GlobalVariable Property GenerateNewItemIfNoneFound Auto Const Mandatory
{This boolean global determines if a brand new item should be created from the standard legendary drop lists if there are no items in the reference's inventory that can be made legendary}

FormList Property AllowedWeaponKeywords Auto Const Mandatory
{If an item has any of the keywords on this list, it will be considered to be a weapon that can have a legendary mod}

FormList Property AllowedArmorKeywords Auto Const Mandatory
{If an item has any of the keywords on this list, it will be considered to be armor that can have a legendary mod}

FormList Property ExcludeKeywordsList Auto Const Mandatory
{If any of the keywords in this form list are present on an item, it will be excluded from the eligible equipment for a legendary mod}

FormList Property AlwaysAllowedKeywordsList Auto Const Mandatory
{Any items with keywords on this list are always allowed, even if they have a keyword on the excluded list}

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

GlobalVariable Property StrictlyEnforceWeaponChanceWhenEquipmentAvailable Auto Const Mandatory
{This boolean global variable indicates if a weapon should be generated if the weapon chance selected a weapon, even if armor is available}

GlobalVariable Property StrictlyEnforceWeaponChanceWhenEquipmentUnavailable Auto Const Mandatory
{This boolean global variable indicates if the weapon chance should be used to manually generate weapons/armor instead of using the game's base list. May affect mod compatibility}

GlobalVariable Property MaxItemsMade_Legendary Auto Const Mandatory
{The upper bound for the number of legendary items that will be created. Must be at least 1}

GlobalVariable Property MaxItemsMade_Normal Auto Const Mandatory
{The upper bound for the number of legendary items that will be created. Must be at least 1}

Keyword Property EncTypeLegendary Auto Const Mandatory
{AUTOFILL}

FormList Property DisallowGeneratedItemsForActorKeywordList Auto Const Mandatory
{If any of the keywords in this form list are present on the actor, it will be excluded from generating items if it doesn't have eligible equipment}

Event OnEffectStart(Actor akTarget, Actor akCaster)
    CreateLegendaryItems(akTarget)
EndEvent

Function CreateLegendaryItems(Actor akTarget)
    Form[] eligibleWeapons = GetEligibleInventoryItems(akTarget, AllowedWeaponKeywords)
    Form[] eligibleArmor = GetEligibleInventoryItems(akTarget, AllowedArmorKeywords)
    ; This means we're probably dealing with a creature / robot
    bool hasEquipment = eligibleWeapons.Length > 0 || eligibleArmor.Length > 0
    int numLegendaries = GetNumberOfLegendariesToCreate(akTarget)
    int i = 0

    debug.trace(self + " is creating " + numLegendaries + " legendaries for " + akTarget + ". HasEquipment=" + hasEquipment)

    while i < numLegendaries
        if hasEquipment
            MakeEquippedItemLegendary(akTarget, eligibleWeapons, eligibleArmor)
        else
            GenerateLegendaryItem(akTarget)
        endIf

        i += 1
    endWhile
EndFunction

Function GenerateLegendaryItem(Actor akTarget)
    if GenerateNewItemIfNoneFound.GetValueInt() > 0 && !akTarget.HasKeywordInFormList(DisallowGeneratedItemsForActorKeywordList)
        if StrictlyEnforceWeaponChanceWhenEquipmentUnavailable.GetValueInt() > 0
            if Utility.RandomInt(1, 100) <= LegendaryWeaponChance.GetValueInt()
                debug.trace(self + " generating a legendary weapon")
                LegendaryItemQuest.GenerateLegendaryItem(akTarget, GeneratedWeapon)
            else
                debug.trace(self + " generating legendary armor")
                LegendaryItemQuest.GenerateLegendaryItem(akTarget, GeneratedArmor)
            endIf
        else
            debug.trace(self + " generating legendary item")
            LegendaryItemQuest.GenerateLegendaryItem(akTarget)
        endIf
    else
        debug.trace(self + " skipping legendary generation because it is disabled")
    endIf
EndFunction

Function MakeEquippedItemLegendary(Actor akTarget, Form[] aaEligibleWeapons, Form[] aaEligibleArmor)
    bool success = false
    
    if Utility.RandomInt(1, 100) <= LegendaryWeaponChance.GetValueInt()
        success = CreateLegendaryWeapon(akTarget, aaEligibleWeapons)
        
        if !success
            if StrictlyEnforceWeaponChanceWhenEquipmentAvailable.GetValueInt() > 0 && !akTarget.HasKeywordInFormList(DisallowGeneratedItemsForActorKeywordList)
                debug.trace(self + " generating a new legendary weapon because converting an equipped weapon failed")
                LegendaryItemQuest.GenerateLegendaryItem(akTarget, GeneratedWeapon)
                success = true
            else
                debug.trace(self + " falling back to legendary armor because converting an equipped weapon failed")
                success = CreateLegendaryArmor(akTarget, aaEligibleArmor)
            EndIf
        EndIf
    else
        success = CreateLegendaryArmor(akTarget, aaEligibleArmor)
        
        if !success
            if StrictlyEnforceWeaponChanceWhenEquipmentAvailable.GetValueInt() > 0 && !akTarget.HasKeywordInFormList(DisallowGeneratedItemsForActorKeywordList)
                debug.trace(self + " generating new legendary armor because converting equipped armor failed")
                LegendaryItemQuest.GenerateLegendaryItem(akTarget, GeneratedArmor)
                success = true
            else
                debug.trace(self + " falling back to a legendary weapon because converting equipped armor failed")
                success = CreateLegendaryWeapon(akTarget, aaEligibleWeapons)
            EndIf
        EndIf
    endIf
    
    if !success && GenerateNewItemIfNoneFound.GetValueInt() > 0 && !akTarget.HasKeywordInFormList(DisallowGeneratedItemsForActorKeywordList)
        debug.trace(self + " generating legendary item because converting an equipped one failed")
        LegendaryItemQuest.GenerateLegendaryItem(akTarget)
    EndIf
EndFunction

bool Function CreateLegendaryWeapon(Actor akTarget, Form[] aaEligibleWeapons)
    debug.trace(self + " is going to make a legendary weapon")
    
    if Utility.RandomInt(1, 100) <= GeneratedWeaponChance.GetValueInt() && !akTarget.HasKeywordInFormList(DisallowGeneratedItemsForActorKeywordList)
        debug.trace(self + " generating a new legendary weapon")
        LegendaryItemQuest.GenerateLegendaryItem(akTarget, GeneratedWeapon)
        return true
    else
        return AddLegendaryModToEquippedItem(akTarget, aaEligibleWeapons)
    EndIf
EndFunction

bool Function CreateLegendaryArmor(Actor akTarget, Form[] aaEligibleArmor)
    debug.trace(self + " is going to make legendary armor")

    if Utility.RandomInt(1, 100) <= GeneratedArmorChance.GetValueInt() && !akTarget.HasKeywordInFormList(DisallowGeneratedItemsForActorKeywordList)
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

        ; Attaching a mod to an item can cause it to be unequipped in odd ways, so check if we should be re-equipping it afterwards
        bool isEquipped = akTarget.IsEquipped(itemToMod)
        if WornLegendaryItemQuest.AddLegendaryMod(akTarget, itemToMod)
            if isEquipped
                akTarget.EquipItem(itemToMod)
            endIf
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

        if (item.HasKeywordInFormList(akAllowedKeywords) && !item.HasKeywordInFormList(ExcludeKeywordsList)) || item.HasKeywordInFormList(AlwaysAllowedKeywordsList)
            eligibleEquipment.Add(item)
        endif

        i += 1
    endwhile

    return eligibleEquipment
EndFunction