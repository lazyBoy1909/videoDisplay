//
//  ViewController.swift
//  VideoDisplay
//
//  Created by đào sơn on 23/05/2022.
//

import UIKit
import Photos
class ViewController: UIViewController {

    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var videoImageView: UIImageView!
    private weak var footerTabBar: FooterTabBar!
    private var video: PHAsset!
    
    
    func addGradientForScreen()
    {
        let gradient1 = CAGradientLayer()
        gradient1.frame = videoImageView.frame
        gradient1.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient1.locations = [0.75, 1.0]
        
        let gradient2 = CAGradientLayer()
        gradient2.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: headerView.bounds.height)
        gradient2.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient2.locations = [0, 0.8]

        videoImageView.layer.insertSublayer(gradient1, at: 0)
        headerView.layer.insertSublayer(gradient2, at: 0)
    }
    // MARK: full screen mode
    func onModeFullScreen()
    {
        self.footerTabBar.changeToFullScreenMode()
        headerView.backgroundColor = .clear
        addGradientForScreen()
    }
    
    // MARK: fit screen mode
    func onModeFitScreen()
    {
        self.footerTabBar.changeToFitScreenMode()
        headerView.backgroundColor = .black
    }
    // MARK: get video from Bundle.main
    func getRandomVideoFromLibrary()
    {
        if let randomVideo = PHAsset.loadRandomPHAssetVideosFromGallery()
        {
            video = randomVideo
            print("the height of video is \(video.pixelHeight)")
            print("the width of video is \(video.pixelWidth)")
            print("the height of screen is \(self.view.bounds.height)")
            print("the width of screen is \(self.view.bounds.width)")
            let videoHeight = video.pixelHeight
            let videoWidth = video.pixelWidth
            let screenHeight = (Int)(self.view.bounds.height)
            let screenWidth = (Int)(self.view.bounds.width)
            if videoHeight > screenHeight && videoWidth > screenWidth
            {
                onModeFullScreen()
            }
            else
            {
                onModeFitScreen()
            }
            videoImageView.image = video.fetchImage(widthSize: 1000, heightSize: 1000, contentMode: .aspectFit)
        }
        else
        {
            print("Library has no videos to display!")
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
    
    func initBasicGUI()
    {
        saveButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.29)
        saveButton.layer.cornerRadius = 4
        createFooterView()
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
    func footerTabBar(_ footerView: UIView) {
        showAlert()
    }
    
    
}

