//
//  Home.swift
//  Tasks
//
//  Created by Manish on 06/04/2020.
//  Copyright © 2020 Manish Rathi. All rights reserved.
//

import Foundation
import Cocoa

class Home: NSObject {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let taskStorage = TaskStorage()
    private var menu: Menu!

    override init() {
        super.init()

        menu = Menu(taskStorage: taskStorage, home: self)
        start()
    }

    func showPopUp() {
        if let button = statusItem.button, let window = button.window {
            menu.popUp(positioning: nil, at: window.frame.origin, in: nil)
        }
    }

    func reloadPopUp() {
        menu.reloadData()

        showPopUp()
    }
}

extension Home {
    private func start() {
        statusItem.menu = menu
        statusItem.isVisible = true

        populateFooter()
    }

    private func populateFooter() {
        for item in footerItems {
            menu.addItem(item)
        }
    }

    private var footerItems: [NSMenuItem] {
        let footerItems: [(option: MenuOption, key: String)] = [
            (.separator, ""),
            (.add, "+"),
            (.quit, "q")
        ]

        return footerItems.map({ item -> NSMenuItem in
            if item.option == .separator {
                return NSMenuItem.separator()
            } else {
                let menuItem = NSMenuItem(title: item.option.rawValue,
                                          action: #selector(menuItemAction),
                                          keyEquivalent: item.key)
                menuItem.target = self
                return menuItem
            }
        })
    }

    @objc
    private func menuItemAction(_ sender: NSMenuItem) {
        switch sender.title {
        case MenuOption.add.rawValue:
            add(sender)
        case MenuOption.quit.rawValue:
            NSApp.stop(sender)
        default:
            break
        }
    }

    private func add(_ sender: NSMenuItem) {
        let task = Task(value: UUID().uuidString)

        taskStorage.add(task)
        reloadPopUp()
    }
}
