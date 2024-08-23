//
//  CustomUibutton.swift
//  Weather-App
//
//  Created by Abdallah ismail on 23/08/2024.
//

import UIKit

final class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

      
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }

}
extension CustomButton {
    func setupButton(color:UIColor,font:UIFont.TextStyle,title:String) {
        setTitle(title, for:.normal )
        setTitleColor(.white, for: .normal)
        backgroundColor      = color
        titleLabel?.font     = UIFont(name:title, size: 18)
        layer.cornerRadius   = CGFloat(Constants.viewBordeRaduis)
        layer.borderWidth    = CGFloat(Constants.viewBorderWidth)
        layer.borderColor    = UIColor.lightGray.cgColor
    }

    
}
