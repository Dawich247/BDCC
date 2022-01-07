extends Node
class_name StatusEffectBase

var id = "badstatuseffect"
var isBattleOnly = false
var character: BaseCharacter
var turns = -1

func _init():
	pass
	
func initArgs(_args = []):
	pass

func setCharacter(c: BaseCharacter):
	character = c
	
func processBattleTurn():
	pass
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	return "Error bad"

func getEffectDesc():
	return "Let the developer know"

func getEffectImage():
	return null

func getEffectVisibleType():
	return StatusEffectsPanel.EffectType.Normal

func combine(_newArgs = []):
	pass

func stop():
	if(!character):
		queue_free()
		return
	
	character.removeEffect(id)

func getAccuracyMod(_damageType):
	return 1

func getDodgeMod(_damageType):
	return 1
	
func getRecievedDamageMod(_damageType):
	return 1
