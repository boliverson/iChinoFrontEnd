//
//  Extensions.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 2/23/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension String {
    
    var boolValue: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
    
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
    
    func dbFormatDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        let dateString = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: dateString!)
    }
    
    func toDate()-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'" //"1994-10-28T08:55:00Z"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        let date = dateFormatter.date(from: self)
        
        return date
    }
    
}

extension UIViewController{
    
    func startActivityIndicator(blur: UIVisualEffectView, ai: UIActivityIndicatorView) -> Void {
        blur.frame = view.bounds
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        ai.center = blur.center
        ai.alpha = 0.0
        blur.alpha = 0.0
        view.addSubview(blur)
        view.addSubview(ai)
        
        ai.startAnimating()
        UIView.animate(withDuration: 0.3) {
            blur.alpha = 1.0
            ai.alpha = 1.0
        }
    }
    
    func stopActivityIndicator(blur: UIVisualEffectView, ai: UIActivityIndicatorView) -> Void{
        UIView.animate(withDuration: 0.25, animations: {
            blur.alpha = 0.0
            ai.alpha = 0.0
        }, completion: { finished in
            ai.stopAnimating()
            blur.removeFromSuperview()
            ai.removeFromSuperview()
        })
    }
}

extension Notification.Name {
    static let userDownloadedNotification = Notification.Name("UserDownloadedNotification")
    static let eventAllActiveDownloadedNotification = Notification.Name("EventAllActiveDownloadedNotification")
    static let competitionsForEventDownloadedNotification = Notification.Name("CompetitionsForEventDownloadedNotification")
}


