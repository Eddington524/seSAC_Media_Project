//
//  ProfileViewController.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/7/24.
//

import UIKit
import SnapKit

class ProfileViewController: BaseViewController {

    lazy var topStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .fillEqually
        return view
    }()
    
    lazy var nameStackView = InfoStackView()
    lazy var usernameStackView = InfoStackView()
    lazy var genderStackView = InfoStackView()
    lazy var introduceStackView = InfoStackView()
    lazy var linkStackView = InfoStackView()
    
//    lazy var nStackView
    
    let profileImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.image = UIImage(systemName: "person")
        view.backgroundColor = .lightGray
        return view
    }()
    
    let avartarImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.backgroundColor = .blue
        return view
    }()
    
    let photoEditButton: UIButton = {
        let view = UIButton()
        view.setTitle("사진 또는 아바타 수정", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.darkGray.cgColor
        return view
    }()
    
    let nameLabel: ProfileInfoLabel = {
        let view = ProfileInfoLabel()
        view.text = "이름"
        return view
    }()
    
    let userNameLabel: ProfileInfoLabel = {
        let view = ProfileInfoLabel()
        view.text = "닉네임"
        return view
    }()
    
//    let userNameLabel = ProfileInfoLabel()
    let genderLabel = ProfileInfoLabel()
    let introduceLabel = ProfileInfoLabel()
    let linkLabel = ProfileInfoLabel()
    
    let nameButton = UnderLineButton()
    let userNameButton = UnderLineButton()
    let genderButton = UnderLineButton()
    let introduceButton = UnderLineButton()
    let linkButton = UnderLineButton()

    let privacyButton: UIButton = {
        let view = UIButton()
        view.setTitle("개인정보설정", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        return view
    }()
    
    let editButton: UIButton = {
        let view = UIButton()
        let border = CALayer()
        border.frame = CGRect(x: 0, y: view.frame.size.height-1, width: view.frame.width, height: 1)
        border.backgroundColor = UIColor.darkGray.cgColor
        view.layer.addSublayer(border)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        let uiList = [topStackView, photoEditButton, nameStackView, usernameStackView, genderStackView, introduceStackView,linkStackView, privacyButton, photoEditButton]
        
        uiList.forEach {
            view.addSubview($0)
        }
        
        [profileImage,avartarImage].forEach {
            topStackView.addArrangedSubview($0)
        }
        
        [nameLabel,nameButton].forEach {
            nameStackView.addArrangedSubview($0)
        }
        
        [userNameLabel,userNameButton].forEach {
            usernameStackView.addArrangedSubview($0)
        }
        
        [genderLabel,genderButton].forEach {
            genderStackView.addArrangedSubview($0)
        }
        
        [introduceLabel,introduceButton].forEach {
            introduceStackView.addArrangedSubview($0)
        }
        
        [linkLabel,linkButton].forEach {
            linkStackView.addArrangedSubview($0)
        }

    }
    
    override func configureView(){
        
        nameButton.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
        userNameButton.addTarget(self, action: #selector(userNameButtonClicked), for: .touchUpInside)
    }
    
    override func configureConstraints() {
    
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.center)
            make.height.equalTo(100)
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
        
        nameStackView.snp.makeConstraints { make in
            make.top.equalTo(photoEditButton.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(32)
        }
        
        usernameStackView.snp.makeConstraints { make in
            make.top.equalTo(nameStackView.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(32)
        }
        
        
    }
}

extension ProfileViewController {
    @objc func nameButtonClicked() {
        let vc = EditViewController()
        vc.titleText = "이름"
        vc.nameSpace = { value in
            self.nameButton.setTitle(value, for: .normal)
            
        }
        present(vc, animated: true)
    }
    
    @objc func userNameButtonClicked() {
        let vc = EditViewController()
        vc.titleText = "닉네임"
        vc.nameSpace = { value in
            self.userNameButton.setTitle(value, for: .normal)

        }
        present(vc, animated: true)
    }
    
}
