//
//  HabbitsViewController.swift
//  MyHabits
//
//  Created by Maksim Kruglov on 24.08.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressBarCell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "Habit Cell")
        collectionView.backgroundColor = UIColor(named: "AlmostWhite")
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AlmostWhite")
        view.addSubview(collectionView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.didTapButton))
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarCustomization()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadCollectionView(notification:)),
                                               name: Notification.Name("reloadData"),
                                               object: nil)
        
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
        
        let newAwesomeNavigationBar = UINavigationController(rootViewController: HabitViewController())
        present(newAwesomeNavigationBar, animated: true)
    }
    
    
    @objc func reloadCollectionView(notification: Notification) {
        collectionView.reloadData()
    }
    
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item ==  0 {
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressBarCell", for: indexPath) as! ProgressCollectionViewCell
            cell.layer.cornerRadius = 6
            cell.setup()
            return cell
        } else {
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "Habit Cell", for: indexPath) as! HabitCollectionViewCell
            cell.layer.cornerRadius = 6
            cell.setupCell(index: (indexPath.item - 1))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return  CGSize(width: view.frame.width-32 , height: 60)
        } else {
            return  CGSize(width: view.frame.width-32 , height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item != 0 {
            let vc = HabitDetailsViewController()
            vc.detailHabitIndex = indexPath.item - 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
