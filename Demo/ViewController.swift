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
    
    let viewControllerA = MenuViewController()
    let viewControllerB = MenuViewController()
    let viewControllerC = MenuViewController()
    let viewControllerD = MenuViewController()
    let viewControllerE = MenuViewController()
    
    override func loadView() {
        super.loadView()
        
        viewControllerA.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named:"home"),
            selectedImage: nil)
        viewControllerB.tabBarItem = UITabBarItem(
            title: "Media",
            image: UIImage(named:"backup-media"),
            selectedImage: nil)
        viewControllerC.tabBarItem = UITabBarItem(
            title: "Reminder",
            image: UIImage(named:"reminder"),
            selectedImage: nil)
        viewControllerD.tabBarItem = UITabBarItem(
            title: "Setting",
            image: UIImage(named:"tabbar-setting"),
            selectedImage: nil)
        viewControllerE.tabBarItem = UITabBarItem(
            title: "Podcast",
            image: UIImage(named:"tabbar-setting"),
            selectedImage: nil)
        
        viewControllerA.view.backgroundColor = UIColor("F6F9FE")
        viewControllerB.view.backgroundColor = UIColor("b1cbf6")
        viewControllerC.view.backgroundColor = UIColor("c8daf9")
        viewControllerD.view.backgroundColor = UIColor("dfeafb")
        viewControllerE.view.backgroundColor = UIColor("ffffff")
        
        
        let nvA = UINavigationController(rootViewController: viewControllerA)
        
        self.viewControllers = [nvA,
                                viewControllerB,
                                viewControllerC,
                                viewControllerD]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

