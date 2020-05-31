//
//  View.swift
//  TabbarViewController
//
//  Created by Cao Phuoc Thanh on 5/30/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

open class View: UIView {
    
    open func setupViews() { }

    open func setupComponents() { }
    
    open func setupConstraints() { }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setupViews()
        self.setupComponents()
        self.setupConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
