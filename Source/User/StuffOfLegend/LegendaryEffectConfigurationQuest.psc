Scriptname StuffOfLegend:LegendaryEffectConfigurationQuest extends Quest
{Manages which custom legendary effects are present in the pool of possible legendaries that the main game has}

Struct ExternalLegendaryModRule
    FormList AllowedKeywords
    FormList DisallowedKeywords
    int LegendaryObjectModFormID
EndStruct

LegendaryItemQuestScript Property LegendaryItemQuest const auto mandatory
{Autofill}

StuffOfLegend:LegendaryCreatureItemQuest Property LegendaryCreatureItemQuest Const Auto Mandatory

; Weapons
bool Property LuckyWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property LuckyWeaponModRule Const Auto Mandatory
MiscObject Property LuckyWeaponModItem Const Auto Mandatory

bool Property PowerfulWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property PowerfulWeaponModRule Const Auto Mandatory
MiscObject Property PowerfulWeaponModItem Const Auto Mandatory

bool Property IrradiatedWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property IrradiatedWeaponModRule Const Auto Mandatory
MiscObject Property IrradiatedWeaponModItem Const Auto Mandatory

bool Property TwoShotWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property TwoShotWeaponModRule Const Auto Mandatory
MiscObject Property TwoShotWeaponModItem Const Auto Mandatory

bool Property NeverendingWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property NeverendingWeaponModRule Const Auto Mandatory
MiscObject Property NeverendingWeaponModItem Const Auto Mandatory

bool Property VATSEnhancedGunEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property VATSEnhancedGunModRule Const Auto Mandatory
MiscObject Property VATSEnhancedGunModItem Const Auto Mandatory

bool Property VATSEnhancedMeleeEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property VATSEnhancedMeleeModRule Const Auto Mandatory
MiscObject Property VATSEnhancedMeleeModItem Const Auto Mandatory

bool Property HuntersWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property HuntersWeaponModRule Const Auto Mandatory
MiscObject Property HuntersWeaponModItem Const Auto Mandatory

bool Property ExterminatorsWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property ExterminatorsWeaponModRule Const Auto Mandatory
MiscObject Property ExterminatorsWeaponModItem Const Auto Mandatory

bool Property GhoulSlayersWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property GhoulSlayersWeaponModRule Const Auto Mandatory
MiscObject Property GhoulSlayersWeaponModItem Const Auto Mandatory

bool Property AssassinsWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property AssassinsWeaponModRule Const Auto Mandatory
MiscObject Property AssassinsWeaponModItem Const Auto Mandatory

bool Property TroubleshootersWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property TroubleshootersWeaponModRule Const Auto Mandatory
MiscObject Property TroubleshootersWeaponModItem Const Auto Mandatory

bool Property MutantSlayersWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property MutantSlayersWeaponModRule Const Auto Mandatory
MiscObject Property MutantSlayersWeaponModItem Const Auto Mandatory

bool Property CripplingWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property CripplingWeaponModRule Const Auto Mandatory
MiscObject Property CripplingWeaponModItem Const Auto Mandatory

bool Property IncendiaryBulletsEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property IncendiaryBulletsModRule Const Auto Mandatory
MiscObject Property IncendiaryBulletsModItem Const Auto Mandatory

bool Property ExplosiveBulletsEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property ExplosiveBulletsModRule Const Auto Mandatory
MiscObject Property ExplosiveBulletsModItem Const Auto Mandatory

bool Property WoundingWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property WoundingWeaponModRule Const Auto Mandatory
MiscObject Property WoundingWeaponModItem Const Auto Mandatory

bool Property NocturnalWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property NocturnalWeaponModRule Const Auto Mandatory
MiscObject Property NocturnalWeaponModItem Const Auto Mandatory

bool Property StaggeringWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property StaggeringWeaponModRule Const Auto Mandatory
MiscObject Property StaggeringWeaponModItem Const Auto Mandatory

bool Property NimbleGunEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property NimbleGunModRule Const Auto Mandatory
MiscObject Property NimbleGunModItem Const Auto Mandatory

bool Property BloodiedMeleeEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property BloodiedMeleeModRule Const Auto Mandatory
MiscObject Property BloodiedMeleeModItem Const Auto Mandatory

