//
//  NavigationPresenter.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 9/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

class NavigationPresenter: NSObject {
    static func createNavigationBar(for viewController: UIViewController) {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "imgLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        button.setTitle("  \(String.get(key: "appName"))", for: .normal)
        button.titleLabel?.font = UIFont(name: "Futura", size: 16.0)
        button.setTitleColor(.white, for: .normal)
        button.isUserInteractionEnabled = false
        button.sizeToFit()
        
        let iconButton = UIBarButtonItem(customView: button)
        viewController.navigationItem.leftBarButtonItem = iconButton
        viewController.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 163.0/255.0, blue: 224.0/255.0, alpha: 1.0)
    }
}
