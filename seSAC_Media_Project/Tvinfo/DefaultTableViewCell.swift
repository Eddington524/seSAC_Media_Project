//
//  DefaultTableViewCell.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/3/24.
//

import UIKit

class DefaultTableViewCell: BaseTableViewCell {
    
    let defaultInfoTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "기본정보"
        view.font = .boldSystemFont(ofSize: 20)
        view.backgroundColor = .white
        return view
    }()
    
    let overviewInfoLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.numberOfLines = 0
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(defaultInfoTitleLabel)
        contentView.addSubview(overviewInfoLabel)
    }
    
    override func configureConstraints() {
        defaultInfoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        
        overviewInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(defaultInfoTitleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
//            make.height.lessThanOrEqualTo(120)
            make.height.greaterThanOrEqualTo(44)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
    }
    
    override func configureView() {
//        defaultInfoTitleLabel.backgroundColor = .yellow
//        overviewInfoLabel.backgroundColor = .blue
    }
    
}
