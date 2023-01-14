//
//  CustomTabBarController.swift
//  finalProject
//
//  Created by Иван Евсеев on 13.01.2023.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var upperLineView: UIView!
    
    let spacing: CGFloat = 12

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            self.addTabbarIndicatorView(index: 0, isFirstTime: true)
        }
    }
    
    ///Add tabbar item indicator uper line
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false){
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
            return
        }
        if !isFirstTime{
            upperLineView.removeFromSuperview()
        }
        upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing, y: tabView.frame.minY + 0.1, width: tabView.frame.size.width - spacing * 2, height: 4))
        upperLineView.backgroundColor = UIColor(red: 0.231, green: 0.38, blue: 1, alpha: 1)
        tabBar.addSubview(upperLineView)
    }

}

extension CustomTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabbarIndicatorView(index: self.selectedIndex)
    }
}



