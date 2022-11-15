//Copyright (c) 11/11/2022 < muradhossainm01@gmail.com>
//
//  NSLayoutConstraint+.swift
//  CropPickerView
//
//

import UIKit

extension NSLayoutConstraint {
    func priority(_ value: CGFloat) -> NSLayoutConstraint {
        priority = UILayoutPriority(Float(value))
        return self
    }
}
