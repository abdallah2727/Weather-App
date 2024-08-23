//
//  FWIPNLocalized.swift
//  FWIPNFittedSheetsPod
//
//  Created by Gordon Tucker on 8/11/20.
//  Copyright © 2020 Gordon Tucker. All rights reserved.
//

import UIKit

private class FWIPNFittedSheets { }
enum FWIPNLocalize: String {
    case dismissPresentation
    case changeSizeOfPresentation
    
    var FWIPNLocalized: String {
        return NSLocalizedString(self.rawValue, tableName: "SheetLocalizable", bundle: Bundle(for: FWIPNFittedSheets.self), value: "", comment: "")
    }
}
