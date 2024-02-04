//
//  ActorsImageView.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/2/24.
//

import UIKit

class ProfileImageView: BaseImageView {

    override func configureView() {
        backgroundColor = .clear
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = 6
    }
   
}
