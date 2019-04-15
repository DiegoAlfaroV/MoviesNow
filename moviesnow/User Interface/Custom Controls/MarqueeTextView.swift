//
//  MarqueeTextView.swift
//  moviesnow
//
//  Created by Macbook Pro on 4/15/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

class MarqueeTextView: UITextView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func animate() {
        scrollToBottom()
    }
    
    func scrollToBottom() {
        let bottom = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom
        
        UIView.animate(withDuration: 5.0, delay: 5.0, options: .curveEaseIn, animations: {
            self.setContentOffset(CGPoint(x: 0, y: bottom), animated: false)
        }) { complete in
            self.scrollToTop()
        }
    }
    
    func scrollToTop() {
        UIView.animate(withDuration: 5.0, delay: 5.0, options: .curveEaseIn, animations: {
            self.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }) { complete in
            self.scrollToBottom()
        }
    }
}