bool Property RapidGunEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property RapidGunModRule Const Auto Mandatory
MiscObject Property RapidGunModItem Const Auto Mandatory

bool Property RelentlessWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property RelentlessWeaponModRule Const Auto Mandatory
MiscObject Property RelentlessWeaponModItem Const Auto Mandatory

bool Property FuriousMeleeEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property FuriousMeleeModRule Const Auto Mandatory
MiscObject Property FuriousMeleeModItem Const Auto Mandatory

bool Property BerserkersMeleeEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property BerserkersMeleeModRule Const Auto Mandatory
MiscObject Property BerserkersMeleeModItem Const Auto Mandatory

bool Property InstigatingWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property InstigatingWeaponModRule Const Auto Mandatory
MiscObject Property InstigatingWeaponModItem Const Auto Mandatory

bool Property StalkersGunEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property StalkersGunModRule Const Auto Mandatory
MiscObject Property StalkersGunModItem Const Auto Mandatory

bool Property QuickdrawWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property QuickdrawWeaponModRule Const Auto Mandatory
MiscObject Property QuickdrawWeaponModItem Const Auto Mandatory

bool Property KneecapperWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property KneecapperWeaponModRule Const Auto Mandatory
MiscObject Property KneecapperWeaponModItem Const Auto Mandatory

bool Property PoisonersWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property PoisonersWeaponModRule Const Auto Mandatory
MiscObject Property PoisonersWeaponModItem Const Auto Mandatory

bool Property PenetratingWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property PenetratingWeaponModRule Const Auto Mandatory
MiscObject Property PenetratingWeaponModItem Const Auto Mandatory

bool Property FreezingWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property FreezingWeaponModRule Const Auto Mandatory
MiscObject Property FreezingWeaponModItem Const Auto Mandatory

bool Property CavaliersWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property CavaliersWeaponModRule Const Auto Mandatory
MiscObject Property CavaliersWeaponModItem Const Auto Mandatory

bool Property SentinelsWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property SentinelsWeaponModRule Const Auto Mandatory
MiscObject Property SentinelsWeaponModItem Const Auto Mandatory

bool Property ViolentBulletsEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property ViolentBulletsModRule Const Auto Mandatory
MiscObject Property ViolentBulletsModItem Const Auto Mandatory

bool Property EnragingWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property EnragingWeaponModRule Const Auto Mandatory
MiscObject Property EnragingWeaponModItem Const Auto Mandatory

bool Property PlasmaBulletsEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property PlasmaBulletsModRule Const Auto Mandatory
MiscObject Property PlasmaBulletsModItem Const Auto Mandatory

bool Property AutomaticLaserMusketEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property AutomaticLaserMusketModRule Const Auto Mandatory

bool Property JunkiesWeaponEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property JunkiesWeaponModRule Const Auto Mandatory
MiscObject Property JunkiesWeaponModItem Const Auto Mandatory

; Armor

bool Property CunningArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property CunningArmorModRule Const Auto Mandatory
MiscObject Property CunningArmorModItem Const Auto Mandatory

bool Property SharpArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property SharpArmorModRule Const Auto Mandatory
MiscObject Property SharpArmorModItem Const Auto Mandatory

bool Property LuckyArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property LuckyArmorModRule Const Auto Mandatory
MiscObject Property LuckyArmorModItem Const Auto Mandatory

bool Property FortifyingArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property FortifyingArmorModRule Const Auto Mandatory
MiscObject Property FortifyingArmorModItem Const Auto Mandatory

bool Property SprintersArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property SprintersArmorModRule Const Auto Mandatory
MiscObject Property SprintersArmorModItem Const Auto Mandatory

bool Property VATSEnhancedArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property VATSEnhancedArmorModRule Const Auto Mandatory
MiscObject Property VATSEnhancedArmorModItem Const Auto Mandatory

bool Property HuntersArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property HuntersArmorModRule Const Auto Mandatory
MiscObject Property HuntersArmorModItem Const Auto Mandatory

bool Property ExterminatorsArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property ExterminatorsArmorModRule Const Auto Mandatory
MiscObject Property ExterminatorsArmorModItem Const Auto Mandatory

