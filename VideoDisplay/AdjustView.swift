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
}

class AdjustView: UIView {

    @IBOutlet private weak var rulerScrollView: UIScrollView!
    @IBOutlet private weak var exitButton: UIButton!
    @IBOutlet private weak var okButton: UIButton!
    @IBOutlet private weak var itemCollectionView: UICollectionView!
    var delegate: AdjustViewDelegate?
    var currentItem: Int = 0
    var currentValue: Double = 0
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

    @IBAction func exitButtonTapped(_ sender: UIButton) {
        delegate?.adjustViewExitButtonDidTap(sender)
    }
    @IBAction func okButtonTapped(_ sender: UIButton) {
        delegate?.adjustViewOkButtonDidTap(sender)
    }
}

extension AdjustView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: "AdjustCollectionViewCell", for: indexPath) as! AdjustCollectionViewCell
        cell.initAdjustCell(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemCollectionView.bounds.height - 5, height: itemCollectionView.bounds.height - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentItem = indexPath.row
        if let cell = self.itemCollectionView.cellForItem(at: IndexPath(row: currentItem, section: 0)) as? AdjustCollectionViewCell
        {
            cell.changeToNumberDisplayState(currentValue: currentValue)
        }
    }
}

extension AdjustView: UIScrollViewDelegate
{
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        currentValue = offset
        print(offset)
        if let cell = self.itemCollectionView.cellForItem(at: IndexPath(row: currentItem, section: 0)) as? AdjustCollectionViewCell
        {
            cell.adjustCircularProgressBarItem(currentValue: offset)
        }
    }
}
