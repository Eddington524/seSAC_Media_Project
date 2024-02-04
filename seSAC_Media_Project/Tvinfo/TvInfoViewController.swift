//
//  TvInfoViewController.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/2/24.
//

import UIKit
import SnapKit
import Kingfisher

class TvInfoViewController: BaseViewController {

    var seasonList: [Season] = []
    var castList: [Actor] = []
    var recommendList: [Drama] = []
    
    let sectionTitleList = ["기본정보", "시즌", "출연", "비슷한작품 추천"]
    
    var productId = 0
    var productName = ""
    var backDropUrl = ""
    var overview = ""
    
    let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let backDropImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let infoTitle: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 20)
        view.numberOfLines = 0
        return view
    }()
    
    
    
    lazy var infoTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        
//        APImanager.shared.fetchTvSeasonInfo(id: productId) { result in
//
//            self.seasonList = result.seasons
//
//            if let backdrop_path  = result.backdrop_path {
//                
//                let url = URL(string: "https://image.tmdb.org/t/p/w500\(backdrop_path)")
//                
//                self.backDropImage.kf.setImage(with:url, placeholder: UIImage(systemName: "movieclapper"))
//                
//            }
//
//            if let overview = result.overview {
//                self.overview = overview
//            }else{
//                self.overview = "줄거리가 미제공된 콘텐츠 입니다"
//            }
//            group.leave()
//        }
        group.enter()
        APImanager.shared.request(type: SeasonModel.self, api: .dramaDetail(id: productId)) { response in
            self.seasonList = response.seasons

            if let backdrop_path  = response.backdrop_path {
                
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(backdrop_path)")
                
                self.backDropImage.kf.setImage(with:url, placeholder: UIImage(systemName: "movieclapper"))
                
            }

            if let overview = response.overview {
                self.overview = overview
            }else{
                self.overview = "줄거리가 미제공된 콘텐츠 입니다"
            }
            group.leave()
        }
        
        group.enter()
        APImanager.shared.request(type: ActorModel.self, api: .casting(id: productId)) { response in
            self.castList = response.cast
            group.leave()
        }
        
        infoTitle.text = productName
        
        group.enter()
        APImanager.shared.request(type: DramaModel.self, api: .recommend(id: productId)) { reponse in
            self.recommendList = reponse.results

            group.leave()
        }
        
        group.notify(queue: .main) {
            self.infoTableView.reloadData()
        }
        
    }
    
    override func configureHierarchy() {
        view.addSubview(backGroundView)
        view.addSubview(backDropImage)
        view.addSubview(infoTitle)
        view.addSubview(infoTableView)
        
    }
    
    override func configureView(){
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        infoTableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.identifier)
    }
    
    override func configureConstraints() {
        backDropImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(260)
        }
        
        infoTitle.snp.makeConstraints { make in
            make.bottom.equalTo(backDropImage.snp.bottom).inset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(48)
        }
        
        backGroundView.snp.makeConstraints { make in
            make.top.equalTo(backDropImage.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(backDropImage.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
}

extension TvInfoViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionTitleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as! InfoTableViewCell
            
            cell.innerCollectionView.delegate = self
            cell.innerCollectionView.dataSource = self
            
            cell.innerCollectionView.register(InnerCollectionViewCell.self, forCellWithReuseIdentifier: InnerCollectionViewCell.identifier)
            cell.innerCollectionView.tag = indexPath.row
            
            cell.infoTitle.text = sectionTitleList[indexPath.row]
            
            cell.innerCollectionView.reloadData()
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as! DefaultTableViewCell
            
            cell.overviewInfoLabel.text = overview
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: Int = 280
        
        if indexPath.row == 0 {
            height = 150
        }
      
        return CGFloat(height)
    }
    
}

extension TvInfoViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    // mark: collectionViewCell 따로 만들기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count: Int = 0
        
        if collectionView.tag == 1 {
            count = seasonList.count
        }
        
        if collectionView.tag == 2 {
            count = castList.count
        }
        
        if collectionView.tag == 3 {
            count = recommendList.count
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell =
        collectionView.dequeueReusableCell(withReuseIdentifier: InnerCollectionViewCell.identifier, for: indexPath) as! InnerCollectionViewCell
        
        if collectionView.tag == 1 {
            let item = seasonList[indexPath.row]
            
            if let itemPoster = item.poster_path{
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(itemPoster)")
                cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "movieclapper"))
            }else{
                print("이미지데이터 오류")
            }
            
            cell.titleLabel.text = seasonList[indexPath.row].name
            cell.episodeCount.text = "에피소드:\(seasonList[indexPath.row].episode_count)"
            return cell
        }
        
        else if collectionView.tag == 2{
            let item = castList[indexPath.row]
            
            if let itemProfile = item.profile_path{
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(itemProfile)")
                cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person"))
            }else{
                print("이미지데이터 오류")
            }
            
            let data = castList[indexPath.row]
            
            cell.titleLabel.text = data.name
            cell.episodeCount.text = "\(data.roles[0].character)"

            return cell
        }

        else if collectionView.tag == 3{
            
            let item = recommendList[indexPath.row]
            
            if let itemPoster = item.poster{
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(itemPoster)")
                cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "movieclapper"))
            }else{
                print("이미지데이터 오류")
            }
            
            cell.titleLabel.text = recommendList[indexPath.row].name
            return cell

        }else{
            return cell
        }
        
    }
    
}
