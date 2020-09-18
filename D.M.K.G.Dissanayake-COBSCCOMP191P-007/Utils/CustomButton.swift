//
//  File.swift
//  D.M.K.G.Dissanayake-COBSCCOMP191P-007
//
//  Created by Kalana Dissanayake on 9/17/20.
//  Copyright © 2020 Kalana Dissanyake. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
 
     override init(frame: CGRect) {
            super.init(frame: frame)
           setupButton()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupButton()
        }
        private func setupButton() {
            layer.cornerRadius = frame.size.height/4
        }
    }

