extends Attack

func _init():
	id = "ElizaHornyCloud"
	category = Category.Lust
	aiCategory = AICategory.Lust
	aiScoreMultiplier = 0.5
	
func getVisibleName(_context = {}):
	return "Horny cloud"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Lust)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Lust)):
		return "{receiver.name} managed to avoid the pink cloud!"
	
	var text = "The vial breaks under {receiver.name}’s feet and spawns a huge pink cloud! {receiver.name} breathes it in and feels very aroused, it puts {receiver.him} into an artificial heat!"
	var _damage = doDamage(_attacker, _receiver, DamageType.Lust, 25)
	_receiver.addEffect(StatusEffect.ArtificialHeat)
	text += " " + receiverDamageMessage(DamageType.Lust, _damage)
	return text
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} fetches some vial off of {attacker.his} belt and throws it at {receiver.name}!"
