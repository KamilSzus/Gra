extends Control

onready var response = preload("res://Response.tscn")
onready var response2 = preload("res://Response2.tscn")
onready var question = preload("res://Question.tscn")
onready var map = $Map
onready var player = $Player
onready var qa = preload("res://Q&A.tscn")
onready var ai = $Ai
onready var history = $PanelContainer/MarginContainer/VBoxContainer/GameText/ScrollContainer/History
var start = 0;
var isTurorial = 0;
var mapPosition = "A1"

func _ready():
	var responseInstance = response.instance()
	responseInstance.text = "Witaj w grze It's ''not'' a PENALTY, it's a challenge twoim zadaniem bedzie ucieczka z wiezienia aby ulatwic rozgrywke przygotowany jest tutorial aby go uruchomic wpisz tutorial jak nie chcesz z niego skorzystac wpisz nowa gra"
	history.add_child(responseInstance)

func _on_LineEdit_text_entered(new_text: String) -> void:
	if !new_text:
		return
	var responseInstance = response.instance()
	var qaInstance = qa.instance()
	var questionInstance = question.instance()
	
	if(start == 0):
		if(new_text == "tutorial" || isTurorial != 0 ):
			tutorial(new_text)
			
			return
		elif(new_text == "nowa gra" || start == 1):
			start = 1
			questionInstance.text = new_text
			history.add_child(questionInstance)
			responseInstance.text = """TY: Budzisz sie z ogromnym bolem glowy nie wiedząc gdzie jestes a co gorsze nie wiesz kim jestes
			Ktos: O widze ze sie wreszcie obudziles, milo powidac wspoltowarzysza niedoli
			Ty: Chwila gdzie my jestesmy?
			Ktos: Jak to gdzie w wiezieniu na dru...
			Wasza rozmowe przerywa wtargniecie straznika ktory wyciaga ciebie przed cele i kaze isc prosto
			"""
			history.add_child(responseInstance)
			return
		elif(new_text == "wyjscie"):
			pass
		else:
			responseInstance.text = "Podana komenda nie istnieje"
			history.add_child(responseInstance)
			return
			
	qaInstance.set_question(new_text)
	var answer = ai.printAnswer(new_text)
	if(answer == "Podana komenda jeszcze nie istnieje"):
		qaInstance.set_localization(map.generateLocation(mapPosition))	
		qaInstance.set_response(answer)
		history.add_child(qaInstance)
		return
		
	var newPosition = mapPosition
	
	if(new_text == "idz prosto"):
		newPosition = increase_cell(mapPosition,1)
	elif(new_text == "idz w lewo"):
		newPosition = increase_cell(mapPosition,-5)
	elif(new_text == "idz w prawo"):
		newPosition = increase_cell(mapPosition,5)
	elif(new_text == "idz do tylu"):
		newPosition = increase_cell(mapPosition,-1)
		
	if(newPosition == "Error"):
		qaInstance.set_response("Wpadles w sciane")
		qaInstance.set_localization(map.generateLocation(mapPosition))	
		history.add_child(qaInstance)
		return
	
	mapPosition = newPosition
	answer += ai.environmentGeneration(mapPosition)
	
	
	if(mapPosition == "A8" && player.sword == 1):
		answer += "\nDzieki posiadanemu sztyletowi udalo sie Tobie zabic straznika i zdoyc klucz"
		player.key = 1
		
	
	if(mapPosition == "A7"):
		player.sword = 1
		
	qaInstance.set_localization(map.generateLocation(mapPosition))	
	qaInstance.set_response(answer)
	history.add_child(qaInstance)

func increase_cell(cell: String, value: int):
	var letter = cell[0]
	var number = ""
	for i in cell.length():
		if(i !=0 ):
			number = cell[i]
	
	var sum = int(number) + value
	
	if(sum < 1 || sum > 19 ):
		return "Error"
	
	return letter + str(sum)

func tutorial(word: String):
	var responseInstance = response.instance()
	var responseInstance2 = response2.instance()
	var questionInstance = question.instance()
	questionInstance.text = word
	history.add_child(questionInstance)
	
	if(isTurorial == 0):
		responseInstance.text = "Witaj w tutorialu twoim celem będzie ucieczka z więzienia aby wykonywać akcje należy wpisać na klatiaturze konkretne slowo lub slowa za chwile zaprezentuje Tobie kilka przykladow"
		history.add_child(responseInstance)
		isTurorial = 1
			
	if(isTurorial == 1):		
		responseInstance2.text = "To zacznijmy od nauki pisania wpisz ''dalej'' w konsoli na samym dole ekranu gry"
		history.add_child(responseInstance2)
		if(word == "dalej"):
			isTurorial = 2

	if(isTurorial == 2):		
		responseInstance2.text = "Gratuluje potrafisz wpisac aby zobaczyc liste dostepnych komend wpisz ''pomoc''"
		history.add_child(responseInstance2)
		if(word == "pomoc"):
			var qaInstance = qa.instance()
			var help = ai.printHelp()
			responseInstance2.text = help
			history.add_child(responseInstance2)
			isTurorial = 3
		
	if(isTurorial == 3):		
		responseInstance2.text = "Aby poruszac postacia wpisz ''idz [Kierunek]'' kierunek to prosto/w lewo/w prawo/do tylu w tutorialu poprawna komenda to ''idz prosto''"
		history.add_child(responseInstance2)
		if(word == "idz prosto"):
			isTurorial = 4
		
	if(isTurorial == 4):		
		responseInstance2.text = "Ostatnim krokiem bedzie atakowanie aby to zrobic wpisz ''zaatakuj [osobe]'' np. straznika jak w tym wypadku"
		history.add_child(responseInstance2)
		if(word == "zaatakuj straznika"):
			responseInstance2.text = "Efektem Twojej marnej proby ataku konczy sie utrata twojej przytomnosci, wyglada na to ze zycie awanturnika nie jest stworzone dla Ciebie"
			history.add_child(responseInstance2)
			isTurorial = 0
			start = 1

