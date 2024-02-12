//
//  EditViewController.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/8/24.
//

import UIKit
import SnapKit

class EditViewController: BaseViewController {

    var titleText: String = ""
    
    let textLabel = UILabel()
    var textSpace: ((String) -> Void)?
    let inputTextField = UITextField()
    let okButton = UIButton()
    
    override func configureHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(inputTextField)
        view.addSubview(okButton)
    }
    
    override func configureView(){
        textLabel.text = titleText
        inputTextField.placeholder = "입력해주세요"
        okButton.setTitle("완료", for: .normal)
        okButton.setTitleColor(.systemBlue, for: .normal)
//        okButton.backgroundColor = .systemPink
        okButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }
    
    override func configureConstraints() {
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(20)
        }
        okButton.snp.makeConstraints { make in
            make.centerY.equalTo(inputTextField.snp.centerY)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(24)
        }
        
    }

}

extension EditViewController {
    
    @objc func doneButtonClicked(){
        
        guard let text = inputTextField.text else {
            print("inputTextField nil")
            return
        }
        textSpace?(text)
        dismiss(animated: true)
    }
}
