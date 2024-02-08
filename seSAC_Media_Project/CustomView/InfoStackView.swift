//
//  infoStackView.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/8/24.
//


import UIKit

class InfoStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        self.axis = .horizontal
        self.spacing = 4
        self.distribution = .fillProportionally
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
