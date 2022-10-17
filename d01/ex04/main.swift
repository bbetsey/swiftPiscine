var deck = Deck(sorted: false)
var x: Card?

print(deck)

print("")
for _ in 0...10 {
	x = deck.draw()
	guard let card = x else { continue }
	print(card)
}

print("\nDeck.outs:")
print(deck.outs)

print("\nFolding some random cards:")
deck.fold(c: deck.outs[1])
deck.fold(c: deck.outs[1])
deck.fold(c: deck.cards[0])
print(deck.disards)

