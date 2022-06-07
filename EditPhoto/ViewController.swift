//
//  ViewController.swift
//  EditPhoto
//
//  Created by Life on 6/6/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    
    let context = CIContext()
    var original: UIImage?
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func applySepia() {
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        display(filter:filter!)
        
    }
    
    @IBAction func applyNoir() {
        
            if  original == nil  {
                return
            }
        
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter: filter!)

    }
    
    @IBAction func applyVintage() {
        
        if original == nil {
            return
        }
    
    let filter = CIFilter(name: "CIPhotoEffectProcess")
    display(filter: filter!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
    }
    
    func display( filter: CIFilter){
        filter.setValue(CIImage(image: original!), forKey: kCIInputImageKey)
        let output = filter.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }

}

