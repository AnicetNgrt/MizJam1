extends Node

func consoleLog(val):
	if OS.has_feature('JavaScript'):
		JavaScript.eval("""
			console.log('"""+JSON.print(val,"  ",true)+"""')
		""")
	else:
		print(JSON.print(val,"  ",true))
