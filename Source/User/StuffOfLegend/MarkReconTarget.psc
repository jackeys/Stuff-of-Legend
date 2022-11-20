Scriptname StuffOfLegend:MarkReconTarget extends ActiveMagicEffect

RefCollectionAlias Property ReconTargets Auto const Mandatory
float Property DistanceBeforeUnmarking Auto Const Mandatory

Event OnEffectStart(Actor akTarget, Actor akCaster)
	ReconTargets.AddRef(akTarget)

	if IsBoundGameObjectAvailable()
		RegisterForDistanceGreaterThanEvent(akTarget, akCaster, DistanceBeforeUnmarking)
	EndIf
EndEvent

Event OnDistanceGreaterThan(ObjectReference akTarget, ObjectReference akCaster, float afDistance)
	ReconTargets.RemoveRef(akTarget)
	Dispel()
EndEvent
