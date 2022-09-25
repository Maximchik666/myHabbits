//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Maksim Kruglov on 19.09.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var detailHabitIndex: Int = 0
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Standart Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        print(detailHabitIndex)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(hideDetailView(notification:)),
                                               name: Notification.Name("hideDetailView"),
                                               object: nil)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        
    }
    
    
    @objc func editHabit (){
        let VC = HabitViewController()
        VC.habitIndex = detailHabitIndex
        VC.calledForEditing = true
        let newAwesomeNavigationBar = UINavigationController(rootViewController: VC)
        present(newAwesomeNavigationBar, animated: true)
        }
    
    @objc func hideDetailView(notification: Notification ){
        navigationController?.pushViewController(HabitsViewController(), animated: true)
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Standart Cell", for: indexPath)
        cell.backgroundColor = .white
        let text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        cell.textLabel?.text = text
        
        if HabitsStore.shared.habit(HabitsStore.shared.habits[detailHabitIndex], isTrackedIn: HabitsStore.shared.dates[indexPath.row]) {
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 15))
            img.image = UIImage(systemName: "checkmark")
            cell.accessoryView = img
        }
        
        return cell
    }
}
