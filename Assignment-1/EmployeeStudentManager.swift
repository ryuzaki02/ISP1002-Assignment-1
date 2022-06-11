//
//  EmployeeStudentManager.swift
//  Assignment-1
//
//  Created by Aman on 10/06/22.
//

import Foundation

fileprivate enum Command: String, CaseIterable {
    case Help
    case AddStudent = "Add Student"
    case AddEmployee = "Add Employee"
    case DeleteStudent = "Delete Student"
    case DeleteEmployee = "Delete Employee"
    case ListAll = "List All"
    case Quit
}

class EmployeeStudentManager {
    private var students: [Student] = []
    private var employees: [Employee] = []
    private var quit = false
    
    @discardableResult
    init() {
        print("This is Student Employee manager")
        while !quit {
            showCommands()
        }
    }
    
    
    private func showCommands() {
        print("\n")
        print("Commands :-")
        for command in Command.allCases {
            print(command.rawValue)
        }
        print("\n")
        print("Please enter desired command")
        if let input = readLine(),
            let command = verifyInput(input: input) {
            switch command {
            case .Help:
                help()
            case .AddStudent:
                addStudent()
            case .AddEmployee:
                addEmployee()
            case .DeleteStudent:
                deleteStudent()
            case .DeleteEmployee:
                deleteEmployee()
            case .ListAll:
                listAll()
            case .Quit:
                quitManager()
            }
            if command != .Quit {
                tryAgain()
            }
        } else {
            print("Invalid input. Please try again.")
        }
    }
    
    private func verifyInput(input: String) -> Command? {
        for command in Command.allCases {
            if input.caseInsensitiveCompare(command.rawValue) == .orderedSame {
                return command
            }
        }
        return nil
    }
    
    private func help() {
        print("Add Student:- This will add a student to the file system")
        print("Add Employee:- This will add an employee to the file system")
        print("Delete {student/employee}:- This will delete the student/employee with that number: requires a student or employee number to follow the command")
        print("List All - This will list all students and employees")
        print("Quit - Quit the program")
    }
    
    private func addStudent() {
        var studentNumber = ""
        var studentName = ""
        var studentAddress = ""
        print("Please enter student number")
        if let number = readLine() {
            studentNumber = number
        }
        if let _ = students.first(where: { $0.number == studentNumber }) {
            print("Student already exists. Please try again.")
            addEmployee()
        } else {
            print("Please enter student name")
            if let name = readLine() {
                studentName = name
            }
            print("Please enter student address")
            if let address = readLine() {
                studentAddress = address
            }
            
            if !studentName.isEmpty,
               !studentNumber.isEmpty,
               !studentAddress.isEmpty {
                let student = Student(number: studentNumber, name: studentName, address: studentAddress)
                students.append(student)
            }
        }
    }
    
    private func addEmployee() {
        var employeeNumber = ""
        var employeeName = ""
        var employeeAddress = ""
        print("Please enter employee number")
        if let number = readLine() {
            employeeNumber = number
        }
        if let _ = employees.first(where: { $0.number == employeeNumber }) {
            print("Employee already exists. Please try again.")
            addEmployee()
        } else {
            print("Please enter employee name")
            if let name = readLine() {
                employeeName = name
            }
            print("Please enter employee address")
            if let address = readLine() {
                employeeAddress = address
            }
            if !employeeName.isEmpty,
               !employeeNumber.isEmpty,
               !employeeAddress.isEmpty {
                let employee = Employee(number: employeeNumber, name: employeeName, address: employeeAddress)
                employees.append(employee)
            }
        }
    }
    
    private func deleteStudent() {
        var found = false
        print("Enter student number to delete")
        if let input = readLine() {
            for (i,student) in students.enumerated() {
                if student.number == input {
                    students.remove(at: i)
                    found = true
                }
            }
        }
        if !found {
            print("Student not found in the system.")
        } else {
            print("Student deleted.")
        }
    }
    
    private func deleteEmployee() {
        var found = false
        print("Enter employee number to delete")
        if let input = readLine() {
            for (i,employee) in employees.enumerated() {
                if employee.number == input {
                    employees.remove(at: i)
                    found = true
                }
            }
        }
        if !found {
            print("Employee not found in the system.")
        } else {
            print("Employee deleted.")
        }
    }
    
    private func listAll() {
        guard students.count == 0,
           employees.count == 0 else {
            print("No data available.")
            return
        }
        
        var i = 1
        for student in students {
            print("Student \(i) - ")
            print("Student Number: \(student.number)")
            print("Student Name: \(student.name)")
            print("Student Address: \(student.address)")
        }
        i = 1
        print("\n")
        for employee in employees {
            print("Employee \(i) - ")
            print("Employee Number: \(employee.number)")
            print("Employee Name: \(employee.name)")
            print("Employee Address: \(employee.address)")
        }
    }
    
    private func quitManager() {
        print("See you later!!!")
        quit = true
    }
    
    private func tryAgain() {
        print("Do you want to try more command? (Y/N)")
        if let input = readLine() {
            if input.caseInsensitiveCompare("y") == .orderedSame {
                quit = false
            } else if input.caseInsensitiveCompare("n") == .orderedSame  {
                quitManager()
            } else {
                print("Wrong input. Try again")
                tryAgain()
            }
        } else {
            print("Wrong input. Try again")
            tryAgain()
        }
    }
}
