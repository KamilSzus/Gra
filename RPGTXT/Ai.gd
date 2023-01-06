extends Node


func printAnswer(question: String):
	var words = question.split(" ",true)
	
	if(words.size() == 0):
		return
	
	var firstWord = ""
	if(words.size() > 0):
		firstWord = words[0].to_lower()
		
	var secondWord = ""
	if(words.size() > 1):
		secondWord = words[1].to_lower()
		
	var thirdWord = ""
	if(words.size() > 2):
		thirdWord = words[2].to_lower()
	
	if(firstWord == "pomoc"):
		return printHelp()
	else:
		return "dupa"
		
		
func printHelp():
	return """Lista dostępnych komend
	- idz na [Kierunek]
	- Zaatakuj [Osobe]
	- Otworz drzwi/skrzynie
	- Uciekaj
	- Zabij sie
	"""
