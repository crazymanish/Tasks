//
//  UserDefaults+Storage.swift
//  Tasks
//
//  Created by Manish on 06/04/2020.
//  Copyright © 2020 Manish Rathi. All rights reserved.
//

import Foundation

extension UserDefaults {
    struct Keys {
        static let tasks = "tasks"
    }

    var tasks: [Task] {
        get {
            if let storedArray = UserDefaults.standard.object(forKey: Keys.tasks) as? Data {
                return try! PropertyListDecoder().decode([Task].self, from: storedArray)
            } else {
                return []
            }
        }

        set { set(try! PropertyListEncoder().encode(newValue), forKey: Keys.tasks) }
    }
}
