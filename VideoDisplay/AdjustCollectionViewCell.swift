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
