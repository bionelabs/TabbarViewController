//
//  UIViewLayout.swift
//  UILayoutKit
//
//  Created by Cao Phuoc Thanh on 4/24/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

internal extension UIView {
    
    class Visual {
        
        internal enum Size: Int {
            case width
            case height
        }
        
        internal enum Align: Int {
            case horizontal
            case vertical
        }
        
        internal enum Edge: Int {
            
            case horizontal
            case vertical
            
            case leading
            case trailing
            case top
            case bottom
        }
        
        private let superview: UIView?
        private let _view: UIView
        internal var contraints: [NSLayoutConstraint] = []
        
        init(_ view: UIView) {
            self._view = view
            self._view.translatesAutoresizingMaskIntoConstraints = false
            self.superview = view.superview
        }
        
        @discardableResult internal func center(_ atributes: [UIView.Visual.Align]) -> Visual {
            guard let superview = self.superview else { return self }
            var _constraints: [NSLayoutConstraint] = []
            
            atributes.forEach { (atribute) in
                switch atribute {
                case .horizontal:
                    _constraints += [NSLayoutConstraint(
                        item: superview,
                        attribute: .centerX,
                        relatedBy: .equal,
                        toItem: _view,
                        attribute: .centerX,
                        multiplier: 1.0, constant: 0.0)]
                case .vertical:
                    _constraints += [NSLayoutConstraint(
                        item: superview,
                        attribute: .centerY,
                        relatedBy: .equal,
                        toItem: _view,
                        attribute: .centerY,
                        multiplier: 1.0,
                        constant: 0.0)]
                }
            }
            superview.addConstraints(_constraints)
            self.contraints += _constraints
            return self
        }
        
        @discardableResult internal func stack(_ atribute: UIView.Visual.Align, for views: [UIView], spacing: CGFloat = 8) -> Visual {
            switch atribute {
            case .horizontal:
                if views.count == 0 { return self }
                if views.count == 1 {
                    self._view.visual.format("H:|-(s)-[v0]-(s)-|", metrics: ["s": spacing], for: views)
                    return self
                }
                for (index, view) in views.enumerated() {
                    if index == 0 {
                        view.visual.anchor([.leading], padding: spacing)
                        continue
                    }
                    if index == views.count - 1 {
                        view.visual.anchor([.trailing], padding: spacing)
                        continue
                    }
                    self._view.visual.format("H:|-(s)-[v0]-(s)-[v1]-(s)-[v2]-(s)-|", metrics: ["s": spacing], for: [views[index - 1], view, views[index + 1]])
                }
                return self
            case .vertical:
                if views.count == 0 { return self }
                if views.count == 1 {
                    self._view.visual.format("V:|-(s)-[v0]-(s)-|", metrics: ["s": spacing], for: views)
                    return self
                }
                for (index, view) in views.enumerated() {
                    if index == 0 {
                        view.visual.anchor([.top], padding: spacing)
                        continue
                    }
                    if index == views.count - 1 {
                        view.visual.anchor([.bottom], padding: spacing)
                        continue
                    }
                    self._view.visual.format("V:|-(s)-[v0]-(s)-[v1]-(s)-[v2]-(s)-|", metrics: ["s": spacing], for: [views[index - 1], view, views[index + 1]])
                }
                return self
            }
        }
        
