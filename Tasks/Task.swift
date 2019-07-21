//
//  Task.swift
//  GoodList
//
//  Created by Kelvin Fok on 17/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

enum Priority: Int {
    case high, medium, low
}

struct Task {
    let title: String
    let priority: Priority
}
