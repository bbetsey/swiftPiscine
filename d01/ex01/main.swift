let cards: [Card] = [
	Card(Color: Color.hearts, Value: Value.six),
	Card(Color: Color.diamonds, Value: Value.six),
	Card(Color: Color.clubs, Value: Value.six),
	Card(Color: Color.spades, Value: Value.six),
]

print("Cards:\n----------")
for card in cards {
	print(card)
}

print("\nisEqual test:\n----------")
for card in cards {
	for secondCard in cards {
		print("\(card) - " + (card.isEqual(secondCard) ? "is equal - " : "isn't equal - ") + "\(secondCard)")
	}
}

print("\n== test:\n----------")
for card in cards {
	for secondCard in cards {
		print("\(card)" + (card == secondCard ? " == " : " != ") + "\(secondCard)")
	}
}
