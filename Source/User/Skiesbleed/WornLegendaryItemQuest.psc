Scriptname Skiesbleed:WornLegendaryItemQuest extends Quest

LegendaryItemQuestScript Property LegendaryItemQuest Auto Const Mandatory

FormList Property LegendaryModRule_AllowedKeywords_ObjectTypeArmor Const Auto Mandatory
{AUTOFILL}

bool Property DogArmorEnabled = false Auto
Keyword Property DogArmorKeyword Const Auto Mandatory

bool Property HeadgearEnabled = false Auto
Keyword Property HeadgearKeyword Const Auto Mandatory

bool Property ClothingEnabled = false Auto
Keyword Property ClothingKeyword Const Auto Mandatory

bool Property HatEnabled = false Auto
Keyword Property HatKeyword Const Auto Mandatory

bool Property EyewearEnabled = false Auto
Keyword Property EyewearKeyword Const Auto Mandatory

; Used to help spread out the legendary effects that are used
ObjectMod[] PreviouslySpawnedMods

Event OnInit()
    PreviouslySpawnedMods = new ObjectMod[0]
    DetectExistingKeywords()
EndEvent

Function DetectExistingKeywords()
    DogArmorEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(DogArmorKeyword) > 0
    HeadgearEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(HeadgearKeyword) > 0
    ClothingEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(ClothingKeyword) > 0
    HatEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(HatKeyword) > 0
    EyewearEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(EyewearKeyword) > 0
EndFunction

Function RefreshAllowedKeywords()
    UpdateFormList(DogArmorEnabled, LegendaryModRule_AllowedKeywords_ObjectTypeArmor, DogArmorKeyword)
    UpdateFormList(HeadgearEnabled, LegendaryModRule_AllowedKeywords_ObjectTypeArmor, HeadgearKeyword)
    UpdateFormList(ClothingEnabled, LegendaryModRule_AllowedKeywords_ObjectTypeArmor, ClothingKeyword)
    UpdateFormList(HatEnabled, LegendaryModRule_AllowedKeywords_ObjectTypeArmor, HatKeyword)
    UpdateFormList(EyewearEnabled, LegendaryModRule_AllowedKeywords_ObjectTypeArmor, EyewearKeyword)
EndFunction

Function UpdateFormList(bool abEnabled, FormList akList, Form akKeyword)
	int index = akList.Find(akKeyword)
	if abEnabled
		if index >= 0
			debug.trace(self + " No action needed - found enabled keyword " + akKeyword + " in form list " + akList + " at index " + index)
		else
			debug.trace(self + " Adding enabled keyword " + akKeyword + " to form list " + akList)
			akList.AddForm(akKeyword)
		endIf
	else
		if index < 0
			debug.trace(self + " No action needed - disabled keyword " + akKeyword + " not found")
		else
			debug.trace(self + " Removing disabled keyword " + akKeyword + " from form list " + akList)
			akList.RemoveAddedForm(akKeyword)
		endIf
	EndIf
EndFunction

bool Function AddLegendaryMod(ObjectReference akRecipient, Form  item, FormList ListOfSpecificModsToChooseFrom = None, FormList ListOfSpecificModsToDisallow = None)
	debug.trace(akRecipient + "Attaching legendary mod to inventory item " + item)

	;GET THE MODS WE CAN INSTALL ON THIS ITEM
	ObjectMod[] AllowedMods = GetAllowedMods(item, ListOfSpecificModsToChooseFrom, ListOfSpecificModsToDisallow)

    ObjectMod[] PreferredMods = new ObjectMod[0]

	;FIND THE MODS WE HAVEN'T SPAWNED RECENTLY
	int i = 0
	while (i < AllowedMods.length)
		if  PreviouslySpawnedMods.Find(AllowedMods[i]) < 0  ;not found
			PreferredMods.add(AllowedMods[i])
		endif

		i += 1
	endwhile
	
	;if we don't have anything to pick from, reset and pick from any 
	if PreferredMods.length == 0 && AllowedMods.length > 0
		debug.trace(self + " Couldn't find any preferable mods, clearing the list")
		PreviouslySpawnedMods.clear()  ;*see note below
		PreferredMods = AllowedMods
	endif

    bool success = false

	;ROLL A DIE AND PICK A MOD
	int max = PreferredMods.Length
	if max > 0
		int dieRoll = Utility.RandomInt(0, max - 1)

		ObjectMod legendaryMod = PreferredMods[dieRoll]

		debug.trace(akRecipient + " Attaching " + legendaryMod + " to inventory item " + item)

		success = akRecipient.AttachModToInventoryItem(item, legendaryMod)

		if success
		    PreviouslySpawnedMods.Add(legendaryMod)
        else
			debug.trace(akRecipient + " Failed to attach " + legendaryMod + " to "+ item)
		endif
		
	else
		debug.trace(akRecipient + " AddLegendaryMod() could not find any appropriate Legendary Mods to add to item: " + item)
	endif

    return success
EndFunction

ObjectMod[] Function GetAllowedMods(Form item, FormList ListOfSpecificModsToChooseFrom = None, FormList ListOfSpecificModsToDisallow = None)	
	ObjectMod[] AllowedMods = New ObjectMod[0]
	
	int i = 0
	while (i < LegendaryItemQuest.LegendaryModRules.Length)
		LegendaryItemQuestScript:LegendaryModRule Rule = LegendaryItemQuest.LegendaryModRules[i]
		ObjectMod ModToConsider = Rule.LegendaryObjectMod
		
		bool continue = !item.HasKeywordInFormList(LegendaryItemQuest.WeaponTypeGrenadesKeywordList) || Rule.AllowGrenades
		continue = continue && (!ListOfSpecificModsToDisallow || (ListOfSpecificModsToDisallow.Find(ModToConsider) <= -1))
		continue = continue && (!ListOfSpecificModsToChooseFrom || (ListOfSpecificModsToChooseFrom.Find(ModToConsider) >= 0))
	
		if Rule.AllowedKeywords
			continue = continue && item.HasKeywordInFormList(Rule.AllowedKeywords)
		endif

		if Rule.DisallowedKeywords
			continue = continue && !item.HasKeywordInFormList(Rule.DisallowedKeywords)
		endif

		continue = continue && ModToConsider

		if (continue)
			AllowedMods.add(ModToConsider)
		endif

		i += 1
	endwhile

	return AllowedMods
EndFunction