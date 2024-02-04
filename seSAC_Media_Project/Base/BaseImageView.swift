//
//  BaseImageView.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/3/24.
//

import Foundation
import UIKit

class BaseImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    func configureHierarchy() {
        
    }
    
    func configureView(){
        
    }
    
    func configureConstraints() {
        
    }
}
