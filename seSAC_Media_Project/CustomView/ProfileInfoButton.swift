//
//  UnderLineTextField.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/7/24.
//

import UIKit
import SnapKit

class ProfileInfoButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureHierarchy()
        configureConstraints()
    }
    
    func configureView() {
        
    }
    
    func configureHierarchy() {
        
    }
  
    func configureConstraints() {
        self.snp.makeConstraints { make in
            make.width.equalTo(280)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
