//
//  DialogPresenter.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 9/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit
import MBProgressHUD

class DialogPresenter: NSObject {
    static func showDialog(in viewController: UIViewController, message: String) {
        let alert: UIAlertController = UIAlertController(title: String.get(key: "appName"), message: message, preferredStyle: .alert)
        
        let action: UIAlertAction = UIAlertAction(title: String.get(key: "ok"), style: .default) { (_) in
        }
        alert.addAction(action)
        
        viewController.present(alert, animated: true) { }
    }
    
    static func showLoading(in view: UIView?) {
        if let loadingView = view {
            let dialog = MBProgressHUD(view: loadingView)
            dialog.label.textColor = UIColor.black
            dialog.bezelView.color = UIColor.white
            dialog.backgroundColor = UIColor(white: 0.0, alpha: 0.25)
            dialog.animationType = .fade
            dialog.label.text = String.get(key:"loading")
            dialog.show(animated: true)
            loadingView.addSubview(dialog)
        } else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    static func hideLoading(in view: UIView?) {
        if let loadingView = view {
            MBProgressHUD.hide(for: loadingView, animated: true)
        } else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
