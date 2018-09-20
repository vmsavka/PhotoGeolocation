//
//  PhotoAlbum.swift
//  PhotoGeolocation
//

import UIKit
import Photos

class PhotoAlbum {
    
    static let albumName = "Wristcam"
    static let sharedInstance = PhotoAlbum()
    var album: PHAssetCollection!
    typealias ImageCallback = ((UIImage) -> Void)
    
    init() {
        createAlbum()
    }
    
    func createAlbum() {
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "title = %@", PhotoAlbum.albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album,
                                                                 subtype: .any,
                                                                 options: options)
        if let album = collection.firstObject {
            self.album = album
        }
        
        var placeholder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: PhotoAlbum.albumName)
            placeholder = request.placeholderForCreatedAssetCollection
        },
                                               completionHandler: { (success, error) -> Void in
            if success {
                if let id = placeholder?.localIdentifier {
                    let fetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [id],
                                                                              options: nil)
                    if let album = fetchResult.firstObject {
                        self.album = album
                    }
                }
            }
        })
    }
    
    func saveImage(image: UIImage) {
        if self.album == nil {
            return
        }
        
        PHPhotoLibrary.shared().performChanges({
            let assetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.album)
            guard let assetPlaceholder = assetRequest.placeholderForCreatedAsset else { return }
            let assetPlaceholders: NSArray = [assetPlaceholder]
            albumChangeRequest?.addAssets(assetPlaceholders)
        }, completionHandler: nil)
    }
    
    func saveImageWithProperties(image: UIImage, creationDate: Date? = Date(), location: CLLocation?) {
        if self.album == nil {
            return
        }
        
        PHPhotoLibrary.shared().performChanges({
            let assetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            assetRequest.creationDate = creationDate
            assetRequest.location = location
            
            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.album)
            guard let assetPlaceholder = assetRequest.placeholderForCreatedAsset else { return }
            let assetPlaceholders: NSArray = [assetPlaceholder]
            albumChangeRequest?.addAssets(assetPlaceholders)
        }, completionHandler: nil)
    }
    
    func deleteAssets(asset: PHAsset) {
        PHPhotoLibrary.shared().performChanges ({
            let assets: NSArray = [asset]
            PHAssetChangeRequest.deleteAssets(assets as NSFastEnumeration)
        }, completionHandler: nil)
    }
    
    func editAssetPreferences() {
        
    }
    
    func imageForAsset(asset: PHAsset, size: CGSize, imageCallback: @escaping ImageCallback) {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: size,
                                              contentMode: .aspectFill,
                                              options: PHImageRequestOptions()) { (image, _) -> Void in
                                                if let img = image {
                                                    imageCallback(img)
                                                }
        }
    }
    
    // Video
    func saveVideo(videoPath: String, creationDate: Date? = Date(), location: CLLocation? = nil) {
        var placeHolder : PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            
            let creationRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(string: videoPath)!)
            creationRequest?.creationDate = creationDate
            creationRequest?.location = location
            
            placeHolder = creationRequest?.placeholderForCreatedAsset
            
        }, completionHandler: { (success, error) in
            if success {
                let result = PHAsset.fetchAssets(withLocalIdentifiers: [placeHolder!.localIdentifier], options: nil)
                //result.firstObject?.getURL(completionHandler: { url in
                    
                    // this is the url to the saved asset
                    
               // })
            }
        })
    }
}
