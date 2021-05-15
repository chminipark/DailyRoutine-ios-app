//
//  RoutineInfo.swift
//  DailyRoutine
//
//  Created by minii on 2021/04/29.
//

import UIKit

struct RoutineInfo {
    let name: String
    let totalcount: Int
    let image: Data
    let color: Data
    let date: Date
    let datelist: [String]?
    
    init(name: String, totalcount: Int, image: Data, color: Data) {
        self.name = name
        self.totalcount = totalcount
        self.image = image
        self.color = color
        self.date = Date()
        self.datelist = nil
    }
}

// UIColor CoreData에 저장하기 위해 변환
extension UIColor {

     class func color(data:Data) -> UIColor? {
          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }

     func encode() -> Data? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
}
