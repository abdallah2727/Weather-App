//
//  UIViewControllerExtension.swift
//  FWIPNFittedSheets
//
//  Created by Gordon Tucker on 8/28/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit

extension UIViewController {
    /// The sheet view controller presenting the current view controller heiarchy (if any)
    public var FWIPNsheetViewController: FWIPNSheetViewController? {
        var parent = self.parent
        while let currentParent = parent {
            if let FWIPNsheetViewController = currentParent as? FWIPNSheetViewController {
                return FWIPNsheetViewController
            } else {
                parent = currentParent.parent
            }
        }
        return nil
    }
}

#endif // os(iOS) || os(tvOS) || os(watchOS)
