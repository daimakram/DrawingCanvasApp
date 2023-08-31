//
//  Snapshot.swift
//  DrawingCanvas
//
//  Created by Daim Armaghan on 31/08/2023.
//


import UIKit

extension UIView {

    func takeSnapshot() -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: self.frame.size.width, height: self.frame.size.height - 5))
        let rect = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        drawHierarchy(in: rect, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIImage {

    func saveToPhotoLibrary(_ completionTarget: Any?, _ completionSelector: Selector?) {
        DispatchQueue.global(qos: .userInitiated).async {
            UIImageWriteToSavedPhotosAlbum(self, completionTarget, completionSelector, nil)
        }
    }
}

extension UIAlertController {

    func present() {
        guard let controller = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController else {
            return
        }
        controller.present(self, animated: true)
    }
}
