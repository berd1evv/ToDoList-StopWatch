//
//  ViewController.swift
//  ToDoListAndStopWatch
//
//  Created by Eldiiar on 8/2/22.
//

import UIKit

class ViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tabBar.isTranslucent = false

        viewControllers = [
            createTabBarItem(tabBarTitle: "ToDoList", tabBarImage: "note.text", viewController: ToDoListViewController()),
            createTabBarItem(tabBarTitle: "StopWatch", tabBarImage: "timer", viewController: StopWatchViewController())
        ]
    }
    

    func createTabBarItem(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UINavigationController {
        
        let navCont = UINavigationController(rootViewController: viewController)
        navCont.tabBarItem.title = tabBarTitle
        navCont.tabBarItem.image = UIImage(systemName: tabBarImage)
        
        return navCont
    }

}

