//
//  TabBarItemView.swift
//  TabbarViewController
//
//  Created by Cao Phuoc Thanh on 5/28/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

internal class TabBarItemView: View {
    
    enum ContentState {
        case icon
        case iconAndImage
    }
    
    let imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textLabel: UILabel = {
       let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(tabBarItem: UITabBarItem) {
        super.init(frame: CGRect.zero)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.tabBarItem = tabBarItem
        self.title = tabBarItem.title
        self.image = tabBarItem.image
    }
    
    override func setupViews() {
        super.setupViews()
        self.addSubview(imageView)
        self.addSubview(textLabel)
    }
    
    private var _constraints: [NSLayoutConstraint] = []
    override func setupConstraints() {
        super.setupConstraints()
        setupAnyConstraints()
    }
    
    private func addFullConstraint() {
        self.removeConstraints(_constraints)
        _constraints += self.visual.format("H:|-8-[v0(18)]-8-[v1]-4-|", for: [imageView, textLabel]).contraints
        _constraints += self.visual.format("V:[v0(22)]", for: [imageView]).contraints
        _constraints += self.imageView.visual.center([.vertical]).contraints
        _constraints += self.visual.format("V:|-4-[v0]-4-|", for: [textLabel]).contraints
    }
    
    private func addOnlyImageConstraint() {
        self.removeConstraints(_constraints)
        _constraints += self.visual.format("H:|-(>=0)-[v0(18)]-(>=0)-|", for: [imageView]).contraints
        _constraints += self.visual.format("V:|-(>=0)-[v0(18)]-(>=0)-|", for: [imageView]).contraints
        _constraints += self.imageView.visual.center([.vertical, .horizontal]).contraints
    }
    
    private func addOnlyImageTextPortraitConstraint() {
        self.removeConstraints(_constraints)
        _constraints += self.visual.format("H:|-(>=0)-[v0(18)]-(>=0)-|", for: [imageView]).contraints
        
        _constraints += self.visual.format("H:|-(>=0)-[v0]-(>=0)-|", for: [textLabel]).contraints
        
        _constraints += self.visual.format("V:|-(>=0)-[v0(18)]-(>=0)-|", for: [imageView]).contraints
        _constraints += self.imageView.visual.center([.horizontal]).contraints
        _constraints += self.textLabel.visual.center([.horizontal]).contraints
        _constraints += self.visual.format("V:|-(>=8)-[v0(18)]-[v1]-(>=8)-|", for: [imageView, textLabel]).contraints
    }
    
    var contentState: ContentState = .iconAndImage
    
    private func setupAnyConstraints() {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            // print("bounds:", self.bounds, UIScreen.main.bounds)
            if self.bounds.width <= self.bounds.height + 20 {
                self.textLabel.isHidden = true
                self.addOnlyImageConstraint()
                contentState = .iconAndImage
            } else {
                self.textLabel.isHidden = false
                self.addFullConstraint()
                contentState = .icon
            }
        } else {
            self.textLabel.isHidden = false
            self.addOnlyImageTextPortraitConstraint()
        }
        UIView.animate(withDuration: 0.0) {
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAnyConstraints()
    }
    
    var tabBarItem: UITabBarItem!
    
    var title: String? {
        didSet{
            self.textLabel.text = title
        }
    }
        
    var image: UIImage? {
        didSet{
            self.imageView.image = image
        }
    }
}
