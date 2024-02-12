//
//  SearchView.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/9/24.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "이미지를 검색해보세요"
        view.showsCancelButton = true
        view.barStyle = .black
        return view
    }()
    
    let searchCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout:configureCollectionViewLayout())
    
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(searchCollectionView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        searchCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
    
}
