//
//  TvInfoViewController.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/2/24.
//

import UIKit
import SnapKit

class TvInfoViewController: BaseViewController {
    
    var seasonList: [Season] = []
    let sectionTitleList = ["시즌", "출연", "비슷한작품 추천"]
    
    var productId = 0
    let label = UILabel()
    
    let topTitleLabel: BlackTitleLabel = {
        let view = BlackTitleLabel()
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 24)
        return view
    }()
    
    lazy var infoTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(productId)
        APImanager.shared.fetchTvSeasonInfo(id: productId) { seasons in
            for i in seasons {
                print(seasons)
                self.seasonList.append(i)
            }
            self.infoTableView.reloadData()
        }
        
    }
    
    override func configureHierarchy() {
        view.addSubview(topTitleLabel)
        view.addSubview(infoTableView)
    }
    
    override func configureView(){
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
    }
    
    override func configureConstraints() {
        topTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(topTitleLabel.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
}

extension TvInfoViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionTitleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as! InfoTableViewCell
        
        cell.innerCollectionView.delegate = self
        cell.innerCollectionView.dataSource = self
        
        cell.innerCollectionView.register(InnerCollectionViewCell.self, forCellWithReuseIdentifier: InnerCollectionViewCell.identifier)
        cell.innerCollectionView.tag = indexPath.row
        cell.infoTitle.text = sectionTitleList[indexPath.row]
        
        cell.innerCollectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        var height: Int = 0
        //
        //        if indexPath.row == 0 {
        //            height = 250
        //        }
        //        if indexPath.row == 1 {
        //            height = 200
        //        }
        //        if indexPath.row == 2 {
        //            height = 300
        //        }
        //        return CGFloat(height)
        return 300
    }
    
}

extension TvInfoViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
        collectionView.dequeueReusableCell(withReuseIdentifier: InnerCollectionViewCell.identifier, for: indexPath) as! InnerCollectionViewCell
        let item = seasonList[indexPath.row]
        
        if let itemPoster = item.poster_path{
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(itemPoster)")
            cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "movieclapper"))
        }else{
            print("이미지데이터 오류")
        }
        
        cell.titleLabel.text = seasonList[indexPath.row].name
        cell.episodeCount.text = "\(seasonList[indexPath.row].episode_count)"
        return cell
    }
    
}
