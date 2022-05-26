//
//  TabBarCollectionViewCell.swift
//  VideoDisplay
//
//  Created by đào sơn on 23/05/2022.
//

import UIKit

class TabBarCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initCell(cellItem: UIImage)
    {
        imageView.image = cellItem
    }
}
