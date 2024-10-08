//
//  FWIPNSheetViewDelegate.swift
//  FWIPNFittedSheetsPod
//
//  Created by Gordon Tucker on 8/5/20.
//  Copyright © 2020 Gordon Tucker. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit

protocol FWIPNSheetViewDelegate: AnyObject {
    func sheetPoint(inside point: CGPoint, with event: UIEvent?) -> Bool
}

#endif // os(iOS) || os(tvOS) || os(watchOS)
