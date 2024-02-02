//
//  ViewController.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/1/24.
//

import UIKit
import SnapKit
import Kingfisher

class HomeViewController: BaseViewController {

    let titleList:[String] = ["뜨거운 핫 트렌드!", "평점 높은 TV!", "이보다 더 유명할 수 없는 프로그램"]
    
    let tvCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionView())
    var list: [TV] = []
    var tvList:[[TV]] = [[],[],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APImanager.shared.fetchTVImages(url: "trending/tv/week") { tvs in
            self.list = tvs
            self.tvCollectionView.reloadData()
        }
        
    }

    override func configureHierarchy() {
        view.addSubview(tvCollectionView)
    }
    
    override func configureConstraints() {
        tvCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(200)
        }
    }
    
    override func configureView() {
        tvCollectionView.delegate = self
        tvCollectionView.dataSource = self
        
        tvCollectionView.register(TvCollectionViewCell.self, forCellWithReuseIdentifier: TvCollectionViewCell.identifier)
    }

}


extension HomeViewController {
    
    static func configureCollectionView() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()

        layout.itemSize  = CGSize(width: UIScreen.main.bounds.width/3, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TvCollectionViewCell.identifier, for: indexPath) as! TvCollectionViewCell
        
        let item = list[indexPath.row]
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\( item.poster ?? "")") {
            cell.posterImage.kf.setImage(with: url, placeholder: UIImage(systemName: "movieclapper"))
        }else{
            print("이미지데이터 오류")
        }
        cell.titleLabel.text = item.name
        return cell
    }
    
    
}
