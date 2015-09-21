//
//  Created by Kateryna Gridina.
//  Copyright (c) gridNA. All rights reserved.
//  Latest version can be found at https://github.com/gridNA/GNAContextMenu
//

import UIKit

public class GNAMenuItem: UIView {
    public var titleLabel: UILabel!
    public var titleView: UIView!
    public var itemId: String?
    public var angle: CGFloat!
    
    private var menuIcon: UIImageView!
    private var titleText: String?
    private var activeMenuIcon: UIImageView?
    
    public convenience init(icon: UIImage!, activeIcon: UIImage?, title: String?) {
        let frame = CGRectMake(0, 0, 55, 55)
        self.init(icon: icon, activeIcon: activeIcon, title: title, frame: frame)
    }
    
    public init(icon: UIImage!, activeIcon: UIImage?, title: String?, frame: CGRect) {
        super.init(frame: frame)
        menuIcon = createMenuIcon(icon)
        activeMenuIcon = createMenuIcon(activeIcon == nil ? icon : activeIcon)
        createLabel(title)
        activate(shouldActivate: false)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLabel(title: String?) {
        if let itemTitle = title {
            titleText = itemTitle
            titleView = UIView()
            titleLabel = UILabel()
            if #available(iOS 8.2, *) {
                titleLabel.font = UIFont.systemFontOfSize(11, weight: 1)
            } else {
                titleLabel.font = UIFont.systemFontOfSize(11)
            }
            titleLabel.textColor = UIColor.whiteColor()
            titleLabel.textAlignment = .Center
            setupLabel()
            titleView.backgroundColor = UIColor.blackColor()
            titleView.alpha = 0.7
            titleView.layer.cornerRadius = 5
            titleView.addSubview(titleLabel)
            self.addSubview(titleView)
        }
    }
    
    private func setupLabel() {
        if let title = titleText {
            titleLabel.text = title
            titleLabel.sizeToFit()
            titleView.frame = CGRect(origin: CGPointZero, size: CGSize(width: titleLabel.frame.width + 6, height: titleLabel.frame.height))
            titleLabel.center = CGPoint(x: titleView.frame.width/2, y: titleView.frame.height/2)
        }
    }
    
    private func createMenuIcon(menuIconImage: UIImage) -> UIImageView {
        let iconView = UIImageView(image: menuIconImage)
        iconView.frame = self.bounds
        iconView.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubview(iconView)
        return iconView
    }
    
    private func showHideTitle(hiddenState: Bool) {
        if let titleView = titleView {
            titleView.hidden = hiddenState
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: {
                titleView.center = CGPoint(x: self.frame.width/2, y: -self.titleLabel.frame.height)
            }, completion: nil)
        }
    }
    
    public func activate(shouldActivate shouldActivate: Bool) {
        menuIcon.hidden = shouldActivate
        activeMenuIcon?.hidden = !shouldActivate
        showHideTitle(!shouldActivate)
    }
    
    public func createCustomLabel(label: UILabel) {
        if let _ = titleText {
            titleLabel = label
            setupLabel()
        }
    }
    
    public func changeTitle(newTitle newTitle: String) {
        titleLabel.text = newTitle
    }
    
    public func changeIcon(newIcon newIcon: UIImage) {
        menuIcon.image = newIcon
    }
    
    public func changeActiveIcon(newActiveIcon newActiveIcon: UIImage) {
        activeMenuIcon?.image = newActiveIcon
    }
}