bool Property GhoulSlayersArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property GhoulSlayersArmorModRule Const Auto Mandatory
MiscObject Property GhoulSlayersArmorModItem Const Auto Mandatory

bool Property AssassinsArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property AssassinsArmorModRule Const Auto Mandatory
MiscObject Property AssassinsArmorModItem Const Auto Mandatory

bool Property TroubleshootersArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property TroubleshootersArmorModRule Const Auto Mandatory
MiscObject Property TroubleshootersArmorModItem Const Auto Mandatory

bool Property MutantSlayersArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property MutantSlayersArmorModRule Const Auto Mandatory
MiscObject Property MutantSlayersArmorModItem Const Auto Mandatory

bool Property AcrobatsArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property AcrobatsArmorModRule Const Auto Mandatory
MiscObject Property AcrobatsArmorModItem Const Auto Mandatory

bool Property PunishingArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property PunishingArmorModRule Const Auto Mandatory
MiscObject Property PunishingArmorModItem Const Auto Mandatory

bool Property MartyrsArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property MartyrsArmorModRule Const Auto Mandatory
MiscObject Property MartyrsArmorModItem Const Auto Mandatory

bool Property PoisonersArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property PoisonersArmorModRule Const Auto Mandatory
MiscObject Property PoisonersArmorModItem Const Auto Mandatory

bool Property DuelistsArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property DuelistsArmorModRule Const Auto Mandatory
MiscObject Property DuelistsArmorModItem Const Auto Mandatory

bool Property SafecrackersArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property SafecrackersArmorModRule Const Auto Mandatory
MiscObject Property SafecrackersArmorModItem Const Auto Mandatory

bool Property ChameleonArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property ChameleonArmorModRule Const Auto Mandatory
MiscObject Property ChameleonArmorModItem Const Auto Mandatory

bool Property CavaliersArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property CavaliersArmorModRule Const Auto Mandatory
MiscObject Property CavaliersArmorModItem Const Auto Mandatory

bool Property SentinelsArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property SentinelsArmorModRule Const Auto Mandatory
MiscObject Property SentinelsArmorModItem Const Auto Mandatory

bool Property PoweredArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property PoweredArmorModRule Const Auto Mandatory
MiscObject Property PoweredArmorModItem Const Auto Mandatory

bool Property BolsteringArmorEnabled = true Auto
LegendaryItemQuestScript:LegendaryModRule Property BolsteringArmorModRule Const Auto Mandatory
MiscObject Property BolsteringArmorModItem Const Auto Mandatory

; Far Harbor

bool Property FHHitmansGunEnabled = true Auto
ExternalLegendaryModRule Property FHHitmansGunModRule Const Auto Mandatory
MiscObject Property FHHitmansGunModItem Const Auto

bool Property FHSteadfastGunEnabled = true Auto
ExternalLegendaryModRule Property FHSteadfastGunModRule Const Auto Mandatory
MiscObject Property FHSteadfastGunModItem Const Auto

bool Property FHResilientGunEnabled = true Auto
ExternalLegendaryModRule Property FHResilientGunModRule Const Auto Mandatory
MiscObject Property FHResilientGunModItem Const Auto

bool Property FHDeadeyeGunEnabled = true Auto
ExternalLegendaryModRule Property FHDeadeyeGunModRule Const Auto Mandatory
MiscObject Property FHDeadeyeGunModItem Const Auto

bool Property FHResoluteGunEnabled = true Auto
ExternalLegendaryModRule Property FHResoluteGunModRule Const Auto Mandatory
MiscObject Property FHResoluteGunModItem Const Auto

bool Property FHDefiantGunEnabled = true Auto
ExternalLegendaryModRule Property FHDefiantGunModRule Const Auto Mandatory
MiscObject Property FHDefiantGunModItem Const Auto

bool Property FHFrigidMeleeEnabled = true Auto
ExternalLegendaryModRule Property FHFrigidMeleeModRule Const Auto Mandatory
MiscObject Property FHFrigidMeleeModItem Const Auto

bool Property FHBlazingMeleeEnabled = true Auto
ExternalLegendaryModRule Property FHBlazingMeleeModRule Const Auto Mandatory
MiscObject Property FHBlazingMeleeModItem Const Auto

