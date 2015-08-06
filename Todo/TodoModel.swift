//
//  TodoModel.swift
//  Todo
//
//  Created by Arthur on 6/6/15.
//  Copyright (c) 2015 Arthur. All rights reserved.
//

import UIKit

class TodoModel: NSObject {
    var id: String
    var title: String
    var type: String
    var date: NSDate

    init(id: String, title: String, type: String, date: NSDate ) {
        self.id = id
        self.title = title
        self.type = type
        self.date = date
    }
}
