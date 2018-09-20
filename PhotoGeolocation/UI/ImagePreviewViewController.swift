//
//  ImagePreviewViewController.swift
//  PhotoGeolocation
//

import UIKit
import Photos

class ImagePreviewViewController: UIViewController {
    
    var image: UIImage!
    @IBOutlet weak var previewImageView: UIImageView!
    let photoAlbum = PhotoAlbum.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewImageView.image = image
    }

    @IBAction func addLocation() {
        photoAlbum.saveImage(image: image)
    }
}
