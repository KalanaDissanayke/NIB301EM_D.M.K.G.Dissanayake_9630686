//
//  CustomView.swift
//  D.M.K.G.Dissanayake-COBSCCOMP191P-007
//
//  Created by Kalana Dissanayake on 9/17/20.
//  Copyright © 2020 Kalana Dissanyake. All rights reserved.
//

import UIKit

class CustomView: UIView {

         override init(frame: CGRect) {
           super.init(frame: frame)
          setupView()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupView()
       }
       private func setupView() {
           layer.cornerRadius = frame.size.height/12
       }


}
