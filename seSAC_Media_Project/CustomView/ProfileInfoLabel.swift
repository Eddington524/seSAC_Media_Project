//
//  ProfileInfoLabel.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/7/24.
//
import UIKit

class ProfileInfoLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        self.backgroundColor = .clear
        self.font = .boldSystemFont(ofSize: 16)
        self.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
