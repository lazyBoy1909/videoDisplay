//
//  AdjustCollectionViewCell.swift
//  VideoDisplay
//
//  Created by đào sơn on 26/05/2022.
//

import UIKit
class AdjustCollectionViewCell: UICollectionViewCell {
    let shape = CAShapeLayer()
    var itemImage: [UIImage?] = [UIImage(named: "adj1"), UIImage(named: "adj2"), UIImage(named: "adj3"), UIImage(named: "adj4"), UIImage(named: "adj5"), UIImage(named: "adj6"), UIImage(named: "adj7")]
    
    func createCircularProgressBar()
    {
        let circlePath = UIBezierPath(arcCenter: self.center, radius: self.bounds.height/3, startAngle: .pi * 3/2, endAngle: .pi * -1/2, clockwise: false)
        shape.path = circlePath.cgPath
        shape.lineWidth = 2
        shape.strokeColor = UIColor.red.cgColor
        shape.fillColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
        self.layer.addSublayer(shape)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCircularProgressBar()
    }
    func initAdjustCell(indexPath: IndexPath, itemValue: [Double])
    {
        if let image = itemImage[indexPath.row]
        {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 14, y: 14, width: self.bounds.width/2-5, height: self.bounds.height/2-5)
            imageView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            self.addSubview(imageView)
        }
        shape.strokeEnd = (CGFloat)(itemValue[indexPath.row]/100)
    }
    
    func updateItemStrokeEnd(newStrokenEndValue: Double)
    {
        self.shape.strokeEnd = newStrokenEndValue
    }
    
    func changeToImageDisplayState()
    {
        self.subviews.forEach
        {
            if($0 is UILabel)
            {
                $0.isHidden = true
            }
            else
            {
                $0.isHidden = false
            }
        }
    }
    func changeToNumberDisplayState(currentValue offset: Double)
    {
        var valueLabel = UILabel()
        var existedUILabelView: Bool = false
        for subview in self.subviews {
            if subview is UILabel {
                // existed a label
                subview.isHidden = false
                existedUILabelView = true
                valueLabel = subview as! UILabel
            }
            else
            {
                subview.isHidden = true
            }
        }
        
        //add value label to cell
        if(offset < 100)
        {
            valueLabel.frame = CGRect(x: 20, y: 14, width: self.bounds.width/2-8, height: self.bounds.height/2-8)
            valueLabel.font = UIFont(name: "Montserrat-Bold", size: 15)
        }
        else if(offset >= 100 && offset < 1000)
        {
            valueLabel.frame = CGRect(x: 16, y: 14, width: self.bounds.width/2-8, height: self.bounds.height/2-8)
            valueLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
        }
        else
        {
            valueLabel.frame = CGRect(x: 13, y: 11, width: self.bounds.width/2-2, height: self.bounds.height/2-2)
            valueLabel.font = UIFont(name: "Montserrat-Bold", size: 13)
        }
        let ratioValue: Int
        if(offset > 1000)
        {
            ratioValue = 100
        }
        else if(offset < 0)
        {
            ratioValue  = 0
        }
        else
        {
            ratioValue = (Int)(offset/10)
        }
        valueLabel.text = "\(ratioValue)"
        valueLabel.textColor = .white
        
        //if existed a label, then no need to add a new subview
        if(!existedUILabelView)
        {
            self.addSubview(valueLabel)
        }
        
    }
}
