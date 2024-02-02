//
//  TrendCollectionViewCell.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/2/24.
//

import UIKit
import SnapKit

class TvCollectionViewCell: BaseCollectionViewCell {
    
    let titleLabel = BlackTitleLabel()
    let posterImage = PosterImageView(frame: .zero)
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(posterImage)
    }
    
    override func configureView(){
        
    }
    
    override func configureConstraints() {
        posterImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(contentView.snp.bottom).offset(4)
            make.height.equalTo(20)
        }
        
    }
}
