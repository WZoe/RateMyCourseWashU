//
//  AlertBanner.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/30/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class AlertBanner: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(text: String, width: CGFloat) {
        let banner = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 200))
        banner.backgroundColor = UIColor.white
        banner.alpha = 0.8
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: width, height: 150))
        label.text = text
        label.textAlignment = .center
        banner.addSubview(label)
        
        UIView.transition(with: self, duration: 1.0, options: .transitionFlipFromTop, animations: {
            self.addSubview(banner)
        }, completion: nil)
    }

}
