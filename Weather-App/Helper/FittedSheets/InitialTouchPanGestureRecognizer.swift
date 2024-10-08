//
//  FWIPNInitialTouchPanGestureRecognizer.swift
//  FWIPNFittedSheets
//
//  Created by Gordon Tucker on 8/27/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit.UIGestureRecognizerSubclass

class FWIPNInitialTouchPanGestureRecognizer: UIPanGestureRecognizer {
    var initialTouchLocation: CGPoint?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        initialTouchLocation = touches.first?.location(in: view)
    }
}
#endif
