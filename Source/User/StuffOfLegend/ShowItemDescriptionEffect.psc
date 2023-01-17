Scriptname StuffOfLegend:ShowItemDescriptionEffect extends ActiveMagicEffect
{Gives the wearer a potion when the effect starts and removes it when the effect ends, which allows for an effect to be given that shows the player an item description}

Potion Property EffectToShow Auto Const Mandatory
; Potion Property EffectToDispel Auto Const Mandatory

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.equipitem(EffectToShow, false, true)
EndEvent

; Event OnEffectFinish(Actor akTarget, Actor akCaster)
; 	akTarget.equipitem(EffectToDispel, false, true)
; EndEvent