        @discardableResult internal func anchor(_ atributes: [UIView.Visual.Edge], padding: CGFloat = 8) -> Visual {
            guard let superview = self.superview else { return self }
            var _constraints: [NSLayoutConstraint] = []
            atributes.forEach { (atribute) in
                switch atribute {
                case .leading:
                    let views = ["view": _view]
                    let metrics = ["padding": padding]
                    let format = "H:|-(padding)-[view]"
                    let __constraints = NSLayoutConstraint.constraints(
                        withVisualFormat: format,
                        options: [],
                        metrics: metrics,
                        views: views
                    )
                    superview.addConstraints(__constraints)
                    _constraints += __constraints
                case .trailing:
                    let views = ["view": _view]
                    let metrics = ["padding": padding]
                    let format = "H:[view]-(padding)-|"
                    let __constraints = NSLayoutConstraint.constraints(
                        withVisualFormat: format,
                        options: [],
                        metrics: metrics,
                        views: views
                    )
                    superview.addConstraints(__constraints)
                    _constraints += __constraints
                case .top:
                    let views = ["view": superview]
                    let metrics = ["padding": padding]
                    let format = "V:|-(padding)-[view]"
                    let __constraints = NSLayoutConstraint.constraints(
                        withVisualFormat: format,
                        options: [],
                        metrics: metrics,
                        views: views
                    )
                    superview.addConstraints(__constraints)
                    _constraints += __constraints
                case .bottom:
                    let views = ["view": _view]
                    let metrics = ["padding": padding]
                    let format = "V:[view]-(padding)-|"
                    let __constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: metrics, views: views)
                    superview.addConstraints(__constraints)
                    _constraints += __constraints
                case .vertical:
                    let views = ["view": _view]
                    let metrics = ["padding": padding]
                    let format = "V:|-(padding)-[view]-(padding)-|"
                    let __constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: metrics, views: views)
                    superview.addConstraints(__constraints)
                    _constraints += __constraints
                case .horizontal:
                    let views = ["view": _view]
                    let metrics = ["padding": padding]
                    let format = "H:|-(padding)-[view]-(padding)-|"
                    let __constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: metrics, views: views)
                    superview.addConstraints(__constraints)
                    _constraints += __constraints
                }
            }
            superview.addConstraints(_constraints)
            self.contraints += _constraints
            return self
        }
        
        @discardableResult internal func format(_ format: String, metrics: [String: CGFloat] = [:], for views: [UIView]) -> Visual {
            var inViews: [String: UIView] = [:]
            for (index, item) in views.enumerated() {
                inViews["v\(index)"] = item
            }
            let _constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: metrics, views: inViews)
            _view.addConstraints(_constraints)
            self.contraints += _constraints
            return self
        }
        
        @discardableResult internal func equal(_ attribute: UIView.Visual.Size, fromView: UIView, toView: UIView ) -> Visual {
            switch attribute {
            case .height:
                let constraint = NSLayoutConstraint(item: fromView, attribute: .width, relatedBy: .equal, toItem: toView, attribute: .width, multiplier: 1.0, constant: 0.0)
                _view.addConstraint(constraint)
                self.contraints += [constraint]
                return self
            case .width:
                let constraint = NSLayoutConstraint(item: fromView, attribute: .width, relatedBy: .equal, toItem: toView, attribute: .width, multiplier: 1.0, constant: 0.0)
                _view.addConstraint(constraint)
                self.contraints += [constraint]
                return self
            }
        }
        
        @discardableResult internal func equal(_ attribute: UIView.Visual.Size, views: [UIView]) -> Visual {
            switch attribute {
            case .height:
                for (index, view) in views.enumerated() {
                    if index < views.count - 1 {
                        let constraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: views[index + 1], attribute: .height, multiplier: 1.0, constant: 0.0)
                        _view.addConstraint(constraint)
                        self.contraints += [constraint]
                    } else {
                        let constraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: views[0], attribute: .height, multiplier: 1.0, constant: 0.0)
                        _view.addConstraint(constraint)
                        self.contraints += [constraint]
                    }
                }
                return self
            case .width:
                for (index, view) in views.enumerated() {
                    if index < views.count - 1 {
                        let constraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: views[index + 1], attribute: .width, multiplier: 1.0, constant: 0.0)
                        _view.addConstraint(constraint)
                        self.contraints += [constraint]
                    } else {
                        let constraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: views[0], attribute: .width, multiplier: 1.0, constant: 0.0)
                        _view.addConstraint(constraint)
                        self.contraints += [constraint]
                    }
                }
                return self
            }
        }
        
        internal func square(_ attribute: UIView.Visual.Size, constant: CGFloat? = nil) {
            switch attribute {
            case .height:
                if let constant = constant {
                    let widthConstraint = NSLayoutConstraint(
                        item: _view,
                        attribute: NSLayoutConstraint.Attribute.height,
                        relatedBy: NSLayoutConstraint.Relation.equal,
                        toItem: nil,
                        attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                        multiplier: 1,
                        constant: constant
                    )
                    _view.addConstraint(widthConstraint)
                    self.contraints += [widthConstraint]
                }
                let constraint = NSLayoutConstraint(item: _view, attribute: .width, relatedBy: .equal, toItem: _view, attribute: .height, multiplier: 1.0, constant: 0.0)
                _view.addConstraint(constraint)
                self.contraints += [constraint]
            case .width:
                if let constant = constant {
                    let widthConstraint = NSLayoutConstraint(
                        item: _view,
                        attribute: NSLayoutConstraint.Attribute.width,
                        relatedBy: NSLayoutConstraint.Relation.equal,
                        toItem: nil,
                        attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                        multiplier: 1,
                        constant: constant
                    )
                    _view.addConstraint(widthConstraint)
                    self.contraints += [widthConstraint]
                }
                let constraint = NSLayoutConstraint(item: _view, attribute: .height, relatedBy: .equal, toItem: _view, attribute: .width, multiplier: 1.0, constant: 0.0)
                _view.addConstraint(constraint)
                self.contraints += [constraint]
            }
        }
        
        @discardableResult internal func size(_ atributes: [UIView.Visual.Size], constant: CGFloat) -> Visual {
            guard let superview = self.superview else { return self }
            var _constraints: [NSLayoutConstraint] = []
            atributes.forEach { (atribute) in
                switch atribute {
                case .height:
                    _constraints += superview.visual.format("V:[v0(h)]", metrics: ["h": constant], for: [_view]).contraints
                case .width:
                    _constraints += superview.visual.format("H:[v0(h)]", metrics: ["h": constant], for: [_view]).contraints
                }
            }
            self.contraints += _constraints
            return self
        }
        
    }
    
    var visual : Visual {
        get {
            return Visual(self)
        }
    }
}

