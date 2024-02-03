//
//  InfoTableViewCell.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/3/24.
//

import UIKit

class InfoTableViewCell: BaseTableViewCell{
    
    let infoTitle: UILabel = {
        let title = UILabel()
        return title
    }()
    
    
    let innerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionView())


//    let lineupCollectionView = UICollectionView()
//    let recommendCollectionView = UICollectionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureConstraints()
        configureView()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(infoTitle)
        contentView.addSubview(innerCollectionView)
    }
    
    override func configureConstraints() {
        infoTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        innerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(infoTitle.snp.bottom).inset(12)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
        
    }
    
    override func configureView() {
        infoTitle.backgroundColor = .clear
//        innerCollectionView.backgroundColor = .yellow
    }
    
    static func configureCollectionView()-> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        //1) 아이템사이즈
        layout.itemSize  = CGSize(width: UIScreen.main.bounds.width, height: 200)
        //2) mini spacing, interItemSpacing
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        //3) 섹션 인셋
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
}
