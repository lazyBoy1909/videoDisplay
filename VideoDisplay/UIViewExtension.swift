//
//  UIViewExtension.swift
//  VideoDisplay
//
//  Created by đào sơn on 26/05/2022.
//

import Foundation
import UIKit
extension UIView{
    func animShow(){
        UIView.animate(withDuration: 0.25, animations: {
            self.isHidden = false
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    func animHide(){
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
        })
    }
}
