//
//  FooterTabBar.swift
//  VideoDisplay
//
//  Created by đào sơn on 23/05/2022.
//

import UIKit

protocol FooterTabBarDelegate: AnyObject
{
    func footerTabBarDidSelectItem(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

class FooterTabBar: UIView {
    weak var delegate: FooterTabBarDelegate?
    let tabBarItem = [UIImage(named: "Canvas"), UIImage(named: "Trim"), UIImage(named: "Speed"), UIImage(named: "Add more"), UIImage(named: "Effect"), UIImage(named: "Filter"), UIImage(named: "Sticker"), UIImage(named: "Text"), UIImage(named: "Frame"), UIImage(named: "Background"), UIImage(named: "Painting"), UIImage(named: "Adjust"), UIImage(named: "Reorder")]
                                                        
                    
    @IBOutlet weak var tabBarCollectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        tabBarCollectionView.register(UINib(nibName: "TabBarCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "TabBarCollectionViewCell")
        tabBarCollectionView.delegate = self
        tabBarCollectionView.dataSource = self
    }
}
extension FooterTabBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabBarCollectionView.dequeueReusableCell(withReuseIdentifier: "TabBarCollectionViewCell", for: indexPath) as! TabBarCollectionViewCell
        cell.initCell(cellItem: tabBarItem[indexPath.row]!)
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 61, height: self.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.footerTabBarDidSelectItem(self.tabBarCollectionView, didSelectItemAt: indexPath)
    }
}
