//
//  main.swift
//  CardGame
//
//  Created by Georgy Polonskiy on 02/04/2020.
//  Copyright © 2020 Georgy Polonskiy. All rights reserved.
//

import Foundation

//This defines card values
let J = 0
let Q = 11
let K = 12
let A = 1

//Hand values are equal to 0 by the start of the game
var PlayerHand: [Int] = []
var OpponentHand: [Int] = []

//Card values responsible for win conditions
var PlayerHandValue = 0
var OpponentHandValue = 0

//Deck values are defined here
var Deck = [2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 10, 10, 10, 10, J, J, J, J, Q, Q, Q, Q, K, K, K, K, A, A, A, A]
var VisDeck: [Int] = []

//This gives an introduction to the player
func GameStartMsg() {
print("Welcome to the game.")
print("You and your opponent get 5 cards each.")
print("In order to win you need to have 5 points or less in your hand.")
print("You don't have to have a set amount of cards in your hand.")
print("Card values correspond to their numbers.")
print("The game starts with one card being played from the top of the deck.")
print("The player either puts his card on top of it and picks it up or puts his card and takes one from the deck.")
print("Good Luck, Have Fun!")
}

//Deals cards
func DealCards() {
for _ in 0..<5 {
    Deck.shuffle()
    PlayerHand.append(Deck[0])
    Deck.remove(at: 0)
    OpponentHand.append(Deck[0])
    Deck.remove(at: 0)
}
VisDeck.append(Deck[0])
    Deck.remove(at:0)
    Deck.shuffle()
}

//Player Turn
func PlayerTurn() {
    PlayerHandValue = PlayerHand.reduce(0, +)
    if PlayerHandValue > 5 {
        print("You have", PlayerHand.count, "cards")
        print("Your cards are", PlayerHand)
        print("The card on top is", VisDeck[0])
        print("Which card would you like to play? Put your number 1 - 5")
        
        let UserInput = readLine()
        let num1 = Int(UserInput!)
        let num2 = Int(num1!) - 1
        
        print(PlayerHand[num2], ", would you like to take", VisDeck[0], "(1) or from top of the deck (2)?")
        let UserInput2 = readLine()
        let num3 = Int(UserInput2!)
        let num4 = Int(num3!)
        
        if num4 == 1 {
            print("You drew", VisDeck[0], "for", PlayerHand[num2])
            PlayerHand.append(VisDeck[0])
            VisDeck.insert(PlayerHand[num2], at: 0)
            PlayerHand.remove(at: num2)
        }
        
        if num4 == 2 {
            print("You drew", Deck[0], "for", PlayerHand[num2])
            VisDeck.insert(PlayerHand[num2], at: 0)
            PlayerHand.remove(at: num2)
            PlayerHand.append(Deck[0])
            Deck.remove(at: 0)
        }
        print("Opponent's Turn")
        OpponentTurn()
    } else {print("You have 5 or less points! You won!")}
}

//Opponent's Turn
func OpponentTurn() {
    OpponentHandValue = OpponentHand.reduce(0, +)
    if OpponentHandValue > 5 {
        let cardPlayed = OpponentHand.firstIndex(of: OpponentHand.max()!)
        if VisDeck[0] > cardPlayed!{
            print("Opponent drew", Deck[0], "from the deck for", OpponentHand[cardPlayed!])
            VisDeck.insert(OpponentHand[cardPlayed!], at: 0)
            OpponentHand.append(Deck[0])
            Deck.remove(at: 0)
            OpponentHand.remove(at: cardPlayed!)
        } else {print("Opponent drew the top card", VisDeck[0], "for", OpponentHand[cardPlayed!])
                OpponentHand.append(VisDeck[0])
                VisDeck.remove(at: 0)
                VisDeck.insert(cardPlayed!, at: 0)
                OpponentHand.remove(at: cardPlayed!)
                }
                print("Your Turn!")
                PlayerTurn()
    } else {print("Your opponent has 5 or less points! You lost!")}
}

GameStartMsg()
DealCards()
PlayerTurn()
