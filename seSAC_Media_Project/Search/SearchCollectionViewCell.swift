//
//  SearchCollectionViewCell.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/9/24.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    let searchImageView = PosterImageView(frame: .zero)
    let titleLabel = BlackTitleLabel()
    
    override func configureConstraints() {
        searchImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.height.equalTo(20)
        }
    }
    
   override func configureHierarchy() {
        contentView.addSubview(searchImageView)
        contentView.addSubview(titleLabel)
    }
    
    override func configureView(){
        searchImageView.image = UIImage(systemName: "person")
//        contentView.backgroundColor = .systemMint
    }
    
}
