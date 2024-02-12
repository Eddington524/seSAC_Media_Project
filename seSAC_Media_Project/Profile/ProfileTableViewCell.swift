//
//  ProfileTableViewCell.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/8/24.
//

import UIKit
import SnapKit

class ProfileTableViewCell: BaseTableViewCell {

    let titleLabel = LineTitleLabel()
    let infoLable:DarkgrayLabel = {
        let view = DarkgrayLabel()
        view.text = "입력해주세요"
        view.textAlignment = .left
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLable)
    }
    
    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(4)
            make.leading.equalTo(contentView.snp.leading).inset(16)
            make.height.equalTo(24)
        }
        
        infoLable.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.width.equalTo(280)
            make.trailing.equalTo(contentView.snp.trailing).inset(16)
            make.height.equalTo(24)
        }
    }
 
    override func configureView(){
    }

}