bool Property FHChargedMeleeEnabled = true Auto
ExternalLegendaryModRule Property FHChargedMeleeModRule Const Auto Mandatory
MiscObject Property FHChargedMeleeModItem Const Auto

bool Property FHDuelistsMeleeEnabled = true Auto
ExternalLegendaryModRule Property FHDuelistsMeleeModRule Const Auto Mandatory
MiscObject Property FHDuelistsMeleeModItem Const Auto

bool Property FHIncendiaryArmorEnabled = true Auto
ExternalLegendaryModRule Property FHIncendiaryArmorModRule Const Auto Mandatory
MiscObject Property FHIncendiaryArmorModItem Const Auto

bool Property FHCryogenicArmorEnabled = true Auto
ExternalLegendaryModRule Property FHCryogenicArmorModRule Const Auto Mandatory
MiscObject Property FHCryogenicArmorModItem Const Auto

bool Property FHCloakingArmorEnabled = true Auto
ExternalLegendaryModRule Property FHCloakingArmorModRule Const Auto Mandatory
MiscObject Property FHCloakingArmorModItem Const Auto

bool Property FHUnyieldingArmorEnabled = true Auto
ExternalLegendaryModRule Property FHUnyieldingArmorModRule Const Auto Mandatory
MiscObject Property FHUnyieldingArmorModItem Const Auto

bool Property FHAutoStimArmorEnabled = true Auto
ExternalLegendaryModRule Property FHAutoStimArmorModRule Const Auto Mandatory
MiscObject Property FHAutoStimArmorModItem Const Auto

bool Property FHRadPoweredArmorEnabled = true Auto
ExternalLegendaryModRule Property FHRadPoweredArmorModRule Const Auto Mandatory
MiscObject Property FHRadPoweredArmorModItem Const Auto

bool Property HasRunBefore = true auto
{Whether the rules updates have been run before. Start at true because the first release didn't have this, so we'll set it to false when we init the quest.}

Event OnInit()
	HasRunBefore = false
EndEvent

Event OnQuestInit()
    UpdateLegendaryModRules()
	HasRunBefore = true
EndEvent

