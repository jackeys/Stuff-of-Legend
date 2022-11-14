Scriptname StuffOfLegend:WornLegendaryItemQuest extends Quest

LegendaryItemQuestScript Property LegendaryItemQuest Auto Const Mandatory

FormList Property LegendaryModRule_AllowedKeywords_ObjectTypeArmor Const Auto Mandatory
{AUTOFILL}
FormList Property WLI_FormList_AlwaysAllowedKeywords Const Auto Mandatory
{AUTOFILL}
FormList Property WLI_FormList_IneligibleKeywords Const Auto Mandatory
{AUTOFILL}
FormList Property WLI_FormList_DisallowGeneratedItemsForActorKeywords Const Auto Mandatory
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

; Creature types to allow legendary drops for

bool Property LegendaryAnimalDropsEnabled = true Auto
Keyword Property AnimalActorKeyword Const Auto Mandatory

bool Property LegendaryBugDropsEnabled = true Auto
Keyword Property BugActorKeyword Const Auto Mandatory

bool Property LegendaryDeathclawDropsEnabled = true Auto
Keyword Property DeathclawActorKeyword Const Auto Mandatory

bool Property LegendaryFeralGhoulDropsEnabled = true Auto
Keyword Property FeralGhoulActorKeyword Const Auto Mandatory

bool Property LegendaryMirelurkDropsEnabled = true Auto
Keyword Property MirelurkActorKeyword Const Auto Mandatory

bool Property LegendaryMirelurkKingDropsEnabled = true Auto
Keyword Property MirelurkKingActorKeyword Const Auto Mandatory

bool Property LegendaryMirelurkQueenDropsEnabled = true Auto
Keyword Property MirelurkQueenActorKeyword Const Auto Mandatory

bool Property LegendaryRadScorpionDropsEnabled = true Auto
Keyword Property RadScorpionActorKeyword Const Auto Mandatory

bool Property LegendaryRobotDropsEnabled = true Auto
Keyword Property RobotActorKeyword Const Auto Mandatory

bool Property LegendaryFarHarborAnglerDropsEnabled = true Auto
bool Property LegendaryFarHarborFogCrawlerDropsEnabled = true Auto
bool Property LegendaryFarHarborGulperDropsEnabled = true Auto

; Used to help spread out the legendary effects that are used
ObjectMod[] PreviouslySpawnedMods

Event OnInit()
    PreviouslySpawnedMods = new ObjectMod[0]
    DetectExistingKeywords()
    DetectOtherMods()
EndEvent

Function DetectExistingKeywords()
    DogArmorEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(DogArmorKeyword) > 0
    HeadgearEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(HeadgearKeyword) > 0
    ClothingEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(ClothingKeyword) > 0
    HatEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(HatKeyword) > 0
    EyewearEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(EyewearKeyword) > 0
    PowerArmorEnabled = LegendaryModRule_AllowedKeywords_ObjectTypeArmor.Find(PowerArmorKeyword) > 0
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

    UpdateDisallowedActorFormList(LegendaryAnimalDropsEnabled, AnimalActorKeyword)
    UpdateDisallowedActorFormList(LegendaryBugDropsEnabled, BugActorKeyword)
    UpdateDisallowedActorFormList(LegendaryDeathclawDropsEnabled, DeathclawActorKeyword)
    UpdateDisallowedActorFormList(LegendaryFeralGhoulDropsEnabled, FeralGhoulActorKeyword)
    UpdateDisallowedActorFormList(LegendaryMirelurkDropsEnabled, MirelurkActorKeyword)
    UpdateDisallowedActorFormList(LegendaryMirelurkKingDropsEnabled, MirelurkKingActorKeyword)
    UpdateDisallowedActorFormList(LegendaryMirelurkQueenDropsEnabled, MirelurkQueenActorKeyword)
    UpdateDisallowedActorFormList(LegendaryRadScorpionDropsEnabled, RadScorpionActorKeyword)
    UpdateDisallowedActorFormList(LegendaryRobotDropsEnabled, RobotActorKeyword)
EndFunction

Function UpdateDisallowedActorFormList(bool abEnabled, Keyword akKeyword)
	; Invert whether it's enabled, since we want to inject the form if an actor is not allowed
	UpdateFormList(!abEnabled, WLI_FormList_DisallowGeneratedItemsForActorKeywords, akKeyword)
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
		debug.trace(self + " detected Far Harbor, checking if any actor types should be disallowed from generating legendary items")
		UpdateDisallowedActorFormList(LegendaryFarHarborAnglerDropsEnabled, ActorTypeAngler)
		UpdateDisallowedActorFormList(LegendaryFarHarborFogCrawlerDropsEnabled, ActorTypeFogCrawler)
		UpdateDisallowedActorFormList(LegendaryFarHarborGulperDropsEnabled, ActorTypeGulper)
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