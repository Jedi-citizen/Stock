
//
//  Item.swift
//  TaskTracker
//
//  Created by Jedidiah Too on 26/8/25.
//


import Foundation

struct Item: Identifiable, Codable {
    let id: UUID
    var name: String
    var date: Date
    var importance: Int
    
    init(id: UUID = UUID(), name: String, date: Date, importance: Int) {
            self.id = id
            self.name = name
            self.date = date
            self.importance = importance
        }
    
    
    var remaining: String {
        let calendar = Calendar.current
        let now = calendar.startOfDay(for: Date())
        let due = calendar.startOfDay(for: date)

        
        if due < now {
            return "Overdue"
        }
        
        let components = calendar.dateComponents([.year, .month, .weekOfYear, .day], from: now, to: date)
        
        if let years = components.year, years > 0 {
            return "in \(years) year\(years > 1 ? "s" : "")"
        } else if let months = components.month, months > 0 {
            return "in \(months) month\(months > 1 ? "s" : "")"
        } else if let weeks = components.weekOfYear, weeks > 0 {
            return "in \(weeks) week\(weeks > 1 ? "s" : "")"
        } else if let days = components.day, days > 0 {
            return "in \(days) day\(days > 1 ? "s" : "")"
        } else {
            return "today"
        }
    }
    
    
}

class TaskStore: ObservableObject {
    @Published var items: [Item] = [] {
        didSet {
            save()
        }
    }
    
    private let saveKey = "tasks"

    init() {
        load()
    }

    func save() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Item].self, from: data) {
            items = decoded
        }
    }
}
