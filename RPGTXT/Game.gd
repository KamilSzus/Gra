extends Control

onready var response = preload("res://Response.tscn")
onready var question = preload("res://Question.tscn")
onready var qa = preload("res://Q&A.tscn")
onready var ai = $Ai
onready var history = $PanelContainer/MarginContainer/VBoxContainer/GameText/ScrollContainer/History
var start = 1;
var isTurorial = 0;

func _ready():
	var responseInstance = response.instance()
	responseInstance.text = "Witaj w grze It's ''not'' a PENALTY, it's a challenge twoim zadaniem bedzie ucieczka z wiezienia aby ulatwic rozgrywke przygotowany jest tutorial aby go uruchomic wpisz tutorial jak nie chcesz z niego skorzystac wpisz nowa gra"
	
	#responseInstance.text = "TY: Budzisz sie z ogromnym bolem glowy nie wiedząc gdzie jestes a co gorsze nie wiesz kim jesteś"
	history.add_child(responseInstance)

func _on_LineEdit_text_entered(new_text: String) -> void:
	if !new_text:
		return
	
	if(start == 1):
		if(new_text == "tutorial" || isTurorial != 0 ):
			tutorial(new_text)
			if(new_text == "zxc"):
				isTurorial = 0
				start = 0
				
			return
		elif(new_text == "nowa gra"):
			pass
		elif(new_text == "wyjscie"):
			pass
		else:
			var responseInstance = response.instance()
			responseInstance.text = "Podana komenda nie istnieje"
			history.add_child(responseInstance)
			return
		
	start = 0
	var qaInstance = qa.instance()
	
	var answer = ai.printAnswer(new_text)
	qaInstance.set_question(new_text)
	qaInstance.set_response(answer)
	
	history.add_child(qaInstance)

func tutorial(word: String):
	var responseInstance = response.instance()
	var questionInstance = question.instance()
	if(isTurorial == 0):
		responseInstance.text = "Witaj w tutorialu twoim celem będzie ucieczka z więzienia aby wykonywać akcje należy wpisać na klatiaturze konkretne slowo lub slowa za chwile zaprezentuje Tobie kilka przykladow"
		questionInstance.text = word
		history.add_child(questionInstance)
		history.add_child(responseInstance)
		isTurorial = 1
		
		
	if(isTurorial == 1):		
		responseInstance.text += "\nTo zacznijmy od nauki pisania wpisz ''dalej'' w konsoli na samym dole ekranu gry"
		history.add_child(responseInstance)
		questionInstance.text = word
		history.add_child(questionInstance)
		if(word == "dalej"):
			isTurorial = 2
		return
		
	if(isTurorial == 2):		
		responseInstance.text = "Gratuluje potrafisz wpisac aby zobaczyc liste dostepnych komend wpisz ''pomoc''"
		history.add_child(responseInstance)
		questionInstance.text = word
		history.add_child(questionInstance)
		if(word == "pomoc"):
			var qaInstance = qa.instance()
			var help = ai.printHelp()
			responseInstance.text = help
			history.add_child(responseInstance)
			isTurorial = 3
		return
