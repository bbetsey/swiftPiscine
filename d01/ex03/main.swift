var deck = Deck.allCards

for (index, card) in deck.enumerated() {
	print("\(index + 1). \(card)")
}

print("\nSHUFFLE")
deck.shuffle()
for (index, card) in deck.enumerated() {
	print("\(index + 1). \(card)")
}
