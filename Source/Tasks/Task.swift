//
//  Task.swift
//  Tasks
//
//  Created by Manish on 06/04/2020.
//  Copyright © 2020 Manish Rathi. All rights reserved.
//

import Foundation

class Task: Codable {
    let value: String
    var isDone = false
    var updatedAt = Date()

    init(value: String) {
        self.value = value
    }
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.value == rhs.value
    }
}
