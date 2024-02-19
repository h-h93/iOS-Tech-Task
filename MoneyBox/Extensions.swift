//
//  Extensions.swift
//  invoiceApp
//
//  Created by hanif hussain on 06/01/2024.
//

import Foundation
import UIKit


extension UIView {
    // add a drop shadow (using rasterization for efficiency)
    func dropShadow(scale: Bool = true, shadowRadius: CGFloat = 10, colour: CGColor = UIColor.black.cgColor) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowRadius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

extension UIColor {
    // return a random colour
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1), 
                       green: .random(in: 0.4...1),
                       blue: .random(in: 0.4...1),
                       alpha: 1)
    }
    // convert hex to rgb
    public convenience init?(hex: String) {
            let r, g, b, a: CGFloat

            if hex.hasPrefix("#") {
                let start = hex.index(hex.startIndex, offsetBy: 1)
                let hexColor = String(hex[start...])

                if hexColor.count == 8 {
                    let scanner = Scanner(string: hexColor)
                    var hexNumber: UInt64 = 0

                    if scanner.scanHexInt64(&hexNumber) {
                        r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                        g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                        b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                        a = CGFloat(hexNumber & 0x000000ff) / 255

                        self.init(red: r, green: g, blue: b, alpha: a)
                        return
                    }
                }
            }

            return nil
        }
}


extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension UITableView {
    /// Reloads a table view without losing track of what was selected.
    func reloadDataSavingSelections() {
        let selectedRows = indexPathsForSelectedRows
        
        reloadData()
        
        if let selectedRow = selectedRows {
            for indexPath in selectedRow {
                selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }
}

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 44.0)))
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    internal func addBottomBorder(height: CGFloat = 1.0, color: UIColor = .black) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)
        NSLayoutConstraint.activate(
            [
                borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                borderView.heightAnchor.constraint(equalToConstant: height)
            ]
        )
    }
    
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}

extension Date {
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var startOfMonth: Date {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return  calendar.date(from: components)!
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
    
    func makeDatePredicate(startDate: Date, endDate: Date) -> NSPredicate {
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        
        let formattedStartDate = formatter.date(from: formatter.string(from: startDate))
        let formattedEndDate = formatter.date(from: formatter.string(from: endDate))
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        var startComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: formattedStartDate!)
        var endComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: formattedEndDate!)
        
        startComponents.hour = 00
        startComponents.minute = 00
        startComponents.second = 00
        let startDate = calendar.date(from: startComponents)
        
        endComponents.hour = 23
        endComponents.minute = 59
        endComponents.second = 59
        let endDate = calendar.date(from: endComponents)

        
        // change predicate date to day, timestamp or anything else relating to the attribute in your core data entity
        return NSPredicate(format: "date >= %@ AND date <= %@", argumentArray: [startDate!, endDate!])
    }
    
    func makeTimestampPredicate(startDate: Date, endDate: Date) -> NSPredicate {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        var startComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate)
        var endComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: endDate)
        startComponents.hour = 00
        startComponents.minute = 00
        startComponents.second = 00
        let startDate = calendar.date(from: startComponents)
        endComponents.hour = 23
        endComponents.minute = 59
        endComponents.second = 59
        let endDate = calendar.date(from: endComponents)
        
        // 2024-01-07 16:30:03 +0000
        // 2024-01-07 16:30:03 +0000
        
        // change predicate date to day, timestamp or anything else relating to the attribute in the core data entity
        return NSPredicate(format: "timestamp >= %@ AND timestamp <= %@", argumentArray: [startDate!, endDate!])
    }

}

extension String {

    var isValidName: Bool {
        // check if minimum 7 characters and maximum 16 characters long
       let RegEx = "^\\w{7,16}$"
       let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
       return Test.evaluate(with: self)
    }
    
    // check if email is valid
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // basic check to see if password is valid
    func isValidPassword(_ password: String) -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol -- removed for money box as test user doesn't have special character in pword
        //  min 8 characters total
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
    }
    
    func colorString(text: String?, coloredText: String?, color: UIColor? = .red) -> String {
        
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!],
                                       range: range)
        let text = attributedString.string
        return text
    }
}

