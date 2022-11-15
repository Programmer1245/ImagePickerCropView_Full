//
//  ViewController.swift
//  CropPickerView
//
//  Created by MD Murad Hossain on 11/11/2022.
//
//

import UIKit
import CropPickerView

class ViewController: UIViewController {
    @IBOutlet private weak var cropContainerView: UIView!
    @IBOutlet private weak var radianSlider: UISlider!
    @IBOutlet private weak var ratioSegment: UISegmentedControl!

    @IBOutlet private weak var resultImageView: UIImageView!
    //@IBOutlet private weak var resultLabel: UILabel!
    
    private let cropPickerView: CropPickerView = {
        let cropPickerView = CropPickerView()
        cropPickerView.translatesAutoresizingMaskIntoConstraints = false
        cropPickerView.backgroundColor = .black
        return cropPickerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //addGesture()
        
        self.cropContainerView.addSubview(self.cropPickerView)

        self.cropContainerView.addConstraints([
            NSLayoutConstraint(item: self.cropContainerView!, attribute: .top, relatedBy: .equal, toItem: self.cropPickerView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.cropContainerView!, attribute: .bottom, relatedBy: .equal, toItem: self.cropPickerView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.cropContainerView!, attribute: .leading, relatedBy: .equal, toItem: self.cropPickerView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.cropContainerView!, attribute: .trailing, relatedBy: .equal, toItem: self.cropPickerView, attribute: .trailing, multiplier: 1, constant: 0)
        ])

        self.cropPickerView.delegate = self
        
        DispatchQueue.main.async {
            self.cropPickerView.image(UIImage(named: "21.png"))
        }
        
        //        self.cropPickerView.image = image
        //        self.cropPickerView.image(image, crop: CGRect(x: 50, y: 30, width: 100, height: 80), isRealCropRect: false)
        //        self.cropPickerView.image(image, crop: CGRect(x: 50, y: 30, width: 100, height: 80), isRealCropRect: true)
        //        self.cropPickerView.image(image, isMin: false, crop: CGRect(x: 50, y: 30, width: 100, height: 80), isRealCropRect: true)
        //        self.cropPickerView.image(image, isMin: false)
        //    }
        //
        //    private func addGesture(){
        //        let pinchGestute = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        //        cropContainerView.addGestureRecognizer(pinchGestute)
        //    }
        //
        //    @objc private func didPinch(_ gesture: UIPinchGestureRecognizer) {
        //        if gesture.state == .changed {
        //            let scale = gesture.scale
        //            let frame = cropContainerView.frame
        //            cropContainerView.frame = CGRect(x: 0, y: 0, width: frame.width * scale, height: frame.height * scale)
        //            cropContainerView.center = view.center
        //        }
        //    }
        //
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let button = UIButton(type: .system)
        button.setTitle("Picture", for: .normal)
        button.addTarget(self, action: #selector(self.albumTap(_:)), for: .touchUpInside)
        self.navigationItem.titleView = button

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.cropTap(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshTap(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction private func radianValueChanged(_ sender: UISlider) {
        self.cropPickerView.radius = CGFloat(sender.value)
    }

    @IBAction private func ratioValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.cropPickerView.aspectRatio = 0
        } else if sender.selectedSegmentIndex == 1 {
            self.cropPickerView.aspectRatio = 1
        } else if sender.selectedSegmentIndex == 2 {
            self.cropPickerView.aspectRatio = 1/2
        } else if sender.selectedSegmentIndex == 3 {
            self.cropPickerView.aspectRatio = 3/4
        } else if sender.selectedSegmentIndex == 4 {
            self.cropPickerView.aspectRatio = 4/3
        }
    }
    
    @objc func cropTap(_ sender: UIBarButtonItem) {
        self.cropPickerView.crop { (crop) in
            self.resultImageView.image = crop.image
            
//            MARK: custom crop image size label showing
            
//            //self.resultLabel.text = ""
//            if let error = (crop.error as NSError?) {
//                self.resultLabel.text?.append("-error\n\(error.localizedDescription)(\(error.code))")
//            }
//            if let value = crop.cropFrame {
//                if self.resultLabel.text != "" {
//                    self.resultLabel.text?.append("\n\n")
//                }
//                self.resultLabel.text?.append("-crop frame\n\(value)")
//            }
//            if let value = crop.realCropFrame {
//                if self.resultLabel.text != "" {
//                    self.resultLabel.text?.append("\n\n")
//                }
//                self.resultLabel.text?.append("-real crop frame\n\(value)")
//            }
//            if let value = crop.imageSize {
//                if self.resultLabel.text != "" {
//                    self.resultLabel.text?.append("\n\n")
//                }
//                self.resultLabel.text?.append("-before image size\n\(value)")
//            }
            
            
        }
    }
    
    @objc func albumTap(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Album", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.mediaTypes = ["public.image"]
                pickerController.sourceType = .photoLibrary
                self.present(pickerController, animated: true, completion: nil)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.mediaTypes = ["public.image"]
                pickerController.sourceType = .camera
                self.present(pickerController, animated: true, completion: nil)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        self.present(alertController, animated: true, completion: nil)
    }

    @objc func refreshTap(_ sender: UIBarButtonItem) {
        let image = UIImage(named: "\(Int.random(in: 21...29)).png")
        self.cropPickerView.image(image)
    }
}

// MARK: CropPickerViewDelegate
extension ViewController: CropPickerViewDelegate {
    func cropPickerView(_ cropPickerView: CropPickerView, result: CropResult) {

    }

    func cropPickerView(_ cropPickerView: CropPickerView, didChange frame: CGRect) {
        
        
//        MARK: custom crop result label call

        //self.resultLabel.text = "\(frame)"
        
        
        let sliderValue = self.radianSlider.value
        self.radianSlider.maximumValue = frame.width > frame.height ? Float(frame.height / 2) : Float(frame.width / 2)
        if self.radianSlider.maximumValue < sliderValue {
            self.radianSlider.value = self.radianSlider.maximumValue
            self.cropPickerView.radius = CGFloat(self.radianSlider.value)
        }
    }
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else { return }
        self.cropPickerView.image(image)
    }
}
