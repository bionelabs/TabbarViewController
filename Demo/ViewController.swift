//
//  ViewController.swift
//  Demo
//
//  Created by Cao Phuoc Thanh on 5/27/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit
import TabbarViewController

class ViewController: TabbarViewController {
    
    let ViewControllerA = MenuViewController()
    let ViewControllerB = MenuViewController()
    let ViewControllerC = MenuViewController()
    let ViewControllerD = MenuViewController()
    let ViewControllerE = MenuViewController()
    
    override func loadView() {
        super.loadView()
        
        ViewControllerA.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named:"home"),
            selectedImage: nil)
        ViewControllerB.tabBarItem = UITabBarItem(
            title: "Media",
            image: UIImage(named:"backup-media"),
            selectedImage: nil)
        ViewControllerC.tabBarItem = UITabBarItem(
            title: "Reminder",
            image: UIImage(named:"reminder"),
            selectedImage: nil)
        ViewControllerD.tabBarItem = UITabBarItem(
            title: "Setting",
            image: UIImage(named:"tabbar-setting"),
            selectedImage: nil)
        ViewControllerE.tabBarItem = UITabBarItem(
            title: "Podcast",
            image: UIImage(named:"tabbar-setting"),
            selectedImage: nil)
        
        ViewControllerA.view.backgroundColor = UIColor("F6F9FE")
        ViewControllerB.view.backgroundColor = UIColor("b1cbf6")
        ViewControllerC.view.backgroundColor = UIColor("c8daf9")
        ViewControllerD.view.backgroundColor = UIColor("dfeafb")
        ViewControllerE.view.backgroundColor = UIColor("ffffff")
        
        self.viewControllers = [ViewControllerA,
                                ViewControllerB,
                                ViewControllerC,
                                ViewControllerD]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

