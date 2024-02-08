//
//  BaseViewController.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/2/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureConstraints()
        configureView()
        view.backgroundColor = .white
    }
    

    func configureHierarchy() {
        
    }
    
    func configureConstraints() {
        
        
    }
    
    func configureView(){
        
    }
    
   

}

extension BaseViewController {
    
    func showErrorAlert(title:String, message:String, buttonTitle:String, completeHandler: @escaping()-> Void){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in completeHandler()
        }
         
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        present(alert, animated: true)
        
        }
}
