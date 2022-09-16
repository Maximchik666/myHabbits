//
//  HabbitsViewController.swift
//  MyHabits
//
//  Created by Maksim Kruglov on 24.08.2022.
//

import Foundation
import UIKit

class HabbitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AlmostWhite")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.didTapButton))
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarCustomization()
        
    }
    
    
    func navBarCustomization () {
         self.navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor(named: "Purple")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.title = "Сегодня"
        
    }
    
    @objc private func didTapButton() {
        
        let newAwesomeNavigationBar = UINavigationController(rootViewController: HabbitViewController())
        present(newAwesomeNavigationBar, animated: true)
    }
    
}
