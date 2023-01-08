extends VBoxContainer

func set_question(newText: String):
	$Question.text = newText
	
func set_response(newText: String):
	$Response2.text = newText
	
func set_localization(newText: String):
	$Response.text = newText
