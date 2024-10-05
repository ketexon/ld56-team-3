class_name SelectionControls
extends CanvasItem

func _process(_delta):
	visible = not TinyCreatureSelector.selected_tiny_creatures.is_empty()
