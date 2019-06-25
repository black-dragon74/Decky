//
//  UIView+Snapshot.swift
//  Decky
//
//  Created by Nick on 6/25/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

extension UIView {
    func takeSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