Function UpdateLegendaryModRules()
    ; Armor
	UpdateArmorModEnabled("Cunning (Armor)", CunningArmorEnabled, CunningArmorModRule, CunningArmorModItem)
	UpdateArmorModEnabled("Sharp (Armor)", SharpArmorEnabled, SharpArmorModRule, SharpArmorModItem)
	UpdateArmorModEnabled("Lucky (Armor)", LuckyArmorEnabled, LuckyArmorModRule, LuckyArmorModItem)
	UpdateArmorModEnabled("Fortifying (Armor)", FortifyingArmorEnabled, FortifyingArmorModRule, FortifyingArmorModItem)
	UpdateArmorModEnabled("Punishing (Armor)", PunishingArmorEnabled, PunishingArmorModRule, PunishingArmorModItem)
	UpdateArmorModEnabled("Chameleon (Armor)", ChameleonArmorEnabled, ChameleonArmorModRule, ChameleonArmorModItem)
	UpdateArmorModEnabled("Powered (Armor)", PoweredArmorEnabled, PoweredArmorModRule, PoweredArmorModItem)
	UpdateArmorModEnabled("Bolstering (Armor)", BolsteringArmorEnabled, BolsteringArmorModRule, BolsteringArmorModItem)
	UpdateArmorModEnabled("Sprinter's (Armor)", SprintersArmorEnabled, SprintersArmorModRule, SprintersArmorModItem)
	UpdateArmorModEnabled("Acrobat's (Armor)", AcrobatsArmorEnabled, AcrobatsArmorModRule, AcrobatsArmorModItem)
	UpdateArmorModEnabled("VATS Enhanced (Armor)", VATSEnhancedArmorEnabled, VATSEnhancedArmorModRule, VATSEnhancedArmorModItem)
	UpdateArmorModEnabled("Hunter's (Armor)", HuntersArmorEnabled, HuntersArmorModRule, HuntersArmorModItem)
	UpdateArmorModEnabled("Exterminator's (Armor)", ExterminatorsArmorEnabled, ExterminatorsArmorModRule, ExterminatorsArmorModItem)
	UpdateArmorModEnabled("Assassin's (Armor)", AssassinsArmorEnabled, AssassinsArmorModRule, AssassinsArmorModItem)
	UpdateArmorModEnabled("Troubleshooter's (Armor)", TroubleshootersArmorEnabled, TroubleshootersArmorModRule, TroubleshootersArmorModItem)
	UpdateArmorModEnabled("Martyr's (Armor)", MartyrsArmorEnabled, MartyrsArmorModRule, MartyrsArmorModItem)
	UpdateArmorModEnabled("Poisoner's (Armor)", PoisonersArmorEnabled, PoisonersArmorModRule, PoisonersArmorModItem)
	UpdateArmorModEnabled("Duelist's (Armor)", DuelistsArmorEnabled, DuelistsArmorModRule, DuelistsArmorModItem)
	UpdateArmorModEnabled("Safecracker's (Armor)", SafecrackersArmorEnabled, SafecrackersArmorModRule, SafecrackersArmorModItem)
	UpdateArmorModEnabled("Cavalier's (Armor)", CavaliersArmorEnabled, CavaliersArmorModRule, CavaliersArmorModItem)
	UpdateArmorModEnabled("Sentinel's (Armor)", SentinelsArmorEnabled, SentinelsArmorModRule, SentinelsArmorModItem)
	UpdateArmorModEnabled("Ghoul Slayer's (Armor)", GhoulSlayersArmorEnabled, GhoulSlayersArmorModRule, GhoulSlayersArmorModItem)
	UpdateArmorModEnabled("Mutant Slayer's (Armor)", MutantSlayersArmorEnabled, MutantSlayersArmorModRule, MutantSlayersArmorModItem)

    ; Weapons
	UpdateWeaponModEnabled("Lucky (Weapon)", LuckyWeaponEnabled, LuckyWeaponModRule, LuckyWeaponModItem)
	UpdateWeaponModEnabled("Powerful (Weapon)", PowerfulWeaponEnabled, PowerfulWeaponModRule, PowerfulWeaponModItem)
	UpdateWeaponModEnabled("Irradiated (Weapon)", IrradiatedWeaponEnabled, IrradiatedWeaponModRule, IrradiatedWeaponModItem)
	UpdateWeaponModEnabled("Two Shot (Weapon)", TwoShotWeaponEnabled, TwoShotWeaponModRule, TwoShotWeaponModItem)
	UpdateWeaponModEnabled("Neverending (Weapon)", NeverendingWeaponEnabled, NeverendingWeaponModRule, NeverendingWeaponModItem)
	UpdateWeaponModEnabled("VATS Enhanced (Gun)", VATSEnhancedGunEnabled, VATSEnhancedGunModRule, VATSEnhancedGunModItem)
	UpdateWeaponModEnabled("VATS Enhanced (Melee)", VATSEnhancedMeleeEnabled, VATSEnhancedMeleeModRule, VATSEnhancedMeleeModItem)
	UpdateWeaponModEnabled("Hunter's (Weapon)", HuntersWeaponEnabled, HuntersWeaponModRule, HuntersWeaponModItem)
	UpdateWeaponModEnabled("Exterminator's (Weapon)", ExterminatorsWeaponEnabled, ExterminatorsWeaponModRule, ExterminatorsWeaponModItem)
	UpdateWeaponModEnabled("Ghoul Slayer's (Weapon)", GhoulSlayersWeaponEnabled, GhoulSlayersWeaponModRule, GhoulSlayersWeaponModItem)
	UpdateWeaponModEnabled("Assassin's (Weapon)", AssassinsWeaponEnabled, AssassinsWeaponModRule, AssassinsWeaponModItem)
	UpdateWeaponModEnabled("Troubleshooter's (Weapon)", TroubleshootersWeaponEnabled, TroubleshootersWeaponModRule, TroubleshootersWeaponModItem)
	UpdateWeaponModEnabled("Mutant Slayer's (Weapon)", MutantSlayersWeaponEnabled, MutantSlayersWeaponModRule, MutantSlayersWeaponModItem)
	UpdateWeaponModEnabled("Crippling (Weapon)", CripplingWeaponEnabled, CripplingWeaponModRule, CripplingWeaponModItem)
	UpdateWeaponModEnabled("Incendiary (Ballistic Weapon)", IncendiaryBulletsEnabled, IncendiaryBulletsModRule, IncendiaryBulletsModItem)
	UpdateWeaponModEnabled("Explosive (Ballistic Weapon)", ExplosiveBulletsEnabled, ExplosiveBulletsModRule, ExplosiveBulletsModItem)
	UpdateWeaponModEnabled("Violent (Ballistic Weapon)", ViolentBulletsEnabled, ViolentBulletsModRule, ViolentBulletsModItem)
	UpdateWeaponModEnabled("Plasma (Ballistic Weapon)", PlasmaBulletsEnabled, PlasmaBulletsModRule, PlasmaBulletsModItem)
	UpdateWeaponModEnabled("Wounding (Weapon)", WoundingWeaponEnabled, WoundingWeaponModRule, WoundingWeaponModItem)
	UpdateWeaponModEnabled("Nocturnal (Weapon)", NocturnalWeaponEnabled, NocturnalWeaponModRule, NocturnalWeaponModItem)
	UpdateWeaponModEnabled("Staggering (Weapon)", StaggeringWeaponEnabled, StaggeringWeaponModRule, StaggeringWeaponModItem)
	UpdateWeaponModEnabled("Nimble (Gun)", NimbleGunEnabled, NimbleGunModRule, NimbleGunModItem)
	UpdateWeaponModEnabled("Bloodied (Melee)", BloodiedMeleeEnabled, BloodiedMeleeModRule, BloodiedMeleeModItem)
	UpdateWeaponModEnabled("Furious (Melee)", FuriousMeleeEnabled, FuriousMeleeModRule, FuriousMeleeModItem)
	UpdateWeaponModEnabled("Berserker's (Melee)", BerserkersMeleeEnabled, BerserkersMeleeModRule, BerserkersMeleeModItem)
	UpdateWeaponModEnabled("Rapid (Gun)", RapidGunEnabled, RapidGunModRule, RapidGunModItem)
	UpdateWeaponModEnabled("Stalker's (Gun)", StalkersGunEnabled, StalkersGunModRule, StalkersGunModItem)
	UpdateWeaponModEnabled("Relentless (Weapon)", RelentlessWeaponEnabled, RelentlessWeaponModRule, RelentlessWeaponModItem)
	UpdateWeaponModEnabled("Instigating (Weapon)", InstigatingWeaponEnabled, InstigatingWeaponModRule, InstigatingWeaponModItem)
	UpdateWeaponModEnabled("Quickdraw (Weapon)", QuickdrawWeaponEnabled, QuickdrawWeaponModRule, QuickdrawWeaponModItem)
	UpdateWeaponModEnabled("Kneecapper (Weapon)", KneecapperWeaponEnabled, KneecapperWeaponModRule, KneecapperWeaponModItem)
	UpdateWeaponModEnabled("Poisoner's (Weapon)", PoisonersWeaponEnabled, PoisonersWeaponModRule, PoisonersWeaponModItem)
	UpdateWeaponModEnabled("Penetrating (Weapon)", PenetratingWeaponEnabled, PenetratingWeaponModRule, PenetratingWeaponModItem)
	UpdateWeaponModEnabled("Freezing (Weapon)", FreezingWeaponEnabled, FreezingWeaponModRule, FreezingWeaponModItem)
	UpdateWeaponModEnabled("Enraging (Weapon)", EnragingWeaponEnabled, EnragingWeaponModRule, EnragingWeaponModItem)
	UpdateWeaponModEnabled("Cavalier's (Weapon)", CavaliersWeaponEnabled, CavaliersWeaponModRule, CavaliersWeaponModItem)
	UpdateWeaponModEnabled("Sentinel's (Weapon)", SentinelsWeaponEnabled, SentinelsWeaponModRule, SentinelsWeaponModItem)
	UpdateWeaponModEnabled("Junkie's (Weapon)", JunkiesWeaponEnabled, JunkiesWeaponModRule, JunkiesWeaponModItem)
	UpdateWeaponModEnabled("Automatic Laser Musket", AutomaticLaserMusketEnabled, AutomaticLaserMusketModRule, None)

    ; Far Harbor
	UpdateFarHarborWeaponModEnabled("Hitman's (Gun) [Far Harbor]", FHHitmansGunEnabled, FHHitmansGunModRule, FHHitmansGunModItem)
	UpdateFarHarborWeaponModEnabled("Steadfast (Gun) [Far Harbor]", FHSteadfastGunEnabled, FHSteadfastGunModRule, FHSteadfastGunModItem)
	UpdateFarHarborWeaponModEnabled("Resilient (Gun) [Far Harbor]", FHResilientGunEnabled, FHResilientGunModRule, FHResilientGunModItem)
	UpdateFarHarborWeaponModEnabled("Deadeye (Gun) [Far Harbor]", FHDeadeyeGunEnabled, FHDeadeyeGunModRule, FHDeadeyeGunModItem)
	UpdateFarHarborWeaponModEnabled("Resolute (Gun) [Far Harbor]", FHResoluteGunEnabled, FHResoluteGunModRule, FHResoluteGunModItem)
	UpdateFarHarborWeaponModEnabled("Defiant (Gun) [Far Harbor]", FHDefiantGunEnabled, FHDefiantGunModRule, FHDefiantGunModItem)
	UpdateFarHarborWeaponModEnabled("Frigid (Melee) [Far Harbor]", FHFrigidMeleeEnabled, FHFrigidMeleeModRule, FHFrigidMeleeModItem)
	UpdateFarHarborWeaponModEnabled("Blazing (Melee) [Far Harbor]", FHBlazingMeleeEnabled, FHBlazingMeleeModRule, FHBlazingMeleeModItem)
	UpdateFarHarborWeaponModEnabled("Charged (Melee) [Far Harbor]", FHChargedMeleeEnabled, FHChargedMeleeModRule, FHChargedMeleeModItem)
	UpdateFarHarborWeaponModEnabled("Duelist's (Melee) [Far Harbor]", FHDuelistsMeleeEnabled, FHDuelistsMeleeModRule, FHDuelistsMeleeModItem)
	UpdateFarHarborArmorModEnabled("Incendiary (Armor) [Far Harbor]", FHIncendiaryArmorEnabled, FHIncendiaryArmorModRule, FHIncendiaryArmorModItem)
	UpdateFarHarborArmorModEnabled("Cryogenic (Armor) [Far Harbor]", FHCryogenicArmorEnabled, FHCryogenicArmorModRule, FHCryogenicArmorModItem)
	UpdateFarHarborArmorModEnabled("Cloaking (Armor) [Far Harbor]", FHCloakingArmorEnabled, FHCloakingArmorModRule, FHCloakingArmorModItem)
	UpdateFarHarborArmorModEnabled("Unyielding (Armor) [Far Harbor]", FHUnyieldingArmorEnabled, FHUnyieldingArmorModRule, FHUnyieldingArmorModItem)
	UpdateFarHarborArmorModEnabled("Auto Stim (Armor) [Far Harbor]", FHAutoStimArmorEnabled, FHAutoStimArmorModRule, FHAutoStimArmorModItem)
	UpdateFarHarborArmorModEnabled("Rad Powered (Armor) [Far Harbor]", FHRadPoweredArmorEnabled, FHRadPoweredArmorModRule, FHRadPoweredArmorModItem)
