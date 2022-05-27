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
        let circlePath = UIBezierPath(arcCenter: self.center, radius: self.bounds.height/3, startAngle: .pi * 3/2, endAngle: .pi * -1/2, clockwise: false)
        shape.path = circlePath.cgPath
        shape.lineWidth = 2
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
            imageView.frame = CGRect(x: 14, y: 14, width: self.bounds.width/2-5, height: self.bounds.height/2-5)
            self.addSubview(imageView)
        }
    }
    
    func adjustCircularProgressBarItem(currentValue offset: Double)
    {
        shape.strokeEnd = offset/1000
    }
    
    func changeToNumberDisplayState(currentValue offset: Double)
    {
        self.subviews.forEach
        {
            $0.isHidden = true
        }
        let valueLabel = UILabel()
        if(offset < 100)
        {
            valueLabel.frame = CGRect(x: 20, y: 14, width: self.bounds.width/2-8, height: self.bounds.height/2-8)
            valueLabel.font = .systemFont(ofSize: 15)
        }
        else if(offset >= 100 && offset < 1000)
        {
            valueLabel.frame = CGRect(x: 16, y: 14, width: self.bounds.width/2-8, height: self.bounds.height/2-8)
            valueLabel.font = .systemFont(ofSize: 15)
        }
        else
        {
            valueLabel.frame = CGRect(x: 13, y: 11, width: self.bounds.width/2-2, height: self.bounds.height/2-2)
            valueLabel.font = .systemFont(ofSize: 13)
        }
        valueLabel.text = "\((Int)(offset/10))"
        valueLabel.textColor = .white
        self.addSubview(valueLabel)
    }
}
