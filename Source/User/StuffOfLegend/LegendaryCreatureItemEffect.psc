Scriptname StuffOfLegend:LegendaryCreatureItemEffect extends activemagiceffect const
{Makes a worn item legendary (F4SE required). If no worn items have a legendary attach point, can optionally create a new legendary item to add to the target's inventory instead.}

StuffOfLegend:WornLegendaryItemQuest Property WornLegendaryItemQuest Auto Const Mandatory
{AUTOFILL}

FormList Property AllowedWeaponKeywords Auto Const Mandatory
{If an item has any of the keywords on this list, it will be considered to be a weapon that can have a legendary mod}

FormList Property AllowedArmorKeywords Auto Const Mandatory
{If an item has any of the keywords on this list, it will be considered to be armor that can have a legendary mod}

FormList Property ExcludeKeywordsList Auto Const Mandatory
{If any of the keywords in this form list are present on an item, it will be excluded from the eligible equipment for a legendary mod}

FormList Property AlwaysAllowedKeywordsList Auto Const Mandatory
{Any items with keywords on this list are always allowed, even if they have a keyword on the excluded list}

Event OnEffectStart(Actor akTarget, Actor akCaster)
    WornLegendaryItemQuest.CreateLegendaryItems(akTarget, GetEligibleInventoryItems(akTarget, AllowedWeaponKeywords), GetEligibleInventoryItems(akTarget, AllowedArmorKeywords))
EndEvent

Form[] Function GetEligibleInventoryItems(Actor akActor, FormList akAllowedKeywords)
    ; Requires F4SE
    Form[] inventory = akActor.GetInventoryItems()

    Form[] eligibleEquipment = new Form[0]
    int i = 0
    while(i < inventory.length)
        Form  item = inventory[i]

        if item.HasKeywordInFormList(akAllowedKeywords) && (!item.HasKeywordInFormList(ExcludeKeywordsList) || item.HasKeywordInFormList(AlwaysAllowedKeywordsList))
            eligibleEquipment.Add(item)
        endif

        i += 1
    endwhile

    return eligibleEquipment
EndFunction