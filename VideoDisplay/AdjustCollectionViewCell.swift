//
//  AdjustCollectionViewCell.swift
//  VideoDisplay
//
//  Created by đào sơn on 26/05/2022.
//

import UIKit
class AdjustCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var itemImageView: UIImageView!
    var circularProgressView: CircularProgressView!
    var countLabel: UILabel? = nil
    func createCircularProgressBar()
    {
        self.circularProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        self.addSubview(circularProgressView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCircularProgressBar()
    }
    func initAdjustCell(itemImageForCell imageCell: UIImage?)
    {
        if let image = imageCell
        {
            self.itemImageView.image = image
        }
    }
    
    func adjustCircularProgressBarItem(currentValue offset: Double)
    {
        if self.circularProgressView != nil
        {
            circularProgressView.updateStrokeEndValue(strokeEndValue: offset/1000)
        }
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
        for subview in self.subviews {
            if subview is UILabel {
                // existed a label
                subview.isHidden = false
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
        if(countLabel == nil)
        {
            self.addSubview(valueLabel)
        }
        else
        {
            countLabel = valueLabel
        }
        
    }
}
