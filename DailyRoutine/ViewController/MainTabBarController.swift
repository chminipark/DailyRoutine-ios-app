//
//  MainTabBarController.swift
//  DailyRoutine
//
//  Created by minii on 2021/04/02.
//

import UIKit

class MainTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [graphNC, homeNC, addNC]
    }
    
    // tabbar 설정
    // tabbar image는 sfsymbols에서 들고옴
    let graphNC = { () -> UINavigationController in
        let graphnc = UINavigationController.init(rootViewController: CalendarController())
        let graphTabBarItem = UITabBarItem(title: "graph", image: UIImage(systemName: "ellipsis.circle"), tag: 0)
        graphnc.tabBarItem = graphTabBarItem
        return graphnc
    }()
    
    let homeNC = { () -> UINavigationController in
        let homenc = UINavigationController.init(rootViewController: HomeViewController())
        let homeTabBarItem = UITabBarItem(title: "home", image: UIImage(systemName: "house.fill"), tag: 1)
        homenc.tabBarItem = homeTabBarItem
        return homenc
    }()
    
    let addNC = { () -> UINavigationController in
        let addnc = UINavigationController.init(rootViewController: AddViewController())
        let addTabBarItem = UITabBarItem(title: "add", image: UIImage(systemName: "plus.circle"), tag: 2)
        addnc.tabBarItem = addTabBarItem
        return addnc
    }()
    
}
