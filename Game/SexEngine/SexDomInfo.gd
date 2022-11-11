extends SexInfoBase
class_name SexDomInfo

var stance = SexStance.Standing
var goals:Array = []
var anger: float = 0.0
var isDown:bool = false
var angerFull: float = 0.0

func checkIsDown():
	if(!isDown && getChar().getPainLevel() >= 1.0):
		isDown = true
		return true
	return false

func canDoActions():
	return !isDown

func addAnger(howmuch = 0.2):
	var meanness = personalityScore({PersonalityStat.Mean:0.5, PersonalityStat.Impatient:0.2, PersonalityStat.Subby:-0.2})
	if(meanness >= 0.0):
		if(howmuch > 0.0):
			howmuch *= (1.0 + meanness)
		else:
			howmuch *= max(1.0 - meanness, 0.1)
	else:
		if(howmuch > 0.0):
			howmuch *= max(1.0 + meanness, 0.1)
		else:
			howmuch *= (1.0 - meanness)
	
	anger += howmuch
	anger = clamp(anger, 0.0, 1.0)

func getAngerScore():
	return anger

func getIsAngryScore():
	if(isAngry()):
		return 1.0
	return 0.0

func getIsSlightlyAngryScore():
	if(isSlightlyAngry()):
		return 1.0
	return 0.0

func getTrustsSubScore():
	return clamp(1.0 - anger * 3.0, 0.0, 1.0)

func isSlightlyAngry():
	return anger > 0.2

func isAngry():
	return anger > (0.6 - personalityScore({PersonalityStat.Mean: 0.2}))

func getInfoString():
	var character = getChar()
	
	var text = ""
	if(character != null):
		text += character.getName()+". "
	text += "Anger: "+str(Util.roundF(anger*100))+"% "
	text += "Arousal: "+str(Util.roundF(getArousal()*100))+"% "
	
	return text

func initFromPersonality():
	var character = getChar()
	var personality:Personality = character.getPersonality()

	var mean = personality.getStat(PersonalityStat.Mean)
	
	if(mean > 0.0):
		anger = RNG.randf_range(0.0, mean) / 5.0

func processTurn():
	arousalNaturalFade()
	
#	var character = getChar()
#	var personality:Personality = character.getPersonality()
#
#	var evilness = personality.getStat(PersonalityStat.Evilness)
#	anger = Util.moveNumberTowards(anger, evilness, 0.01)

	.processTurn()
	angerFull += anger

func hasGoals():
	return goals.size() > 0

func goalsScore(thegoals:Dictionary, theSubID):
	var result = 0.0
	for goalInfo in goals:
		if(thegoals.has(goalInfo[0]) && goalInfo[1] == theSubID):
			result += thegoals[goalInfo[0]]
	
	return result

func getAverageAnger() -> float:
	return angerFull / float(Util.maxi(1, tick))

func getSexEndInfo():
	var texts:Array = .getSexEndInfo()
	
	texts.append("Average anger: "+str(Util.roundF(getAverageAnger()*100.0, 1))+"%")
	
	return texts
