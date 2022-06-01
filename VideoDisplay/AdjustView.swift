//
//  AdjustView.swift
//  VideoDisplay
//
//  Created by đào sơn on 26/05/2022.
//

import UIKit

protocol AdjustViewDelegate
{
    func adjustViewExitButtonDidTap(_ sender: UIButton)
    func adjustViewOkButtonDidTap(_ sender: UIButton)
    func adjustViewScrollViewDidScroll(didScrollAtItemIndex index: Int,newValueAfterScroll newValue: Double)
}

class AdjustView: UIView {

    @IBOutlet private weak var rulerScrollView: UIScrollView!
    @IBOutlet private weak var exitButton: UIButton!
    @IBOutlet private weak var okButton: UIButton!
    @IBOutlet private weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLeadingConstraint: NSLayoutConstraint!
    var itemValue: [Double]!
    var delegate: AdjustViewDelegate?
    var currentItem: Int = 2
    var currentValue: Double = 100
    func initCollectionView()
    {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(UINib(nibName: "AdjustCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AdjustCollectionViewCell")
    }
    
    func initRulerScrollView()
    {
        rulerScrollView.delegate = self
        //disable vertical scrolling
        rulerScrollView.contentSize = CGSize(width: 1365 , height: 1)
        let rulerView = RulerView(frame: CGRect(x: 0, y: 0, width: 1365, height: rulerScrollView.frame.size.height))
        rulerView.backgroundColor = .blue
        rulerScrollView.addSubview(rulerView)
        rulerScrollView.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        exitButton.layer.cornerRadius = exitButton.bounds.width/2
        exitButton.clipsToBounds = true
        okButton.layer.cornerRadius = okButton.bounds.width/2
        okButton.clipsToBounds = true
        initCollectionView()
        initRulerScrollView()
    }

    func updateItemValue()
    {
        for index in 0...6
        {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = itemCollectionView.cellForItem(at: indexPath) as? AdjustCollectionViewCell
            {
                itemValue[index] = cell.shape.strokeEnd*100
                print(itemValue[index])
            }
        }
    }

    @IBAction func exitButtonTapped(_ sender: UIButton) {
        delegate?.adjustViewExitButtonDidTap(sender)
    }
    @IBAction func okButtonTapped(_ sender: UIButton) {
        
        delegate?.adjustViewOkButtonDidTap(sender)
        updateItemValue()
    }
}

extension AdjustView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: "AdjustCollectionViewCell", for: indexPath) as! AdjustCollectionViewCell
        cell.initAdjustCell(indexPath: indexPath, itemValue: itemValue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemCollectionView.bounds.height - 5, height: itemCollectionView.bounds.height - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentItem = indexPath.row
        if let cell = self.itemCollectionView.cellForItem(at: IndexPath(row: currentItem, section: 0)) as? AdjustCollectionViewCell
        {
            cell.changeToNumberDisplayState(currentValue: Double(itemValue[indexPath.row]))
        }
        for index in 0...6
        {
            if(index != currentItem)
            {
                if let cell = self.itemCollectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? AdjustCollectionViewCell
                {
                    cell.changeToImageDisplayState()
                }
            }
        }
        let positionX = (indexPath.row - 3)*65 + 55
        itemCollectionView.setContentOffset( CGPoint(x: positionX,y: 0), animated:true )
    }
}

extension AdjustView: UIScrollViewDelegate
{
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        itemValue[currentItem] = offset
        print(offset)
        if let cell = self.itemCollectionView.cellForItem(at: IndexPath(row: currentItem, section: 0)) as? AdjustCollectionViewCell
        {
            cell.updateItemStrokeEnd(newStrokenEndValue: offset/1000)
            cell.changeToNumberDisplayState(currentValue: offset)
        }
        self.delegate?.adjustViewScrollViewDidScroll(didScrollAtItemIndex: self.currentItem, newValueAfterScroll: offset/10)

    }
}
