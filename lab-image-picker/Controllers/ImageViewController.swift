//
//  ImageViewController.swift
//  lab-image-picker
//
//  Created by Levi Davis on 10/1/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit
import Photos

class ImageViewController: UIViewController {
    
    var image = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    
    var photoLibraryAccess = false

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func changeImageButtonPressed(_ sender: UIButton) {
        checkPhotoLibraryAccess()
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        imagePickerViewController.sourceType = .photoLibrary
        
        if photoLibraryAccess {
            present(imagePickerViewController, animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: "No Access", message: "Photo library access is required to use this app.", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction (title: "Ok", style: .default, handler: { UIAlertAction in
                self.photoLibraryAccess = true
                
                self.present(imagePickerViewController, animated: true, completion: nil)
            }))
            
            
            alertVC.addAction(UIAlertAction(title: "No", style: .destructive, handler: { UIAlertAction in
                self.photoLibraryAccess = false
                
            }))
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    private func checkPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            print(status)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({status in
                switch status {
                case .authorized:
                    self.photoLibraryAccess = true
                case .denied:
                    self.photoLibraryAccess = false
                case .notDetermined:
                    print("not determined")
                case .restricted:
                    print("restricted")
                @unknown default:
                    print("error")
                }
            })
        case .denied:
            let alertVC = UIAlertController(title: "Denied", message: "Photo album access is required to use this app. Please change your preference in settings", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction (title: "Ok", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        case .restricted:
            print("restricted")
        @unknown default:
            print("error")
        }
    }
    
}

extension ImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        self.image = image
        dismiss(animated: true, completion: nil)
    }
}
