import Foundation

class Deck: NSObject {
	
	static let allSpades: [Card] = Value.allValues.map({Card(Color: Color.spades, Value: $0)})
	static let allDiamonds: [Card] = Value.allValues.map({Card(Color: Color.diamonds, Value: $0)})
	static let allHearts: [Card] = Value.allValues.map({Card(Color: Color.hearts, Value: $0)})
	static let allClubs: [Card] = Value.allValues.map({Card(Color: Color.clubs, Value: $0)})
	
	static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs
	
	var cards: [Card]
	var disards: [Card]
	var outs: [Card]
	
	init(sorted: Bool) {
		cards = Deck.allCards
		disards = []
		outs = []
		if !sorted {
			cards.shuffle()
		}
		super.init()
	}
	
	override public var description: String {
		return cards.description
	}
	
	func draw() -> Card? {
		guard let card = cards.first else { return nil }
		outs.append(card)
		cards.removeFirst()
		return card
	}
	
	func fold(c: Card) {
		guard let i = outs.firstIndex(of: c) else { return }
		disards.append(c)
		outs.remove(at: i)
	}
}

extension Array {
	mutating func shuffle() {
		if count < 2 { return }
		var randomIndex: Int
		for i in 0..<count {
			randomIndex = Int(arc4random_uniform(UInt32(count)))
			if i != randomIndex {
				self.swapAt(i, randomIndex)
			}
		}
	}
}
