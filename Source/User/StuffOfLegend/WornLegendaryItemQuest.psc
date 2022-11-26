Scriptname StuffOfLegend:WornLegendaryItemQuest extends Quest

LegendaryItemQuestScript Property LegendaryItemQuest Auto Const Mandatory

FormList Property LegendaryModRule_AllowedKeywords_ObjectTypeArmor Const Auto Mandatory
{AUTOFILL}
FormList Property WLI_FormList_AlwaysAllowedKeywords Const Auto Mandatory
{AUTOFILL}
FormList Property WLI_FormList_IneligibleKeywords Const Auto Mandatory
{AUTOFILL}
FormList Property SOL_FormList_ActorKeywords_DropType_Organ_Animal Const Auto Mandatory
{AUTOFILL}

Struct LegendaryDropMapping
	FormList ActorKeywords
	{Keywords to look for on the actor receiving a legendary drop}
	LeveledItem DroppedItem
	{The list of items to choose from if the actor has an above keyword}
	bool AttachLegendaryMod = false
	{Whether or not to attach a legendary mod to the dropped item}
EndStruct

LegendaryDropMapping[] Property LegendaryDropTypes Const Auto Mandatory
{If a legendary item is generated for an actor, these mappings will override the standard list of items to spawn}

GlobalVariable Property LegendaryWeaponChance Auto Const Mandatory
{The chance that the enemy's weapon will be selected as the legendary item instead of their armor}

LeveledItem Property GeneratedWeapon Auto Const Mandatory
{The weapon list to use to generate weapons if the chance is rolled}

LeveledItem Property GeneratedArmor Auto Const Mandatory
{The armor list to use to generate armors if the chance is rolled}

GlobalVariable Property GeneratedWeaponChance Auto Const Mandatory
{The chance that the enemy will get a new legendary weapon instead of changing their own}

GlobalVariable Property GeneratedArmorChance Auto Const Mandatory
{The chance that the enemy will get a new legendary armor instead of changing their own}

GlobalVariable Property GenerateNewItemIfNoneFound Auto Const Mandatory
{This boolean global determines if a brand new item should be created from the standard legendary drop lists if there are no items in the reference's inventory that can be made legendary}

GlobalVariable Property StrictlyEnforceWeaponChanceWhenEquipmentAvailable Auto Const Mandatory
{This boolean global variable indicates if a weapon should be generated if the weapon chance selected a weapon, even if armor is available}

GlobalVariable Property MaxItemsMade_Legendary Auto Const Mandatory
{The upper bound for the number of legendary items that will be created. Must be at least 1}

GlobalVariable Property MaxItemsMade_Normal Auto Const Mandatory
{The upper bound for the number of legendary items that will be created. Must be at least 1}

Keyword Property EncTypeLegendary Auto Const Mandatory
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

bool Property PowerArmorEnabled = false Auto
Keyword Property PowerArmorKeyword Const Auto Mandatory

; This is specifically inverted for MCM, since there is something we want to display only when Power Armor to the People is not detected
bool Property PAttPNotDetected = true Auto

; Used to help spread out the legendary effects that are used
ObjectMod[] PreviouslySpawnedMods

Event OnInit()
    PreviouslySpawnedMods = new ObjectMod[0]
    DetectExistingKeywords()
    DetectOtherMods()
EndEvent

Function DetectExistingKeywords()
    DogArmorEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(DogArmorKeyword) >= 0
    HeadgearEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(HeadgearKeyword) >= 0
    ClothingEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(ClothingKeyword) >= 0
    HatEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(HatKeyword) >= 0
    EyewearEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(EyewearKeyword) >= 0
    PowerArmorEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(PowerArmorKeyword) >= 0
EndFunction

Function RefreshAllowedKeywords()
    DetectOtherMods()
    
    UpdateFormList(DogArmorEnabled, LegendaryModRule_AllowedKeywords_ObjectTypeArmor, DogArmorKeyword)
    UpdateFormList(HeadgearEnabled, LegendaryModRule_AllowedKeywords_ObjectTypeArmor, HeadgearKeyword)
    UpdateFormList(ClothingEnabled, LegendaryModRule_AllowedKeywords_ObjectTypeArmor, ClothingKeyword)
    UpdateFormList(HatEnabled, LegendaryModRule_AllowedKeywords_ObjectTypeArmor, HatKeyword)
    UpdateFormList(EyewearEnabled, LegendaryModRule_AllowedKeywords_ObjectTypeArmor, EyewearKeyword)
    
    ; We don't want to manage power armor if Power Armor to the People is present, because there is an option to remove base game armor effects
    if PAttPNotDetected
        UpdateFormList(PowerArmorEnabled, LegendaryModRule_AllowedKeywords_ObjectTypeArmor, PowerArmorKeyword)
    endIf
EndFunction

Function DetectOtherMods()
    ; Keyword on Tesla Cannon - ccBGSFO4046_dn_TesCan
    Keyword teslaCannonKeyword = Game.GetFormFromFile(0x00000021, "ccbgsfo4046-tescan.esl") as Keyword
	
    if teslaCannonKeyword
        debug.trace(self + " detected Tesla Cannon, adding keyword " + teslaCannonKeyword + " to allowed list")
        UpdateFormList(true, WLI_FormList_AlwaysAllowedKeywords, teslaCannonKeyword)
    endIf
	
    ; Arbitrary form that has existed since the first Power Armor to the People.esp
    PAttPNotDetected = (Game.GetFormFromFile(0x00000800, "Power Armor to the People.esp") == None)
    debug.trace(self + " Power Armor to the People detected: " + !PAttPNotDetected)
	
	; Keyword on Institute Power Armor - zzzM150IPAdn_PowerArmor_I01
	Keyword institutePowerArmorKeyword = Game.GetFormFromFile(0x00000FA0, "InstitutePowerArmor.esp") as Keyword
	
    if institutePowerArmorKeyword
        debug.trace(self + " detected Institute Power Armor, adding keyword " + institutePowerArmorKeyword + " to exclusion list")
        UpdateFormList(true, WLI_FormList_IneligibleKeywords, institutePowerArmorKeyword)
    endIf
	
	; Far Harbor
	Keyword ActorTypeAngler = Game.GetFormFromFile(0x00009589, "DLCCoast.esm") as Keyword
	Keyword ActorTypeFogCrawler = Game.GetFormFromFile(0x00018622, "DLCCoast.esm") as Keyword
	Keyword ActorTypeGulper = Game.GetFormFromFile(0x000270C0, "DLCCoast.esm") as Keyword
	
	if ActorTypeAngler || ActorTypeFogCrawler || ActorTypeGulper
		debug.trace(self + " detected Far Harbor, adding actor types to formlists")
		UpdateFormList(true, SOL_FormList_ActorKeywords_DropType_Organ_Animal, ActorTypeAngler)
		UpdateFormList(true, SOL_FormList_ActorKeywords_DropType_Organ_Animal, ActorTypeFogCrawler)
		UpdateFormList(true, SOL_FormList_ActorKeywords_DropType_Organ_Animal, ActorTypeGulper)
	endIf
		
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

Function CreateLegendaryItems(Actor akTarget, Form[] aaEligibleWeapons, Form[] aaEligibleArmor)
    bool hasEquipment = aaEligibleWeapons.Length > 0 || aaEligibleArmor.Length > 0
    int numLegendaries = GetNumberOfLegendariesToCreate(akTarget)
    int i = 0

    debug.trace(self + " is creating " + numLegendaries + " legendaries for " + akTarget + ". HasEquipment=" + hasEquipment)

    while i < numLegendaries
        if hasEquipment
            MakeEquippedItemLegendary(akTarget, aaEligibleWeapons, aaEligibleArmor)
        else
            GenerateLegendaryItem(akTarget)
        endIf

        i += 1
    endWhile
EndFunction

Function MakeEquippedItemLegendary(Actor akTarget, Form[] aaEligibleWeapons, Form[] aaEligibleArmor)
    bool success = false
    
    if Utility.RandomInt(1, 100) <= LegendaryWeaponChance.GetValueInt()
        success = CreateLegendaryWeapon(akTarget, aaEligibleWeapons)
        
        if !success
            if StrictlyEnforceWeaponChanceWhenEquipmentAvailable.GetValueInt() > 0
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
            if StrictlyEnforceWeaponChanceWhenEquipmentAvailable.GetValueInt() > 0
                debug.trace(self + " generating new legendary armor because converting equipped armor failed")
                LegendaryItemQuest.GenerateLegendaryItem(akTarget, GeneratedArmor)
                success = true
            else
                debug.trace(self + " falling back to a legendary weapon because converting equipped armor failed")
                success = CreateLegendaryWeapon(akTarget, aaEligibleWeapons)
            EndIf
        EndIf
    endIf
    
    if !success
        debug.trace(self + " falling back to generating a legendary item because no equipped items could be converted")
        GenerateLegendaryItem(akTarget)
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

        ; Attaching a mod to an item can cause it to be unequipped in odd ways, so check if we should be re-equipping it afterwards
        bool isEquipped = akTarget.IsEquipped(itemToMod)
        if AddLegendaryMod(akTarget, itemToMod)
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

; Leveled list will be overridden if the ObjectToSpawnIn has any of the keywords from LegendaryDropTypes
ObjectReference Function GenerateLegendaryItem(ObjectReference ObjectToSpawnIn)
	int i = 0
	while (i < LegendaryDropTypes.length)
		LegendaryDropMapping mapping = LegendaryDropTypes[i]
		if ObjectToSpawnIn.HasKeywordInFormList(mapping.ActorKeywords)
			if mapping.AttachLegendaryMod
				debug.trace(self + " found legendary mapping for " + ObjectToSpawnIn + " from " + mapping.ActorKeywords + " - attaching legendary mod")
				return LegendaryItemQuest.GenerateLegendaryItem(ObjectToSpawnIn, mapping.DroppedItem)
			else
				debug.trace(self + " found legendary mapping for " + ObjectToSpawnIn + " from " + mapping.ActorKeywords + " - adding item to inventory")
				ObjectToSpawnIn.AddItem(mapping.DroppedItem, 1, true)
				return None
			EndIf
		endIf
		i += 1
	EndWhile

	if GenerateNewItemIfNoneFound.GetValueInt() > 0
		debug.trace(self + " generating legendary item because enemy type is unrecognized")
		LegendaryItemQuest.GenerateLegendaryItem(ObjectToSpawnIn)
    else
        debug.trace(self + " skipping legendary generation for unrecognized enemy type because it is disabled")
    endIf

	return None
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