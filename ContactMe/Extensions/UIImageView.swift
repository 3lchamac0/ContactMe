//
//  UIImageView.swift
//  ContactMe
//
//  Created by Javier Portaluppi on 24/11/2019.
//  Copyright © 2019 IPL-Master. All rights reserved.
//

import UIKit

extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}