EndFunction

Function UpdateArmorModEnabled(string asName, bool abEnabled, LegendaryItemQuestScript:LegendaryModRule akRule, MiscObject akItem)
	UpdateModRule(asName, abEnabled, akRule)

	if akItem
		UpdateModItem(asName, abEnabled, akItem, LegendaryCreatureItemQuest.LegendaryArmorModDropList)
	EndIf
EndFunction

Function UpdateWeaponModEnabled(string asName, bool abEnabled, LegendaryItemQuestScript:LegendaryModRule akRule, MiscObject akItem)
	UpdateModRule(asName, abEnabled, akRule)

	if akItem
		UpdateModItem(asName, abEnabled, akItem, LegendaryCreatureItemQuest.LegendaryWeaponModDropList)
	EndIf
EndFunction

Function UpdateFarHarborArmorModEnabled(string asName, bool abEnabled, ExternalLegendaryModRule akRule, MiscObject akItem)
	if UpdateFarHarborModRule(asName, abEnabled, akRule) && akItem
		UpdateModItem(asName, abEnabled, akItem, LegendaryCreatureItemQuest.LegendaryArmorModDropList)
	EndIf
EndFunction

Function UpdateFarHarborWeaponModEnabled(string asName, bool abEnabled, ExternalLegendaryModRule akRule, MiscObject akItem)
	if UpdateFarHarborModRule(asName, abEnabled, akRule) && akItem
		UpdateModItem(asName, abEnabled, akItem, LegendaryCreatureItemQuest.LegendaryWeaponModDropList)
	EndIf
