//
//  CalendarInfo.swift
//  DailyRoutine
//
//  Created by minii on 2021/05/14.
//

import UIKit

struct CalendarInfo {
    let color: Data
    let datelist: [String]
    
    init(color: Data, datelist: [String]) {
        self.color = color
        self.datelist = datelist
    }
}