extension UIImage {
    
    var roundMyImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
        ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    func compressImage(image: UIImage) -> UIImage {
        let actualHeight:CGFloat = image.size.height
            let actualWidth:CGFloat = image.size.width
            let imgRatio:CGFloat = actualWidth/actualHeight
            let maxWidth:CGFloat = 1024.0
            let resizedHeight:CGFloat = maxWidth/imgRatio
            let compressionQuality:CGFloat = 0.5
            
            let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
            UIGraphicsBeginImageContext(rect.size)
            image.draw(in: rect)
            let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            let imageData:Data = img.jpegData(compressionQuality: compressionQuality)!
            UIGraphicsEndImageContext()
            
            return UIImage(data: imageData)!
    }
    
    func resize(_ max_size: CGFloat) -> UIImage {
            // adjust for device pixel density
            let max_size_pixels = max_size / UIScreen.main.scale
            // work out aspect ratio
            let aspectRatio =  size.width/size.height
            // variables for storing calculated data
            var width: CGFloat
            var height: CGFloat
            var newImage: UIImage
            if aspectRatio > 1 {
                // landscape
                width = max_size_pixels
                height = max_size_pixels / aspectRatio
            } else {
                // portrait
                height = max_size_pixels
                width = max_size_pixels * aspectRatio
            }
            // create an image renderer of the correct size
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: UIGraphicsImageRendererFormat.default())
            // render the image
            newImage = renderer.image {
                (context) in
                self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            }
            // return the image
            return newImage
        }
    
    func resizeToTabbarImageSize(scale: CGFloat = 1.0) -> UIImage {
        let targetSize = CGSize(width: 30.0 * scale, height: 30.0 * scale) // Adjust scale for retina displays
        let aspectRatio = size.width / size.height

        var newSize: CGSize
        if aspectRatio > 1 {
          newSize = CGSize(width: targetSize.width, height: targetSize.width / aspectRatio)
        } else {
          newSize = CGSize(width: targetSize.height * aspectRatio, height: targetSize.height)
        }

        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
          self.draw(in: CGRect(origin: .zero, size: newSize))
        }
      }
    
    // input type for the nsfw model is CVPixelBuffer (224 by 224) and we only have UIImage let's convert uiimage to convert to CVPixelBuffer
    func buffer() -> CVPixelBuffer? {
            var pixelBuffer: CVPixelBuffer? = nil
            let width = 224
            let height = 224
            let attrs = [kCVPixelBufferCGImageCompatibilityKey:
                     kCFBooleanTrue,
                    kCVPixelBufferCGBitmapContextCompatibilityKey:
                     kCFBooleanTrue] as CFDictionary
            
            CVPixelBufferCreate(kCFAllocatorDefault, width, height,
                    kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
            CVPixelBufferLockBaseAddress(pixelBuffer!,
                    CVPixelBufferLockFlags(rawValue:0))
            let colorspace = CGColorSpaceCreateDeviceRGB()
            let bitmapContext = CGContext(data:
                    CVPixelBufferGetBaseAddress(pixelBuffer!),
                    width: width,
                    height: height,
                    bitsPerComponent: 8,
                    bytesPerRow:
                      CVPixelBufferGetBytesPerRow(pixelBuffer!),
                    space: colorspace,
                    bitmapInfo:
                     CGImageAlphaInfo.noneSkipFirst.rawValue)!
            bitmapContext.draw(self.cgImage!, in:
                    CGRect(x: 0, y: 0, width: width, height: height))
            return pixelBuffer
        }

}

extension UILabel {
    
    func colorString(text: String?, coloredText: String?, color: UIColor? = .red) {
        
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!],
                                       range: range)
        self.attributedText = attributedString
    }
}

extension Date {
    func dateFromString(_ string: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate]
        if #available(iOS 15, *) {
            let date = dateFormatter.date(from: string) ?? Date.now
            return date
        } else {
            // Fallback on earlier versions
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            return date
        }
    }
    
    func getCurrentDatePreIos15() -> Date {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return date
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