EndFunction

Function UpdateModItem(string asName, bool abEnabled, MiscObject akItem, Form[] aaItemList)
	int index = aaItemList.Find(akItem)
	if abEnabled
		if index >= 0
			debug.trace(self + " No action needed - found enabled item " + asName + " at index " + index + " of " + aaItemList)
		else
			debug.trace(self + " Adding enabled legendary " + asName + " | Item: " + akItem)
			aaItemList.add(akItem)
		endIf
	else
		if index < 0
			debug.trace(self + " No action needed - disabled item " + asName + " not found")
		else
			debug.trace(self + " Removing disabled legendary " + asName + " from index " + index + " | Item: " + akItem)
			aaItemList.remove(index)
		endIf
	EndIf
EndFunction

bool Function UpdateFarHarborModRule(string asName, bool abEnabled, ExternalLegendaryModRule akRule)
    ObjectMod legendaryMod = Game.GetFormFromFile(akRule.LegendaryObjectModFormID, "DLCCoast.esm") as ObjectMod

    if legendaryMod
        LegendaryItemQuestScript:LegendaryModRule legendaryRule = new LegendaryItemQuestScript:LegendaryModRule
        legendaryRule.AllowedKeywords = akRule.AllowedKeywords
        legendaryRule.DisallowedKeywords = akRule.DisallowedKeywords
        legendaryRule.LegendaryObjectMod = legendaryMod

        UpdateModRule(asName, abEnabled, legendaryRule)
		return true
    endIf

	return false
