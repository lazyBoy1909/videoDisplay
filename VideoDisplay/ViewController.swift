//
//  ViewController.swift
//  VideoDisplay
//
//  Created by đào sơn on 23/05/2022.
//

import UIKit
import Photos
import AVKit
class ViewController: UIViewController {

    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var videoImageView: UIView!
    private weak var footerTabBar: FooterTabBar?
    private weak var adjustView: AdjustView?
    private var video: PHAsset!
    private var player: AVPlayer!
    var itemImage: [UIImage?] = [UIImage(named: "adj1"), UIImage(named: "adj2"), UIImage(named: "adj3"), UIImage(named: "adj4"), UIImage(named: "adj5"), UIImage(named: "adj6"), UIImage(named: "adj7")]
    func addGradientForScreen()
    {
        let bottomGradientLayer = CAGradientLayer()
        bottomGradientLayer.frame = videoImageView.frame
        bottomGradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        bottomGradientLayer.locations = [0.75, 1.0]
        
        let topGradientLayer = CAGradientLayer()
        topGradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 88)
        topGradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        topGradientLayer.locations = [0, 1]

        videoImageView.layer.insertSublayer(bottomGradientLayer, at: 0)
        videoImageView.layer.insertSublayer(topGradientLayer, at: 0)
    }


    // MARK: get video from Bundle.main
    func getRandomVideoFromLibrary()
    {
        if let randomVideo = PHAsset.loadRandomPHAssetVideosFromGallery()
        {
            video = randomVideo
            randomVideo.getAVAsset()
            {
                (assetResult) in
                DispatchQueue.main.async
                {
                    //Create AVPlayer object
                    if let asset = assetResult
                    {
                        let playerItem = AVPlayerItem(asset: asset)
                        self.player = AVPlayer(playerItem: playerItem)
                        
                        //Create AVPlayerLayer object
                        let playerLayer = AVPlayerLayer(player: self.player)
                        playerLayer.frame = self.videoImageView.bounds //bounds of the view in which AVPlayer should be displayed
                        
                        playerLayer.videoGravity = .resizeAspect
                        
                        //Add playerLayer to view's layer
                        self.videoImageView.layer.insertSublayer(playerLayer, at: 0)
                        
                        //Play Video
                        self.player.play()
                        NotificationCenter.default.addObserver(self,
                                         selector: #selector(self.playerEndedPlaying(_:)),
                            name: .AVPlayerItemDidPlayToEndTime,
                            object: nil)
                    }
                    else
                    {
                        print("Failed to get AVAsset from PHAsset")
                    }
                }
            }
        }
        else
        {
            print("Library has no videos to display!")
        }
    }
    // MARK: replay video
    @objc func playerEndedPlaying(_ notification: Notification) {
        DispatchQueue.main.async { 
            self.player.seek(to: CMTime.zero)
            self.player.play()
       }
    }
    // MARK: create footer tab bar
    func createFooterView()
    {
        if let footerTabBar = Bundle.main.loadNibNamed("FooterTabBar", owner: self, options: nil)?.first as? FooterTabBar
        {
            self.view.addSubview(footerTabBar)
            self.footerTabBar = footerTabBar
            footerTabBar.backgroundColor = .clear
            footerTabBar.delegate = self
            footerTabBar.translatesAutoresizingMaskIntoConstraints = false
            footerTabBar.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -96).isActive = true
            footerTabBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            footerTabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            footerTabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        }
        else
        {
            print("Failed to load footer view")
        }
    }
    
    func adjustViewAppear()
    {
        animHide(viewMove: footerTabBar!)
        if let adjustView = Bundle.main.loadNibNamed("AdjustView", owner: self, options: nil)?.first as? AdjustView
        {
            self.adjustView = adjustView
            adjustView.itemImage = self.itemImage
            self.view.addSubview(adjustView)
            adjustView.delegate = self
            adjustView.translatesAutoresizingMaskIntoConstraints = false
            adjustView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200).isActive = true
            footerTabBar!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            footerTabBar!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            footerTabBar!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            animShow(viewMove: adjustView)
        }
    }
    
    func animShow(viewMove : UIView){
        UIView.animate(withDuration: 0.25, animations: {
            viewMove.isHidden = false
            viewMove.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    func animHide(viewMove : UIView){
        UIView.animate(withDuration: 0.25, animations: {
            viewMove.transform = CGAffineTransform(translationX: 0, y: viewMove.bounds.height + 200)
        })
    }
    
    func initBasicGUI()
    {
        saveButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.29)
        saveButton.layer.cornerRadius = 4
        createFooterView()
        addGradientForScreen()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initBasicGUI()
        getRandomVideoFromLibrary()
    }
    

    // MARK: save button tapped
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: show pop up to user
    func showAlert()
    {
        let alert = UIAlertController(title: "Notification", message: "Coming soon", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

}

// MARK: FooterTabBarDelegate
extension ViewController: FooterTabBarDelegate
{
    func footerTabBarDidSelectItem(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row
        {
        case 11: adjustViewAppear()
        default: showAlert()
        }
    }
}

// MARK: AdjustViewDelegate
extension ViewController: AdjustViewDelegate
{
    func adjustViewOkButtonDidTap(_ sender: UIButton) {
        animHide(viewMove: adjustView!)
        animShow(viewMove: footerTabBar!)
    }
    
    func adjustViewExitButtonDidTap(_ sender: UIButton) {
        animHide(viewMove: adjustView!)
        animShow(viewMove: footerTabBar!)
    }
    
    
}

