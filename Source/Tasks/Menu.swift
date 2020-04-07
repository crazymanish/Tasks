//
//  Menu.swift
//  Tasks
//
//  Created by Manish on 06/04/2020.
//  Copyright © 2020 Manish Rathi. All rights reserved.
//

import AppKit

class Menu: NSMenu {
    let menuWidth = 300

    private weak var home: Home?
    private var taskStorage: TaskStorage!
    private var taskMenuItems: [TaskMenuItem] = []

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    init(taskStorage: TaskStorage, home: Home) {
        super.init(title: "Tasks")
        self.taskStorage = taskStorage
        self.home = home
        self.delegate = self
        self.minimumWidth = CGFloat(menuWidth)
    }

    func reloadData() {
        menuWillOpen(self)
    }
}

extension Menu: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        clear()
        for task in taskStorage.all.sorted(by: { $0.updatedAt.compare($1.updatedAt) == .orderedAscending }) {
            let taskMenuItem = TaskMenuItem(task: task, onSelected: taskMenuItemOnSelected(_:))
            taskMenuItems.append(taskMenuItem)

            insertItem(taskMenuItem, at: 0)
        }
    }

    private func clear() {
        taskMenuItems.forEach { removeItem($0) }
        taskMenuItems.removeAll()
    }

    private func taskMenuItemOnSelected(_ taskMenuItem: TaskMenuItem) {
        taskMenuItem.task.isDone.toggle()

        taskStorage.update(taskMenuItem.task)
        home?.reloadPopUp()
    }
}
