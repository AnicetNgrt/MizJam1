extends Node

class_name CardStack

func addCard(card):
	add_child(card)

func getCard(index):
	return get_child(index)

func getHandCards():
	return get_children()
