//
//  UserDefaults.swift
//  Drink-EG
//
//  Created by 김도연 on 8/20/24.
//

import UIKit

extension UserDefaults {
    private enum Keys {
        static let comments = "comments"
    }
    
    func saveComments(_ comments: [Comment]) {
        if let encoded = try? JSONEncoder().encode(comments) {
            self.set(encoded, forKey: Keys.comments)
        }
    }
    
    func loadComments() -> [Comment] {
        if let savedData = self.data(forKey: Keys.comments),
           let savedComments = try? JSONDecoder().decode([Comment].self, from: savedData) {
            return savedComments
        }
        return []
    }
}
