//
//  MenuViewController.swift
//  Demo
//
//  Created by Cao Phuoc Thanh on 5/28/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let button: UIButton = {
        let view = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        view.backgroundColor = .red
        view.setTitle("TAP", for: .normal)
        return view
    }()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        title = "onebuffer"
    }
    
    @objc func tap() {

        if let navigationController = self.navigationController {
            let vc = MenuViewController()
            navigationController.pushViewController(vc, animated: true)
        } else {
            let vc = ListViewController()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
