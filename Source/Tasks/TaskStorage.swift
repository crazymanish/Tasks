//
//  Tasks.swift
//  Tasks
//
//  Created by Manish on 07/04/2020.
//  Copyright © 2020 Manish Rathi. All rights reserved.
//

import AppKit

class TaskStorage {
    var all: [Task] {
        get { return UserDefaults.standard.tasks }
        set { UserDefaults.standard.tasks = newValue }
    }

    func add(_ task: Task) {
        if task.value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }

        if let existingTask = all.first(where: { $0 == task }) {
            existingTask.updatedAt = Date()
            update(task)
        } else {
            all = [task] + all
        }
    }

    func update(_ task: Task) {
        if let itemIndex = all.firstIndex(of: task) {
            task.updatedAt = Date()
            all.remove(at: itemIndex)
            all.insert(task, at: itemIndex)
        }
    }

    func remove(_ task: Task) {
        all.removeAll(where: { $0 == task })
    }

    func clear() {
        all.removeAll()
    }
}
