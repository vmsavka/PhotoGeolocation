
//
//  StartScreenViewController.swift
//  PhotoGeolocation
//

import UIKit

class StartScreenViewController: UIViewController {
    
    @IBAction func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openSaveImage() {
        let imagePreviewViewController = UIStoryboard(name: "Geolocation", bundle: nil).instantiateViewController(withIdentifier: "\(ImagePreviewViewController.self)") as! ImagePreviewViewController
        imagePreviewViewController.image = UIImage(named: "1")
        
        self.present(imagePreviewViewController, animated: true, completion: nil)
    }
    
    @IBAction func openSaveVideo() {
        let videoPreviewViewController = UIStoryboard(name: "Geolocation", bundle: nil).instantiateViewController(withIdentifier: "\(VideoPreviewViewController.self)") as! VideoPreviewViewController
        videoPreviewViewController.videoName = "Concept"
        
        self.present(videoPreviewViewController, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension StartScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let imagePreviewViewController = UIStoryboard(name: "Geolocation", bundle: nil).instantiateViewController(withIdentifier: "\(ImagePreviewViewController.self)") as! ImagePreviewViewController
            imagePreviewViewController.image = pickedImage
            
            picker.pushViewController(imagePreviewViewController, animated: true)
        }
    }
}

