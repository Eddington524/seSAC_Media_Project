//
//  SearchViewController.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/7/24.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    var list:[Info] = []
    let searchView = SearchView()
    var profileUrlSpace: ((String) -> Void)?
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .purple
        
        searchView.searchBar.delegate = self
        searchView.searchCollectionView.dataSource = self
        searchView.searchCollectionView.delegate = self
        
//        searchView.searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
//        
    }
}

extension SearchViewController: UISearchBarDelegate{
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else{
            print("잘못된 값을 입력했습니다")
            return
        }
        
        NaverApiManager.shared.callRequest(text: text, start: 1, sortType: "sim") { result, error in
            
            if error == nil {
                guard let result = result else {return}
                
                self.list = result.items
                self.searchView.searchCollectionView.reloadData()
            }else{
                print("검색 이미지 에러")
            }
        }
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = list[indexPath.row]

        if let thumbnail = item.thumbnail {
            let url = URL(string: thumbnail)
            
            cell.searchImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person"))
        }else{
            cell.searchImageView.image = UIImage(systemName: "person")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let imgUrl = list[indexPath.row].thumbnail else{
            print("이미지 url 전달 오류")
            return
        }
        profileUrlSpace?(imgUrl)
        dismiss(animated: true)
    }
    
}
