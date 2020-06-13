//
//  View.swift
//  TabbarViewController
//
//  Created by Cao Phuoc Thanh on 5/30/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

internal class View: UIView {
    
    internal func setupViews() { }

    internal func setupComponents() { }
    
    internal func setupConstraints() { }
    
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
    
    override internal func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
