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

    @IBOutlet private weak var exitButton: UIButton!
    @IBOutlet private weak var okButton: UIButton!
    @IBOutlet private weak var itemCollectionView: UICollectionView!
    var delegate: AdjustViewDelegate?
    
    func initCollectionView()
    {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(UINib(nibName: "AdjustCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AdjustCollectionViewCell")
    }
    
    override func layoutSubviews() {
        exitButton.layer.cornerRadius = exitButton.bounds.width/2
        exitButton.clipsToBounds = true
        okButton.layer.cornerRadius = okButton.bounds.width/2
        okButton.clipsToBounds = true
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
    
}

