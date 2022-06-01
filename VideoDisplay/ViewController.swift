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
    private weak var footerTabBar: FooterTabBar!
    private weak var adjustView: AdjustView!
    private var video: PHAsset!
    private var player: AVPlayer!
    var rulerView: RulerView = RulerView()
    var scrollView: UIScrollView = UIScrollView()
    var itemValue: [Double] = [100, 100, 100, 100, 100, 100, 100]
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
        footerTabBar.animHide()
        if let adjustView = Bundle.main.loadNibNamed("AdjustView", owner: self, options: nil)?.first as? AdjustView
        {
            self.adjustView = adjustView
            self.view.addSubview(adjustView)
            adjustView.delegate = self
            adjustView.itemValue = self.itemValue
            adjustView.translatesAutoresizingMaskIntoConstraints = false
            adjustView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200).isActive = true
            footerTabBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            footerTabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            footerTabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            adjustView.animShow()
        }
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
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    //play video again
    @objc func willEnterForeground()
    {
        if let continuePlayer = self.player
        {
            DispatchQueue.main.async {
                continuePlayer.seek(to: CMTime.zero)
                continuePlayer.play()
           }
        }
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
    func adjustViewScrollViewDidScroll(didScrollAtItemIndex index: Int, newValueAfterScroll newValue: Double) {
        self.itemValue[index] = newValue
    }
    
    func adjustViewOkButtonDidTap(_ sender: UIButton) {
        adjustView.animHide()
        footerTabBar.animShow()
    }
    
    func adjustViewExitButtonDidTap(_ sender: UIButton) {
        adjustView.animHide()
        footerTabBar.animShow()
    }
    
    
}

