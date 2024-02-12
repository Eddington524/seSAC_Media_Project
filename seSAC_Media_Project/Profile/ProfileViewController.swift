//
//  ProfileViewController.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/7/24.
//

import UIKit
import SnapKit

class ProfileViewController: BaseViewController {
    
    let infoFieldList = ["이름", "사용자이름", "성별", "소개", "링크"]
    var labelTag = 0
    var nameList: [String] = ["","","","",""] {
        didSet {
            infoTableView.reloadData()
        }
    }
    var profileUrlSpace: ((String) -> Void)?
    
    let profileImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.image = UIImage(systemName: "person")
        view.backgroundColor = .lightGray
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let avartarImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var topStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .fillEqually
        return view
    }()
    
    
    let photoEditButton: UIButton = {
        let view = UIButton()
        view.setTitle("사진 또는 아바타 수정", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        
        return view
    }()
    
    lazy var infoTableView: UITableView = {
        let view = UITableView()
        
        
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 36
        
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        
        return view
    }()
    
    let privacyButton: UIButton = {
        let view = UIButton()
        view.setTitle("개인정보설정", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    
    override func configureHierarchy() {
        let uiList = [topStackView, infoTableView, photoEditButton, infoTableView, privacyButton]
        
        uiList.forEach {
            view.addSubview($0)
        }
        
        [profileImage,avartarImage].forEach {
            topStackView.addArrangedSubview($0)
        }
    }
    
    override func configureView(){
        
        photoEditButton.addTarget(self, action: #selector(movePhotoEditView), for: .touchUpInside)
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.movePhotoEditView))
        profileImage.addGestureRecognizer(tapGesture)
    }
    
    override func configureConstraints() {
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.center)
            make.height.equalTo(100)
        }
        
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(photoEditButton.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(100)
        }
        
        avartarImage.snp.makeConstraints { make in
            make.size.equalTo(100)
        }
        
        photoEditButton.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(8)
            make.centerX.equalTo(topStackView)
        }
        
    }
}

extension ProfileViewController {
    @objc func nameButtonClicked() {
        let vc = EditViewController()
//        vc.titleText = "이름"
        vc.textSpace = { value in
            //            self.nameButton.setTitle(value, for: .normal)
            
        }
        present(vc, animated: true)
    }
    
    @objc func movePhotoEditView() {
        let vc = SearchViewController()
        vc.profileUrlSpace = {
            url in
            self.profileImage.kf.setImage(with: URL(string: url))
        }
        present(vc, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoFieldList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else{
           
            return UITableViewCell()
        }
        
        cell.titleLabel.text = infoFieldList[indexPath.row]
        cell.infoLable.tag = indexPath.row
        cell.infoLable.text = nameList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditViewController()
        vc.titleText = infoFieldList[indexPath.row]
        self.labelTag = indexPath.row
        
        vc.textSpace = { value in
            self.nameList[self.labelTag] = value
        }
        
        present(vc, animated: true)
    }
}
