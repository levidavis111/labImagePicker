//
//  ImageViewController.swift
//  lab-image-picker
//
//  Created by Levi Davis on 10/1/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var image = UIImage() {
        didSet {
            imageView.image = image
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func changeImageButtonPressed(_ sender: UIButton) {
        
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
