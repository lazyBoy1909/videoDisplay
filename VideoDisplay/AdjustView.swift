//
//  AdjustView.swift
//  VideoDisplay
//
//  Created by đào sơn on 26/05/2022.
//

import UIKit

class AdjustView: UIView {

    @IBOutlet private weak var exitButton: UIButton!
    @IBOutlet private weak var okButton: UIButton!
    override func layoutSubviews() {
        exitButton.layer.cornerRadius = exitButton.bounds.height/2
        okButton.layer.cornerRadius = okButton.bounds.height/2
    }

}
