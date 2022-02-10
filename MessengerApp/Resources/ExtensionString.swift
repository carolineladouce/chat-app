//
//  ExtensionString.swift
//  MessengerApp
//
//  Created by Caroline LaDouce on 2/9/22.
//

import Foundation
import UIKit

extension String {
    
    func emojiToImage() -> UIImage? {
            let size = CGSize(width: 30, height: 35)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            UIColor.white.set()
            let rect = CGRect(origin: CGPoint(), size: size)
            UIRectFill(rect)
            (self as AnyObject).draw(in: rect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)])
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
    
}
