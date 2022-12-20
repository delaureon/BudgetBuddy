//
//  Expense.swift
//  budgetApp
//
//  Created by csuftitan on 12/15/22.
//

import SwiftUI

struct Expense: Identifiable,Hashable{
    var id = UUID().uuidString
    var remark: String
    var amount: Double
    var date: Date
    var type: ExpenseType
    var color: String
}

enum ExpenseType: String {
    case income = "Income"
    case expense = "Expenses"
    case all = "ALL"
}

var expensesList: [Expense] = [
    Expense(remark: "Keyboad", amount: 99, date: Date(timeIntervalSince1970: 1652987245), type: .expense, color: "Blue"),
    Expense(remark: "Burger King", amount: 19, date: Date(timeIntervalSince1970: 1652814445), type: .expense, color: "Lime"),
    Expense(remark: "Check", amount: 2398, date: Date(timeIntervalSince1970: 1659873445), type: .income, color: "Red"),
    Expense(remark: "DoorDash Pass", amount: 9.99, date: Date(timeIntervalSince1970: 1653344845), type: .expense, color: "Gray"),
    Expense(remark: "Spotify", amount: 7.99, date: Date(timeIntervalSince1970: 1654456745), type: .expense, color: "Yellow"),
    Expense(remark: "H&M CLOTHING", amount: 123.56, date: Date(timeIntervalSince1970: 1655484845), type: .expense, color: "Lime"),
    Expense(remark: "Stocks", amount: 150, date: Date(timeIntervalSince1970: 1655389945), type: .income, color: "Red"),
    Expense(remark: "PhoTasty", amount: 23.44, date: Date(timeIntervalSince1970: 1655669045), type: .expense, color: "Blue"),
    Expense(remark: "Red Palace kBBQ", amount: 22.12, date: Date(timeIntervalSince1970: 1665478945), type: .expense, color: "Gray"),
    Expense(remark: "Vet Visit", amount: 88.12, date: Date(timeIntervalSince1970: 1671190079), type: .expense, color: "Yellow"),
]
