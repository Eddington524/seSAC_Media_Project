//
//  InnerCollectionViewCell.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/3/24.
//

import UIKit

class InnerCollectionViewCell: BaseCollectionViewCell {
    
    let titleLabel: BlackTitleLabel = {
        let label = BlackTitleLabel()
        return label
    }()
    
    
     let episodeCount: DarkgrayLabel = {
         let view = DarkgrayLabel()
         return view
     }()
    
    let posterImageView = PosterImageView(frame: .zero)

    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(posterImageView)
        contentView.addSubview(episodeCount)

    }
    
    override func configureConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(140)
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide)

        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(8)
           
            make.height.equalTo(32)
        }
        
        episodeCount.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(titleLabel.snp.height)
        }
    }
    
    override func configureView() {
//        titleLabel.backgroundColor = .blue
        posterImageView.backgroundColor = .systemMint

    }
    
}
