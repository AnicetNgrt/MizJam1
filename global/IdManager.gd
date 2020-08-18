extends Object

var _lastId = 0

# @post: return != Constants.UNDEFINED_ID
func getNextId() -> int:
	_lastId += 1
	return _lastId
