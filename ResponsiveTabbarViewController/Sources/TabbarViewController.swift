//
//  TabbarViewController.swift
//  TabbarViewController
//
//  Created by Cao Phuoc Thanh on 5/27/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

public protocol TabbarViewControllerDataSource: class {
    func tabbarHeight() -> CGFloat
}

open class TabbarViewController: UIViewController {
    
    public weak var dataSource: TabbarViewControllerDataSource?
    
    // MARK: Public properties
    public var tabbarHeight: CGFloat = 60  {
        didSet{
            self.tabbarItemHeightConstraint?.constant = self.tabbarHeight
        }
    }
    
    var selectedViewController: UIViewController?
    
    public var tabbarItemSelectedColor: UIColor = UIColor.white.alpha(0.15)
    public var tabbarItemUnSelectedColor: UIColor = .clear
    
    public var backgroundColor: UIColor = UIColor("3C76FD")
    public var tabbarMaxHeight: CGFloat = 200
    public var tabbarMinHeight: CGFloat = 64
    
    public var tabbarItemHeight: CGFloat = 64
    
    public var viewControllers: [UIViewController] = [] {
        willSet {
            self.tabBarItemViews.forEach { $0.removeFromSuperview() }
            self.tabBarItemViews.removeAll()
        }
        didSet {
            self.draw()
        }
    }
    
    // MARK: private properties
    private var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var menuPanView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Constrait contant
    private var tabbarItemHeightConstraint: NSLayoutConstraint?
    
    private var tabbarView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var tabBarItemViews: [TabBarItemView] = []
    
