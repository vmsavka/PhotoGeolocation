//
//  VideoPreviewViewController.swift
//  PhotoGeolocation
//

import UIKit
import AVKit
import MapKit

class VideoPreviewViewController: UIViewController {

    let photoAlbum = PhotoAlbum.sharedInstance
    var videoName: String? = nil
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addLocation() {
        let location = CLLocation(latitude:  40.730610, longitude: -73.935242)
        
        guard let path = Bundle.main.path(forResource: videoName, ofType:"m4v") else {
            debugPrint("video not found")
            return
        }
        photoAlbum.saveVideo(videoPath: path, creationDate: Date(), location: location)
        
        let filePathURL = NSURL.fileURL(withPath: path)
        let player = AVPlayer(url: filePathURL)
        player.rate = 0.67
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}
