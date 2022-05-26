//
//  AdjustCollectionViewCell.swift
//  VideoDisplay
//
//  Created by đào sơn on 26/05/2022.
//

import UIKit
class AdjustCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var itemContentView: UIView!
    let shape = CAShapeLayer()
    var itemImage: [UIImage?] = [UIImage(named: "adj1"), UIImage(named: "adj2"), UIImage(named: "adj3"), UIImage(named: "adj4"), UIImage(named: "adj5"), UIImage(named: "adj6"), UIImage(named: "adj7")]
    
    func createCircularProgressBar()
    {
        let circlePath = UIBezierPath(arcCenter: self.center, radius: self.bounds.height/3, startAngle: 0, endAngle: .pi*2, clockwise: true)
        shape.path = circlePath.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.red.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 1
        self.layer.addSublayer(shape)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCircularProgressBar()
    }
    func initAdjustCell(indexPath: IndexPath)
    {
        if let image = itemImage[indexPath.row]
        {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 14.5, y: 14.5, width: contentView.bounds.width/2-5, height: contentView.bounds.height/2-5)
            contentView.addSubview(imageView)
        }
    }
}
