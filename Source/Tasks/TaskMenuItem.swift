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
    private var onSelected: [Callback] = []
    var task: Task!

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    init(task: Task, onSelected: @escaping Callback) {
        super.init(title: "", action: nil, keyEquivalent: "")

        self.task = task
        self.onSelected = [onSelected]

        loadTask(task)
    }

    private func loadTask(_ task: Task) {
        let menuView = TaskMenuView(task: task) {
            self.onSelected.forEach { $0(self) }
        }

        view = menuView
    }
}

class TaskMenuView: NSView {
    lazy var textField = NSTextField(frame: .zero)
    lazy var button = NSButton(frame: .zero)
    private let showMaxLength = 50

    typealias Callback = () -> Void
    private var onButtonClicked: [Callback] = []

    init(task: Task, onButtonClicked: @escaping Callback) {
        super.init(frame: NSMakeRect(0, 0, 300, 25))
        self.onButtonClicked = [onButtonClicked]
        setupView()
        updateTextField(task: task)
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        textField.frame = NSMakeRect(25, -5, 275, 25)
        textField.backgroundColor = .clear
        textField.drawsBackground = false
        textField.isBezeled = false
        

        button.title = ""
        button.setButtonType(.switch)
        button.bezelStyle = .texturedRounded
        button.frame = NSMakeRect(4, 0, 25, 25)
        button.target = self
        button.action = #selector(buttonClick)

        addSubview(textField)
        addSubview(button)
    }

    @objc
    private func buttonClick(_ sender : NSButton) {
        onButtonClicked.forEach { $0() }
    }

    private func updateTextField(task: Task) {
        var attributes: [NSAttributedString.Key: AnyObject] = [
            .foregroundColor: NSColor.gray
        ]

        if task.isDone {
            attributes = [
                .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
                .strokeColor: NSColor.black,
                .foregroundColor: NSColor.lightGray
            ]
        }
        textField.attributedStringValue = NSAttributedString(string: task.value, attributes: attributes)
        textField.toolTip = task.value

        button.state = task.isDone ? .on : .off
    }
}
