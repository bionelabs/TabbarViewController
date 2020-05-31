# TabbarViewController
Rotate TabbarViewController

## Demo
<img src="https://github.com/onebuffer/TabbarViewController/blob/master/Resources/Screen%20Shot%202020-05-31%20at%2012.32.51.png" width="30%">
<img src="https://github.com/onebuffer/TabbarViewController/blob/master/Resources/Screen%20Shot%202020-05-31%20at%2012.33.07.png" width="80%">
<img src="https://github.com/onebuffer/TabbarViewController/blob/master/Resources/Screen%20Shot%202020-05-31%20at%2012.33.16.png" width="80%">

## Installation

### CocoaPods
Soon

### How to use

```swift

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
    
}


```

## Contact
- Email: caophuocthanh@gmail.com
- Site: https://onebuffer.com
- Linkedin: https://www.linkedin.com/in/caophuocthanh/