    private func draw() {
        self.drawTabbarItemView()
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            self.setConstraintTabbarItemLeftView()
        } else {
            self.setConstraintTabbarItemBottomView()
        }
    }
    
    private var constraintMenuView: [NSLayoutConstraint] = []
    private func setconstraintMenuViewInLeft() {
        self.tabbarView.removeConstraints(constraintMenuView)
        constraintMenuView += self.tabbarView.visual.format("H:|-8-[v0]-0-|",for: [menuView]).contraints
        constraintMenuView += self.tabbarView.visual.format("V:|-(>=0)-[v0]-(>=0)-|",for: [menuView]).contraints
        constraintMenuView += self.menuView.visual.center([.vertical]).contraints
        UIView.animate(withDuration: 0.0) { self.tabbarView.layoutIfNeeded() }
    }
    
    private func setconstraintMenuViewInBottom() {
        self.tabbarView.removeConstraints(constraintMenuView)
        constraintMenuView += self.tabbarView.visual.format("H:|-(>=0)-[v0(>=0)]-(>=0)-|",for: [menuView]).contraints
        constraintMenuView += self.tabbarView.visual.format("V:|-4-[v0(>=h)]",
            metrics: ["h": self.tabbarHeight - 8],
            for: [menuView]).contraints
        constraintMenuView += self.menuView.visual.center([.horizontal]).contraints
        UIView.animate(withDuration: 0.0) { self.tabbarView.layoutIfNeeded() }
    }
    
    private func setConstraintTabbarItemBottomView() {
        self.menuView.removeConstraints(constraintTabbarItemView)
        let metrics = ["h": self.tabbarItemHeight]
        guard tabBarItemViews.count > 0  else { return }
        guard tabBarItemViews.count > 1 else {
            constraintTabbarItemView += self.menuView.visual.format("V:|-0-[v0(h)]",
                                                                    metrics: metrics,
                                                                    for: [tabBarItemViews[0]]).contraints
            constraintTabbarItemView += self.menuView.visual.format("H:|-0-[v0]-0-|",
                                                                    for: [tabBarItemViews[0]]).contraints
            return
        }
        guard tabBarItemViews.count > 2 else {
            constraintTabbarItemView += self.menuView.visual.format("V:|-0-[v0(h)]",
                                                                    metrics: metrics,
                                                                    for: [tabBarItemViews[0]]).contraints
            constraintTabbarItemView += self.menuView.visual.format("V:|-0-[v0(h)]",
                                                                    metrics: metrics,
                                                                    for: [tabBarItemViews[1]]).contraints
            constraintTabbarItemView += self.menuView.visual.format("H:|-0-[v0]-0-[v1]-0-|",
                                                                    metrics: metrics,
                                                                    for: [tabBarItemViews[0],
                                                                          tabBarItemViews[0]]).contraints
            return
        }
        for (index, tabBarItemView) in tabBarItemViews.enumerated() {
            constraintTabbarItemView += self.menuView.visual.format("V:|-0-[v0(h)]",
                                                                    metrics: metrics,
                                                                    for: [tabBarItemView]).contraints
            if index == 0 {
                constraintTabbarItemView += self.menuView.visual.format("H:|-0-[v0]-0-[v1]",
                                                                        metrics: metrics,
                                                                        for: [tabBarItemView,
                                                                              tabBarItemViews[index + 1]]).contraints
            }
            else if index == tabBarItemViews.count - 1 {
                constraintTabbarItemView += self.menuView.visual.format("H:[v0]-0-|",
                                                                        metrics: metrics,
                                                                        for: [tabBarItemView]).contraints
            }
            else {
                constraintTabbarItemView += self.menuView.visual.format("H:[v0]-0-[v1]",
                                                                        metrics: metrics,
                                                                        for: [tabBarItemView,
                                                                              tabBarItemViews[index + 1]]).contraints
            }
        }
    }
    
    private var constraintTabbarItemView: [NSLayoutConstraint] = []
    private func setConstraintTabbarItemLeftView() {
        self.menuView.removeConstraints(constraintTabbarItemView)
        let metrics = ["h": self.tabbarItemHeight]
        guard tabBarItemViews.count > 0  else { return }
        guard tabBarItemViews.count > 1 else {
            constraintTabbarItemView += self.menuView.visual.format("H:|-0-[v0]-0-|",
                                                                    for: [tabBarItemViews[0]]).contraints
            constraintTabbarItemView += self.menuView.visual.format("V:|-0-[v0(h)]-0-|",
                                                                    metrics: metrics,
                                                                    for: [tabBarItemViews[0]]).contraints
            return
        }
        guard tabBarItemViews.count > 2 else {
            constraintTabbarItemView += self.menuView.visual.format("H:|-0-[v0]-0-|",
                                                                    for: [tabBarItemViews[0]]).contraints
            constraintTabbarItemView += self.menuView.visual.format("H:|-0-[v0]-0-|",
                                                                    for: [tabBarItemViews[1]]).contraints
            constraintTabbarItemView += self.menuView.visual.format("V:|-0-[v0(h)]-0-[v1(h)]-0-|",
                                                                    metrics: metrics,
                                                                    for: [tabBarItemViews[0],
                                                                          tabBarItemViews[0]]).contraints
            return
        }
        for (index, tabBarItemView) in tabBarItemViews.enumerated() {
            constraintTabbarItemView += self.menuView.visual.format("H:|-0-[v0]-0-|",
                                                                    for: [tabBarItemView]).contraints
            if index == 0 {
                constraintTabbarItemView += self.menuView.visual.format("V:|-0-[v0(h)]-0-[v1(h)]",
                                                                        metrics: metrics,
                                                                        for: [tabBarItemView,
                                                                              tabBarItemViews[index + 1]]).contraints
            }
            else if index == tabBarItemViews.count - 1 {
                constraintTabbarItemView += self.menuView.visual.format("V:[v0(h)]-0-|",
                                                                        metrics: metrics,
                                                                        for: [tabBarItemView]).contraints
            }
            else {
                constraintTabbarItemView += self.menuView.visual.format("V:[v0(h)]-0-[v1(h)]",
                                                                        metrics: metrics,
                                                                        for: [tabBarItemView,
                                                                              tabBarItemViews[index + 1]]).contraints
            }
        }
        
    }
    
    private func drawTabbarItemView() {
        for viewController in viewControllers {
            guard let tabBarItem = viewController.tabBarItem else { continue }
            let tabbar: TabBarItemView = {
                let view = TabBarItemView(tabBarItem: tabBarItem)
                view.title = tabBarItem.title
                view.image = tabBarItem.image
                view.backgroundColor = tabbarItemUnSelectedColor
                view.layer.masksToBounds = true
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            self.menuView.addSubview(tabbar)
            self.tabBarItemViews.append(tabbar)
        }
        for tabBarItemView in tabBarItemViews {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tabBarItemViewTouchUpInsideDidTap(_:)))
            tabBarItemView.addGestureRecognizer(tap)
        }
        if let tabBarItemView = tabBarItemViews.first {
            tabBarItemView.backgroundColor = tabbarItemSelectedColor
            let controllers: [UIViewController] = self.viewControllers.filter {
                tabBarItemView.tabBarItem == $0.tabBarItem
            }
            guard let viewVC = controllers.first?.view else { return }
            self.contentView.subviews.forEach {
                $0.removeFromSuperview()
            }
            self.selectedViewController = controllers.first
            self.contentView.addSubview(viewVC)
            viewVC.visual.anchor([.horizontal, .vertical], padding: 0)
        }
        for (index, tabBarItemView) in tabBarItemViews.enumerated() {
            if index < tabBarItemViews.count - 1 {
                menuView.visual.equal(.width, views: [tabBarItemView,tabBarItemViews[index + 1]])
            } else {
                menuView.visual.equal(.width, views: [tabBarItemView,tabBarItemViews[0]])
            }
        }
    }
    
    @objc private func tabBarItemViewTouchUpInsideDidTap(_ sender: UITapGestureRecognizer) {
        guard let tabBarItemView = sender.view as? TabBarItemView else { return}
        self.tabBarItemViews.forEach {
            $0.backgroundColor = tabbarItemUnSelectedColor
        }
        tabBarItemView.backgroundColor = tabbarItemSelectedColor
        let controllers: [UIViewController] = self.viewControllers.filter {
            tabBarItemView.tabBarItem == $0.tabBarItem
        }
        guard let viewVC = controllers.first?.view else { return }
        self.selectedViewController = controllers.first
        self.contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
        self.contentView.addSubview(viewVC)
        viewVC.visual.anchor([.horizontal, .vertical], padding: 0)
    }
    
    // MARK: Life circle
    
    open override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
    }
    
    override open func loadView() {
        super.loadView()
        
        self.view.backgroundColor = backgroundColor
        
        self.view.addSubview(tabbarView)
        self.view.addSubview(menuPanView)
        self.view.addSubview(contentView)
        self.tabbarView.addSubview(menuView)
                
        menuPanView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragView)))
        print("loadView:", self.view.bounds)
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            print("loadView isLandscape")
            addConstraintMenuViewLeftState()
            setconstraintMenuViewInLeft()
        } else {
            print("loadView isPortrait")
            addConstraintMenuViewBottomState()
            setconstraintMenuViewInBottom()
        }
    }
    
    
    private var constraintMenuViewLeftState: [NSLayoutConstraint] = []
    private func addConstraintMenuViewLeftState() {
        
        self.view.removeConstraints(constraintMenuViewLeftState)
        self.view.removeConstraints(constraintMenuViewBottomState)
        
        constraintMenuViewLeftState += self.view.visual.format("V:|-0-[v0]-0-|",
                                                               for: [tabbarView]).contraints
        constraintMenuViewLeftState += self.view.visual.format("H:|-0-[v0]",
                                                               for: [tabbarView]).contraints
        let visual = self.view.visual.format("H:[v0(h)]",
                                             metrics: ["h": self.dataSource?.tabbarHeight() ?? self.tabbarHeight],
                                             for: [tabbarView])
        constraintMenuViewLeftState += visual.contraints
        self.tabbarItemHeightConstraint = visual.contraints.first
        
        constraintMenuViewLeftState += self.view.visual.format("V:|-0-[v0]-0-|",
                                                               for: [menuPanView]).contraints
        constraintMenuViewLeftState += self.view.visual.format("H:[v0]-0-[v1(20)]",
                                                               for: [tabbarView, menuPanView]).contraints
        
        //let safeArea = view.safeAreaInsets
        constraintMenuViewLeftState += self.view.visual.format("V:|-0-[v0]-0-|",
                                                               for: [contentView]).contraints
        constraintMenuViewLeftState += self.view.visual.format("H:[v0]-0-[v1]-0-|",
                                                               for: [menuPanView, contentView]).contraints
    }
    
    private var constraintMenuViewBottomState: [NSLayoutConstraint] = []
    private func addConstraintMenuViewBottomState() {
        
        self.view.removeConstraints(constraintMenuViewBottomState)
        self.view.removeConstraints(constraintMenuViewLeftState)
        
        constraintMenuViewBottomState += self.view.visual.format("H:|-0-[v0]-0-|",
                                                                 for: [tabbarView]).contraints
        constraintMenuViewBottomState += self.view.visual.format("V:[v0]-|",
                                                                 for: [tabbarView]).contraints
        let visual = self.view.visual.format("V:[v0(h)]",
                                             metrics: ["h": self.dataSource?.tabbarHeight() ?? self.tabbarHeight],
                                             for: [tabbarView])
        constraintMenuViewBottomState += visual.contraints
        self.tabbarItemHeightConstraint = visual.contraints.first
        
        constraintMenuViewBottomState += self.view.visual.format("H:|-0-[v0]-0-|",
                                                                 for: [menuPanView]).contraints
        constraintMenuViewBottomState += self.view.visual.format("V:[v0(0)]-0-[v1]",
                                                                 for: [menuPanView, tabbarView]).contraints
        
        constraintMenuViewBottomState += self.view.visual.format("H:|-0-[v0]-0-|",
                                                                 for: [contentView]).contraints
        constraintMenuViewBottomState += self.view.visual.format("V:|-0-[v0]-0-[v1]",
                                                                 for: [contentView, menuPanView]).contraints
    }
    
    var beganConstant: CGFloat = 0
    @objc func dragView(gesture: UIPanGestureRecognizer) {
        guard UIDevice.current.orientation.isLandscape else { return }
        let translation = gesture.translation(in: self.view)
        let constant = self.beganConstant +  translation.x
        switch gesture.state {
        case .began:
            self.beganConstant = self.tabbarItemHeightConstraint!.constant
        case .changed:
            if constant <= self.tabbarMinHeight { return }
            if constant >= self.tabbarMaxHeight { return }
            self.tabbarItemHeightConstraint!.constant = constant
            self.view.layoutIfNeeded()
        case .ended:
            if constant < self.tabbarMaxHeight/2 {
                self.tabbarItemHeightConstraint!.constant = self.tabbarMinHeight
            }
            if constant > self.tabbarMaxHeight/2 {
                self.tabbarItemHeightConstraint!.constant = self.tabbarMaxHeight
            }
            self.view.layoutIfNeeded()
        default: break
        }
    }
    
    // Solution detect rotate: https://stackoverflow.com/a/60577486/3619521
    override open func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)

        coordinator.animate(alongsideTransition: { (context) in
            guard let windowInterfaceOrientation = self.windowInterfaceOrientation else { return }

            if windowInterfaceOrientation.isLandscape {
                            print("isLandscape", UIDevice.current.orientation.isLandscape)
                self.addConstraintMenuViewLeftState()
                self.setConstraintTabbarItemLeftView()
                self.setconstraintMenuViewInLeft()
            } else {
                         print("isPortrait", UIDevice.current.orientation.isLandscape)
                   self.addConstraintMenuViewBottomState()
                   self.setConstraintTabbarItemBottomView()
                   self.setconstraintMenuViewInBottom()
            }
        })
    }

    private var windowInterfaceOrientation: UIInterfaceOrientation? {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
    }
    
//    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        print("viewWillTransition:", self.view.bounds)
//        if size.width > self.view.frame.size.width {
//            print("isLandscape", UIDevice.current.orientation.isLandscape)
//            addConstraintMenuViewLeftState()
//            setConstraintTabbarItemLeftView()
//            setconstraintMenuViewInLeft()
//        } else {
//            print("isPortrait", UIDevice.current.orientation.isLandscape)
//            addConstraintMenuViewBottomState()
//            setConstraintTabbarItemBottomView()
//            setconstraintMenuViewInBottom()
//        }
//    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