//
extension UIView {
    
    @discardableResult
    internal func stack(_ views: UIView...) -> UIView {
        let contentView = UIView()
        self.addSubview(contentView)
        views.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.frame(width: 300, height: 300)
        contentView.visual.center([.horizontal, .vertical])
        self.visual.format("H:|-(>=0)-[v0]-(>=0)-|", for: [contentView])
        self.visual.format("V:|-(>=0)-[v0]-(>=0)-|", for: [contentView])
        contentView.visual.stack(.vertical, for: views, spacing: 0)
        views.forEach {
            $0.visual.center([.horizontal])
        }
        contentView.backgroundColor = .red
        return self
    }
    
    @discardableResult
    internal func padding(edges: [UIView.Visual.Edge] = [.leading, .trailing, .bottom, .top], length: CGFloat? = nil) -> UIView {
        self.visual.anchor(edges, padding: length ?? 8)
        return self
    }
    
    @discardableResult
    internal func padding(length: CGFloat) -> UIView {
        self.visual.anchor([.leading, .trailing, .bottom, .top], padding: length)
        return self
    }
}


// Frame
extension UIView {
    
    @discardableResult
    internal func frame(width: CGFloat) -> UIView {
        self.visual.size([.width], constant: width)
        return self
        
    }
    
    @discardableResult
    internal func frame(height: CGFloat) -> UIView {
        self.visual.size([.height], constant: height)
        return self
        
    }
    
    @discardableResult
    internal func frame(width: CGFloat, height: CGFloat) -> UIView {
        self.visual.size([.width], constant: width)
        self.visual.size([.height], constant: height)
        return self
        
    }
    
}

