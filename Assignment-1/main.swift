//
//  main.swift
//  Assignment-1
//
//  Created by Aman on 10/06/22.
//

import Foundation

class TaskManager {
    var quit = false
    
    enum Task: String, CaseIterable {
        case RockPaperScissor = "Rock Paper Scissor"
        case SearchEngines = "Enum"
        case Manager = "Employee-Student Manager"
        case Quit
    }
    
    @discardableResult
    init() {
        start()
    }
    
    private func start() {
        print("************* This is Task Manager *************")
        while !quit {
            print("Tasks available:")
            for task in Task.allCases {
                print(task.rawValue)
            }
            print("Please select option above:")
            if let input = readLine(),
                let task = checkInput(input: input) {
                print("\n")
                switch task {
                case .RockPaperScissor:
                    RockPaperScissorGame()
                case .SearchEngines:
                    SearchEngines()
                case .Manager:
                    EmployeeStudentManager()
                case .Quit:
                    print("See you later!!!")
                    quit = true
                }
                print("\n")
            } else {
                print("Wrong input. Try again.\n")
            }
        }
    }

    private func checkInput(input: String) -> Task? {
        for task in Task.allCases {
            if task.rawValue.caseInsensitiveCompare(input) == .orderedSame {
                return task
            }
        }
        return nil
    }

    private func tryAgain() {
        print("Do you want to try more command? (Y/N)")
        if let input = readLine() {
            if input.caseInsensitiveCompare("y") == .orderedSame {
                quit = false
            } else if input.caseInsensitiveCompare("n") == .orderedSame  {
                quit = true
            } else {
                print("Wrong input. Try again. \n")
                tryAgain()
            }
        } else {
            print("Wrong input. Try again. \n")
            tryAgain()
        }
    }
}

TaskManager()
