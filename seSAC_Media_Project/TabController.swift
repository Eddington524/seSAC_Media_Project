//
//  TabController.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/7/24.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
//        self.tabBar.barTintColor = .white
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .lightGray
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Tab setup
    private func setupTabs() {
//        let vc = HomeViewController()
//        
        let home = self.createNav(with: "TVPIDIA", and: UIImage(systemName: "house"), vc: HomeViewController())
        let search = self.createNav(with: "검색", and: UIImage(systemName: "magnifyingglass.circle"), vc: SearchViewController())
        let setting = self.createNav(with: "프로필 설정", and: UIImage(systemName: "person.crop.circle"), vc: ProfileViewController())
        self.setViewControllers([home,search,setting], animated: true)
    }

    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UIViewController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title
        
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: nil, action: nil)
        
        
//        nav.navigationItem?.title
        
        return nav
    }
}
