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
    
    let homeTableView  = UITableView()
    
//    let tvCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionView())
    
//    var list: [TV] = []
    var tvList:[[TV]] = [[],[],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        group.enter()
        APImanager.shared.fetchTVImages(url: "trending/tv/week") { tvs in
            self.tvList[0] = tvs
            group.leave()
        }
        group.enter()
        APImanager.shared.fetchTVImages(url: "tv/top_rated") { tvs in
            self.tvList[1] = tvs
//            self.collectionView.reloadData()
            group.leave()
        }
        group.enter()
        APImanager.shared.fetchTVImages(url: "tv/popular") { tvs in
            self.tvList[2] = tvs
            group.leave()
        }
        
        group.notify(queue: .main) {
//            self.tvCollectionView.reloadData()
            self.homeTableView.reloadData()
        }
        
        
    }

    override func configureHierarchy() {
        view.addSubview(homeTableView)
//        view.addSubview(tvCollectionView)
    }
    
    override func configureConstraints() {
//        tvCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
//            make.height.equalTo(200)
//        }
        
        homeTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
//        tvCollectionView.delegate = self
//        tvCollectionView.dataSource = self
        
//        tvCollectionView.register(TvCollectionViewCell.self, forCellWithReuseIdentifier: TvCollectionViewCell.identifier)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.rowHeight = 280
        
        homeTableView.register(TvTableViewCell.self, forCellReuseIdentifier: TvTableViewCell.identifier)
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
        
        return tvList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TvCollectionViewCell.identifier, for: indexPath) as! TvCollectionViewCell
        
//        let item = list[indexPath.row]
        let item = tvList[collectionView.tag][indexPath.row]
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\( item.poster ?? "")") {
            cell.posterImage.kf.setImage(with: url, placeholder: UIImage(systemName: "movieclapper"))
        }else{
            print("이미지데이터 오류")
        }
        cell.titleLabel.text = item.name
        return cell
    }
    
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TvTableViewCell.identifier, for: indexPath) as! TvTableViewCell
        
        // 아하! cell 안에서도 연결 시켜줘야지!
        cell.innerCollectionView.delegate = self
        cell.innerCollectionView.dataSource = self
        cell.innerCollectionView.register(TvCollectionViewCell.self, forCellWithReuseIdentifier: TvCollectionViewCell.identifier)
        cell.innerCollectionView.tag = indexPath.row
        cell.lineTitleLabel.text = titleList[indexPath.row]
     
        cell.innerCollectionView.reloadData()
        
        return cell
    }
    
}
