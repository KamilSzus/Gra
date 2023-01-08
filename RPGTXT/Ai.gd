extends Node

onready var map = $Map

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
	elif(firstWord == "idz"):
		if(secondWord == "prosto"):
			return "Idziesz prze siebie \n"
		if(secondWord == "w"):
			if(thirdWord == "lewo"):
				return "idziesz w lewo \n"
			elif(thirdWord == "prawo"):
				return "idziesz w prwo \n"
			else:
				return "Podana komenda jeszcze nie istnieje"
		if(secondWord == "do"):
			if(thirdWord == "tylu"):
				return "Cofasz sie \n"
			else:
				return "Podana komenda jeszcze nie istnieje"
	else:
		return "Podana komenda jeszcze nie istnieje"
		
		
func printHelp():
	return """Lista dostępnych komend
	- idz [Prosto/W lewo/ W prawo/ do tylu]
	- Zaatakuj [Osobe]
	- Otworz drzwi/skrzynie
	- Uciekaj
	- Zabij sie
	"""


func environmentGeneration(currentPosition: String):
	if(currentPosition == "A1"):
		return "Twoja cela jedynym sensownym wyjsciem jest pojscie prze siebie, nic tu nie ma poza oblakanym starcem"
	elif(currentPosition == "A2"):
		return "Waski korytarz z obu stron otoczony scianami."
	elif(currentPosition == "A3"):
		return "Waski korytarz z obu stron otoczony scianami."
	elif(currentPosition == "A4"):
		return "Korytarz z oknem przez ktore widac rzeczy tak potworne ze az nie do opisania, z lewej strony dalej sciana z prwej ciag dalszy korytarzu"
	elif(currentPosition == "A5"):
		return "Lecac z tego okna zauwazasz jedna ciekawa rzecz ze zamiast spadac lecisz do gory po chwili uderzarz w niebo."
	elif(currentPosition == "A6"):
		return "Cela nie wiem jak tu sie znalazles, won"
	elif(currentPosition == "A7"):
		return "Zbrojownia w jednym z jego katow znajdujesz zakurzony sztylet ktory chowasz do plecaka. Jedynym wyjsciem sa dzwi po prawej prowadzacej na korytarz"
	elif(currentPosition == "A8"):
		return "Kuchnia z jakiegos powodu straznik odwraca sie do Ciebie plecami to Twoja okazja. Jedynym wyjsciem sa dzwi po prawej prowadzacej na korytarz"
	elif(currentPosition == "A9"):
		return "Przed soba masz ogromne wrota ktore pokryte sa kurzem widac ze byly dawno nie uzywane, po prawej korytarz znowu..."
	elif(currentPosition == "A10"):
		return "Brama ktora z niewyjasnionych przyczyn Ciebie odpycha"
	elif(currentPosition == "A11"):
		return "Waski korytarz z lewej ciemna cela z z prawej ####### wyglada to bardzo cie..."
	elif(currentPosition == "A12"):
		return "Waski korytarz z lewej Zbrojownia z prawej sala przesuchan, nie chcesz sie tam znalezc"
	elif(currentPosition == "A13"):
		return "Waski korytarz z lewej kuchnia a z prawej kolejna cela"
	elif(currentPosition == "A14"):
		return "z lewej strony korytarz przed saba masz okno widok tego okna jest calkowicei inny niz z poprzedniego, z prawej portal a za soba masz korytarz"
	elif(currentPosition == "A15"):
		return "Po wyskoczeniu z tego okna twoja postac poprostu znika"
	elif(currentPosition == "A16"):
		return "Co Ty tu robisz?"
	elif(currentPosition == "A17"):
		return "Tu czeka tylko smierc"
	elif(currentPosition == "A18"):
		return "Cela"
	elif(currentPosition == "A19"):
		return "Portal, ucieczka"
