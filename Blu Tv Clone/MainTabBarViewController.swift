//
//  ViewController.swift
//  Blu Tv Clone
//
//  Created by Berna Şener on 19.08.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        let vc1 = UINavigationController(rootViewController: KesfetViewController())
        let vc2 = UINavigationController(rootViewController: ListemViewController())
        let vc3 = UINavigationController(rootViewController: AramaViewController())
        let vc4 = UINavigationController(rootViewController: CanliYayinViewController())
        let vc5 = UINavigationController(rootViewController: HesabimViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "square.stack.fill")
        vc2.tabBarItem.image = UIImage(systemName: "checkmark.square")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "tv")
        vc5.tabBarItem.image = UIImage(systemName: "b.circle.fill")
        
        vc1.title = "Kesfet"
        vc2.title = "Listem"
        vc3.title = "Arama"
        vc4.title = "Canlı Yayın"
        vc5.title = "Hesabım"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
    }
    
}
