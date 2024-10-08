//
//  FWIPNSheetContentViewDelegate.swift
//  FWIPNFittedSheetsPod
//
//  Created by Gordon Tucker on 7/29/20.
//  Copyright © 2020 Gordon Tucker. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit

protocol FWIPNSheetContentViewDelegate: AnyObject {
    func preferredHeightChanged(oldHeight: CGFloat, newSize: CGFloat)
    func pullBarTapped()
}

#endif // os(iOS) || os(tvOS) || os(watchOS)
