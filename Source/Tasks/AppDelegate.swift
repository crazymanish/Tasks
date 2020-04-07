//
//  AppDelegate.swift
//  Tasks
//
//  Created by Manish on 06/04/2020.
//  Copyright © 2020 Manish Rathi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    private var home: Home!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        home = Home()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.home.showPopUp()
        }
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        home.statusItem.isVisible = true
        return true
    }
}
