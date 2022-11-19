Scriptname StuffOfLegend:UnmarkReconTarget extends ActiveMagicEffect

RefCollectionAlias Property ReconTargets Auto const Mandatory
Spell Property SpellToDispel Auto const Mandatory

Actor TargetRef

Event OnEffectStart(Actor akTarget, Actor akCastor)
	TargetRef = akTarget
	ReconTargets.RemoveRef(TargetRef)
    TargetRef.DispelSpell(SpellToDispel)
EndEvent
