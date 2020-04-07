//
//  TaskMenuItem.swift
//  Tasks
//
//  Created by Manish on 06/04/2020.
//  Copyright © 2020 Manish Rathi. All rights reserved.
//

import Cocoa

class TaskMenuItem: NSMenuItem {
    typealias Callback = (TaskMenuItem) -> Void

    private let showMaxLength = 50
    private var onSelected: [Callback] = []
    var task: Task!

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    init(task: Task, onSelected: @escaping Callback) {
        super.init(title: "", action: #selector(onSelect(_:)), keyEquivalent: "")

        self.task = task
        self.onSelected = [onSelected]
        self.target = self

        loadTask(task)
    }

    @objc
    func onSelect(_ sender: NSMenuItem) {
        for hook in onSelected {
            hook(self)
        }
    }

    private func loadTask(_ task: Task) {
        let taskValue = task.value

        self.title = humanizedTitle(taskValue)
        self.toolTip = """
        \(taskValue)\n \n
        Press ⌘ E to edit.
        Press ⌘ X to delete.
        """
        self.state = task.isDone ? .on : .off
    }

    private func humanizedTitle(_ title: String) -> String {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedTitle.count > showMaxLength {
            let index = trimmedTitle.index(trimmedTitle.startIndex, offsetBy: showMaxLength)
            return "\(trimmedTitle[...index])..."
        } else {
            return trimmedTitle
        }
    }
}
