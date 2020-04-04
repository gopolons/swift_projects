import UIKit
import Foundation


//Defines a deck
struct Card {
    let rank: Rank
    let suit: Suit
    
    enum Rank: Int {
    case Two = 2
        case Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        
        func rankDescription() -> String {
            switch self {
                case .Jack: return "Jack"
                case .Queen: return "Queen"
                case .King: return "King"
                case .Ace: return "Ace"
                case .Two: return "Two"
                case .Three: return "Three"
                case .Four: return "Four"
                case .Five: return "Five"
                case .Six: return "Six"
                case .Seven: return "Seven"
                case .Eight: return "Eight"
                case .Nine: return "Nine"
                case .Ten: return "Ten"
            }
        }
        
        func cardsValue() -> Int {
            switch self {
                case .Ace: return 1
                case .Queen: return 11
                case .Jack: return 0
                case .King: return 12
                case .Two: return 2
                case .Three: return 3
                case .Four: return 4
                case .Five: return 5
                case .Six: return 6
                case .Seven: return 7
                case .Eight: return 8
                case .Nine: return 9
                case .Ten: return 10
                
            }
        }
        
        func rankDescriptionImages() -> String {
            switch self {
                case .Jack: return "J"
                case .Queen: return "Q"
                case .King: return "K"
                case .Ace: return "A"
                case .Two: return "2"
                case .Three: return "3"
                case .Four: return "4"
                case .Five: return "5"
                case .Six: return "6"
                case .Seven: return "7"
                case .Eight: return "8"
                case .Nine: return "9"
                case .Ten: return "10"
            }
        }
    }
    
    enum Suit: String {
        case spade = "S"
        case heart = "H"
        case diamond = "D"
        case club = "C"
    }
}

//Defines all possible decks here
var playDeck: Array = [Card]()
var playerHand: Array = [Card]()
var opponentHand: Array = [Card]()
var visDeck: Array = [Card]()

//Generates a deck of cards
func generateADeck() -> [Card] {
    let maxRank = Card.Rank.Ace.rawValue
    let aSuit:Array = [Card.Suit.club.rawValue, Card.Suit.diamond.rawValue, Card.Suit.heart.rawValue, Card.Suit.spade.rawValue]
    
    for count in 2...maxRank {
        for suit in aSuit {
            let aRank = Card.Rank.init(rawValue: count)
            let aSuit = Card.Suit.init(rawValue: suit)
            let myCard = Card(rank: aRank!, suit: aSuit!)
            playDeck.append(myCard)
        }
    }
    return playDeck
}

//Helps the UI with tabletop
var cardChoice = 0

//Checks if its the player's turn
var PlayerTurnCheck = 1

//Array that is required for AI to calculate their moves
var arrayValueOpponent: [Int]

//Identifies a card, provides information it is storing
func cardsInfo(playingCard:Card) -> (name: String, imageName: String, points: Int) {
    let name = playingCard.rank.rankDescription()
    let imageName = playingCard.rank.rankDescriptionImages() + playingCard.suit.rawValue
    let points = playingCard.rank.cardsValue()
    let card = (name, imageName, points)
    return card
}

//function which adds up values for PlayerHandValue
func sumPlayerCardValue() -> (Int) {
    let cardValuePlayer = cardsInfo(playingCard: playerHand[0]).points
    let cardValuePlayer1 = cardsInfo(playingCard: playerHand[1]).points
    let cardValuePlayer2 = cardsInfo(playingCard: playerHand[2]).points
    let cardValuePlayer3 = cardsInfo(playingCard: playerHand[3]).points
    let cardValuePlayer4 = cardsInfo(playingCard: playerHand[4]).points
    let sumValuePlayer = cardValuePlayer + cardValuePlayer1 + cardValuePlayer2 + cardValuePlayer3 + cardValuePlayer4
    return sumValuePlayer
    }

//function which adds up values for opponentHandValue
func sumOpponentCardValue() -> (Int) {
    let cardValueOpponent = cardsInfo(playingCard: opponentHand[0]).points
    let cardValueOpponent1 = cardsInfo(playingCard: opponentHand[1]).points
    let cardValueOpponent2 = cardsInfo(playingCard: opponentHand[2]).points
    let cardValueOpponent3 = cardsInfo(playingCard: opponentHand[3]).points
    let cardValueOpponent4 = cardsInfo(playingCard: opponentHand[4]).points
    var arrayValueOpponent = [cardValueOpponent, cardValueOpponent1, cardValueOpponent2, cardValueOpponent3, cardValueOpponent4]
    let sumValueOpponent = cardValueOpponent + cardValueOpponent1 + cardValueOpponent2 + cardValueOpponent3 + cardValueOpponent4
    return sumValueOpponent
    }

//References a name for graphical output for the player cards
func imageOutput(x:Int) -> (String) {
    let theCardImage = cardsInfo(playingCard: playerHand[x])
    let cardDeckCommand = theCardImage.imageName
    return cardDeckCommand
}

//Referenes a name for grpahical output for the top deck card
func imageOutputTop() -> (String) {
    let theTopCardImage = cardsInfo(playingCard: visDeck[0])
    let cardTopDeckCommand = theTopCardImage.imageName
    return cardTopDeckCommand
}

//references the value of the topdeck card for AI to function
func valueOutputOpponentTop() -> (Int) {
    let theTopCardValue = cardsInfo(playingCard: visDeck[0])
    let cardTopDeckValue = theTopCardValue.points
    return cardTopDeckValue
}

//Deals cards
func DealCards() {
        generateADeck()
for _ in 0..<5 {
    playDeck.shuffle()
    playerHand.append(playDeck[0])
    playDeck.remove(at: 0)
    opponentHand.append(playDeck[0])
    playDeck.remove(at: 0)
}
visDeck.append(playDeck[0])
    playDeck.remove(at:0)
    playDeck.shuffle()
}

func updateCardsUI() {
    playerCard1.image = UIImage(named: imageOutput(x: 0))
    playerCard2.image = UIImage(named: imageOutput(x: 1))
    playerCard3.image = UIImage(named: imageOutput(x: 2))
    playerCard4.image = UIImage(named: imageOutput(x: 3))
    playerCard5.image = UIImage(named: imageOutput(x: 4))
    visibleTopCard.image = UIImage(named: imageOutputTop())
    cardChoice = 0
    }



//Player Turn
  func PlayerTurn() {
      sumPlayerCardValue()
      if sumPlayerCardValue() > 5 {
          PlayerTurnCheck = 1
          textBoxOutlet.text = "Your turn!"
          textBoxOutlet.isHidden = false
        
    }
}

//Opponent's Turn
func OpponentTurn() {
    sumOpponentCardValue()
    valueOutputOpponentTop()
    if sumOpponentCardValue() > 5 {
        let cardPlayed = arrayValueOpponent.firstIndex(of: arrayValueOpponent.max()!)
        if valueOutputOpponentTop() > cardPlayed!{
            visDeck.insert(opponentHand[cardPlayed!], at: 0)
            opponentHand.append(playDeck[0])
            playDeck.remove(at: 0)
            opponentHand.remove(at: cardPlayed!)
        } else {
                opponentHand.append(visDeck[0])
                visDeck.remove(at: 0)
                visDeck.insert(opponentHand[cardPlayed!], at: 0)
                opponentHand.remove(at: cardPlayed!)
                }
                PlayerTurn()
    }
}



