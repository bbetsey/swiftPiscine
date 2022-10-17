import Foundation

class Card: NSObject {
	
	var color: Color
	var value: Value
	
	init(Color color: Color, Value value: Value) {
		self.color = color
		self.value = value
		super.init()
	}
	
	override var description: String {
		return "\(self.value) of \(self.color)"
	}
	
	override func isEqual(_ object: Any?) -> Bool {
		guard let card = object as? Card else { return false }
		return card.value == self.value && card.color == self.color
	}
}

func ==(frst: Card, scnd: Card) -> Bool {
	return frst.isEqual(scnd)
}
