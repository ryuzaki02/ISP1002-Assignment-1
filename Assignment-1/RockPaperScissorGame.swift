//
//  RockPaperScissorGame.swift
//  Assignment-1
//
//  Created by Aman on 10/06/22.
//

import Foundation

fileprivate enum Game: Int, CaseIterable {
    case Rock = 0, Paper, Scissor
    
    fileprivate func getName() -> String {
        switch self {
        case .Rock:
            return "rock"
        case .Paper:
            return "paper"
        case .Scissor:
            return "scissor"
        }
    }
    
    fileprivate static func getGameChoice(choice: String) -> Game? {
        switch choice {
        case "rock":
            return .Rock
        case "paper":
            return .Paper
        case "scissor":
            return .Scissor
        default:
            return nil
        }
    }
    
    fileprivate func compareChoice(choice2: Game) -> ComparisonResult {
        switch self {
        case .Rock:
            return choice2 == .Rock ? .orderedSame : (choice2 == .Paper ? .orderedDescending : .orderedAscending)
        case .Paper:
            return choice2 == .Paper ? .orderedSame : (choice2 == .Rock ? .orderedAscending : .orderedDescending)
        case .Scissor:
            return choice2 == .Scissor ? .orderedSame : (choice2 == .Paper ? .orderedAscending : .orderedDescending)
        }
    }
}

public class RockPaperScissorGame {
    private var exit = false
    
    @discardableResult
    public init() {
        showInstructions()
    }
    
    private func showInstructions() {
        while(!exit) {
            print("Play with: \n1. Computer\n2. Two Player")
            print("Please select one option from above.")
            if let input = readLine() {
                switch input {
                case "1":
                    startGame(vsComp: true)
                case "2":
                    startGame()
                default:
                    print("Wrong input. Please select either 1 or 2.")
                    showInstructions()
                }
            } else {
                print("Wrong input. Select either 1 or 2.")
                showInstructions()
            }
        }
    }
    
    private func startGame(vsComp: Bool = false) {
        print("Enter 1st Player choice. (Rock, Paper or Scissor)")
        if let player = getPlayerInput() {
            let random = Int.random(in: 0..<3)
            if vsComp,
               let comp = Game.allCases.first(where: { $0.rawValue == random }) {
                showResult(comparison: player.compareChoice(choice2: comp), vsComp: vsComp)
            } else {
                print("Enter 2nd Player choice. (Rock, Paper or Scissor)")
                if let player2 = getPlayerInput() {
                    showResult(comparison: player.compareChoice(choice2: player2), vsComp: vsComp)
                } else {
                    print("Wrong input. Enter either Rock, Paper or Scissor")
                    startGame(vsComp: vsComp)
                }
            }
        } else {
            print("Wrong input. Enter either Rock, Paper or Scissor")
            startGame(vsComp: vsComp)
        }
    }
    
    private func getPlayerInput() -> Game? {
        guard let playerChoice = readLine(),
           playerChoice.caseInsensitiveCompare(Game.Rock.getName()) == .orderedSame || playerChoice.caseInsensitiveCompare(Game.Paper.getName()) == .orderedSame || playerChoice.caseInsensitiveCompare(Game.Scissor.getName()) == .orderedSame,
              let player = Game.getGameChoice(choice: playerChoice.lowercased()) else { return nil }
        return player
    }
    
    private func showResult(comparison: ComparisonResult, vsComp: Bool) {
        switch comparison {
        case .orderedAscending:
            print("\(vsComp ? "Player" : "Player 1") is winner!")
        case .orderedDescending:
            print("\(vsComp ? "Computer" : "Player 2") is winner!")
        case .orderedSame:
            print("That's a tie.")
        }
        playAgain()
    }
    
    private func playAgain() {
        print("\n")
        print("Do you want to play again? (Y/N)")
        if let choice = readLine() {
            if choice.lowercased() == "y" {
                exit = false
            } else if choice.lowercased() == "n" {
                print("See you later!!!")
                exit = true
            } else {
                print("Please enter either y or n.")
            }
        } else {
            print("Please enter either y or n.")
        }
    }
}

