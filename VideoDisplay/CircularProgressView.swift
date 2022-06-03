//
//  CircularProgressView.swift
//  VideoDisplay
//
//  Created by đào sơn on 01/06/2022.
//

import Foundation
import UIKit
class CircularProgressView: UIView
{
    var shape = CAShapeLayer()
    
    init(frame: CGRect, shapeLayer: CAShapeLayer)
    {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.shape = shapeLayer
        self.layer.addSublayer(shape)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
    }
    
    override open func layoutSubviews() {
      super.layoutSubviews()
    }
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext()
        {
            let circlePath = UIBezierPath(arcCenter: self.center, radius: self.bounds.height/3, startAngle: .pi * 3/2, endAngle: .pi * -1/2, clockwise: false)
            shape.path = circlePath.cgPath
            shape.lineWidth = 2
            shape.strokeColor = UIColor.red.cgColor
            shape.fillColor = UIColor.clear.cgColor
            shape.strokeEnd = 1
        }
    }
}
