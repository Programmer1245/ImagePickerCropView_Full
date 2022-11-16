# CropPicker_Image

[![CI Status](https://img.shields.io/travis/pikachu987/CropPickerView.svg?style=flat)](https://travis-ci.org/pikachu987/CropPickerView)
[![Version](https://img.shields.io/cocoapods/v/CropPickerView.svg?style=flat)](https://cocoapods.org/pods/CropPickerView)
[![Platform](https://img.shields.io/cocoapods/p/CropPickerView.svg?style=flat)](https://cocoapods.org/pods/CropPickerView)
![](https://img.shields.io/badge/Supported-iOS16.1%20%7C%20OSX%2016.1-4BC51D.svg?style=flat-square)
![](https://img.shields.io/badge/Swift-5.7.1-orange.svg?style=flat)



<br/>

# CropPicker_Image

|-|-|
|---|---|
|<img src='./Image sample/1.gif' width='400px'>|<img src='./Image sample/2.gif' width='400px'>|

|-|-|
|---|---|
|<img src='./Image sample/3.gif' width='400px'>|<img src='./Image sample/4.gif' width='400px'>|

## Introduce

The Corner and Side buttons allow you to modify the position of the crop and UIScrollView to zoom the image. If the image is larger than the area of the UIScrollView, the image can be scrolled up and down, left and right, and if the image is smaller than the area of the UIScrollView, the image is always centered.

### [CropPickerController](https://github.com/Murad9288/Cropicker_Image)

If you want to see the CropPickerViewController that is created with CropView, see [CropPickerController](https://github.com/Murad9288/Cropicker_Image)

<br/>



## Requirements

`CropPickerView` written in Swift 5.0. Compatible with iOS 8.0+

## Installation

CropPickerView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CropPickerView'
```

## Usage


### Xib or Storyboard file

setting

 <img src="./Image sample/st.png" />
 
 
 <img src="./Image sample/st1.png" />

done!

<br><br><br>

### Code editor

```swift
import CropPickerView
```

```swift
let cropPickerView = CropPickerView()
self.view.addSubview(cropPickerView)
```

done!

<br><br><br>



### Property

image

```swift

cropPickerView.image = image
cropPickerView.image(image, crop: CGRect(x: 50, y: 30, width: 100, height: 80), isRealCropRect: false)
cropPickerView.image(image, crop: CGRect(x: 50, y: 30, width: 100, height: 80), isRealCropRect: true)
cropPickerView.image(image, isMin: false, crop: CGRect(x: 50, y: 30, width: 100, height: 80), isRealCropRect: true)
cropPickerView.image(image, isMin: false)

```

color

```swift

cropPickerView.cropLineColor = UIColor.gray
cropPickerView.scrollBackgroundColor = UIColor.gray
cropPickerView.imageBackgroundColor = UIColor.gray
cropPickerView.dimBackgroundColor = UIColor(white: 0, alpha: 0.1)

```

zoom

```swift

cropPickerView.scrollMinimumZoomScale = 1
cropPickerView.scrollMaximumZoomScale = 2

```

radius

```swift

cropPickerView.radius = 50

```

aspectRatio (~~square~~)

```swift

// free
cropPickerView.aspectRatio = 0

// square
cropPickerView.aspectRatio = 1

// width : height = 1 : 2
cropPickerView.aspectRatio = 1 / 2

// width : height = 3 : 4
cropPickerView.aspectRatio = 3 / 4

// width : height = 4 : 3
cropPickerView.aspectRatio = 4 / 3

```

cropSize

```swift

cropPickerView.cropMinSize = 200

```

<br><br>

### Method

crop

```swift

cropPickerView.crop { (result) in
    if let error = (result.error as NSError?) {
        let alertController = UIAlertController(title: "Error", message: error.domain, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        return
    }
    self.imageView.image = result.image
}

```

<br><br>

### Delegate

```swift

class ViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()

        let cropPickerView = CropPickerView()
        cropPickerView.delegate = self
    }
}

// MARK: CropPickerViewDelegate
extension ViewController: CropPickerViewDelegate {
    func cropPickerView(_ cropPickerView: CropPickerView, result: CropResult) {

    }

    func cropPickerView(_ cropPickerView: CropPickerView, didChange frame: CGRect) {
        print("frame: \(frame)")
    }
}

```

