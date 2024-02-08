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
    var nameSpace: ((String) -> Void)?
    let inputTextField = UITextField()
    let doneButton = UIButton()
    
    override func configureHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(inputTextField)
        view.addSubview(doneButton)
    }
    
    override func configureView(){
        textLabel.text = titleText
        doneButton.setTitle("확인", for: .normal)
        doneButton.setTitleColor(.systemBlue, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        inputTextField.backgroundColor = .gray
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
        doneButton.snp.makeConstraints { make in
            make.centerY.equalTo(inputTextField.snp.centerY)
            make.leading.equalTo(inputTextField.snp.trailing).offset(8)
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
        nameSpace?(text)
        dismiss(animated: true)
    }
}
