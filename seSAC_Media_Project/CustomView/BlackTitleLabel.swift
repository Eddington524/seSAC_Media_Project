//
//  BlackTitleLabel.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/2/24.
//

import UIKit

class BlackTitleLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        self.backgroundColor = .clear
        self.font = .boldSystemFont(ofSize: 12)
        self.textAlignment = .center
        self.numberOfLines = 0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

