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
    var countLabel: UILabel = UILabel()
    func createCircularProgressBar()
    {
        self.circularProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        self.addSubview(circularProgressView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCircularProgressBar()
        self.addSubview(countLabel)
    }
    func initAdjustCell(itemImageForCell imageCell: UIImage?, cellStrokenEndValue cellValue: Double)
    {
        if let image = imageCell
        {
            self.itemImageView.image = image
        }
        self.circularProgressView.shape.strokeEnd = cellValue/100
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
        itemImageView.isHidden = false
        countLabel.isHidden = true
        
    }
    func changeToNumberDisplayState(currentValue offset: Double)
    {
        countLabel.isHidden = false
        itemImageView.isHidden = true
        //add value label to cell
        if(offset < 100)
        {
            countLabel.frame = CGRect(x: 20, y: 14, width: self.bounds.width/2-8, height: self.bounds.height/2-8)
            countLabel.font = UIFont(name: "Montserrat-Bold", size: 15)
        }
        else if(offset >= 100 && offset < 1000)
        {
            countLabel.frame = CGRect(x: 16, y: 11, width: self.bounds.width/2, height: self.bounds.height/2)
            countLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
        }
        else
        {
            countLabel.frame = CGRect(x: 11, y: 10, width: self.bounds.width/2+3, height: self.bounds.height/2+3)
            countLabel.font = UIFont(name: "Montserrat-Bold", size: 13)
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
        countLabel.text = "\(ratioValue)"
        countLabel.textColor = .white
        
    }
}
