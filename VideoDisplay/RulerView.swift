//
//  RulerView.swift
//  VideoDisplay
//
//  Created by đào sơn on 27/05/2022.
//

import Foundation
import UIKit
class RulerView: UIView {

   public var contentOffset = CGFloat(1) {
      didSet {
         self.setNeedsDisplay()
      }
   }

   public var contentSize = CGFloat(0)

   let smallLineHeight = CGFloat(15)
   let bigLineHeight = CGFloat(20)


  override open func layoutSubviews() {
    super.layoutSubviews()
    self.backgroundColor = UIColor.clear
  }

  override func draw(_ rect: CGRect) {
 
     UIColor.white.set()
     let lineGap:CGFloat = 10
     let startIndex = Int(contentOffset/lineGap)
     let endIndex = Int((contentOffset + rect.width)/lineGap)
     let beginOffset = contentOffset - CGFloat(startIndex)*lineGap
    
     if let context = UIGraphicsGetCurrentContext() {
        for i in startIndex...endIndex {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: beginOffset + CGFloat(i - startIndex)*lineGap , y: i % 5 == 0 ? 0 : 4))
            path.addLine(to: CGPoint(x: beginOffset + CGFloat(i - startIndex)*lineGap, y: i % 5 == 0 ? bigLineHeight : smallLineHeight))
            path.lineWidth = i%5 == 0 ? 2 : 0.5
            path.stroke()

            
        }
    }
  }
}
