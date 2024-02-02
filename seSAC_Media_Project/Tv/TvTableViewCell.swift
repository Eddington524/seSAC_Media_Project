//
//  TvTableViewCell.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/2/24.
//

import UIKit
import SnapKit

class TvTableViewCell: BaseTableViewCell {

    let lineTitleLabel = LineTitleLabel()
    let innerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionView())
    
    
    override func configureHierarchy() {
        contentView.addSubview(lineTitleLabel)
        contentView.addSubview(innerCollectionView)
    }
    
    override func configureConstraints() {
        lineTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(16)
            make.leading.equalTo(contentView.snp.leading).inset(16)
        }
        innerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lineTitleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    override func configureView(){
        
    }
    
    static func configureCollectionView() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        //1) 아이템사이즈
        layout.itemSize  = CGSize(width: UIScreen.main.bounds.width/3, height: 200)
        //2) mini spacing, interItemSpacing
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        //3) 섹션 인셋
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
}