EndFunction

Function UpdateModRule(string asName, bool abEnabled, LegendaryItemQuestScript:LegendaryModRule akRule)
	int index = FindLegendaryRule(akRule)
	if abEnabled
		if index >= 0
			; Check to see if the mod rule is out of date
			if LegendaryItemQuest.LegendaryModRules[index].DisallowedKeywords == akRule.DisallowedKeywords && LegendaryItemQuest.LegendaryModRules[index].AllowGrenades == akRule.AllowGrenades
				debug.trace(self + " No action needed - found enabled rule " + asName + " at index " + index)
			else
				debug.trace(self + " Enabled rule " + asName + " at index " + index + " is out of date - updating")
				LegendaryItemQuest.LegendaryModRules[index] = akRule
			endif
		else
			debug.trace(self + " Adding enabled legendary " + asName + " | Rule: " + akRule)
			LegendaryItemQuest.LegendaryModRules.add(akRule)
		endIf
	else
		if index < 0
			debug.trace(self + " No action needed - disabled rule " + asName + " not found")
		else
			debug.trace(self + " Removing disabled rule " + asName + " from index " + index + " | Rule: " + akRule)
			LegendaryItemQuest.LegendaryModRules.remove(index)
		endIf
	EndIf
EndFunction

int Function FindLegendaryRule(LegendaryItemQuestScript:LegendaryModRule akRule)
	; Look for the rule using the object mod, then double-check the other fields to make sure it actually matches
	int index = LegendaryItemQuest.LegendaryModRules.RFindStruct("LegendaryObjectMod", akRule.LegendaryObjectMod)
	
	while index > -1 && LegendaryItemQuest.LegendaryModRules[index].AllowedKeywords != akRule.AllowedKeywords
		if index > 0
			index = LegendaryItemQuest.LegendaryModRules.RFindStruct("LegendaryObjectMod", akRule.LegendaryObjectMod, index - 1)
		else
			; We just checked the last element of the array - it's not here
			index = -1
		EndIf
	EndWhile

	return index
EndFunction