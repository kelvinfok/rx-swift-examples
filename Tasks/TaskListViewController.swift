//
//  ViewController.swift
//  GoodList
//
//  Created by Kelvin Fok on 17/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {

    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var tasks = BehaviorRelay<[Task]>(value: [])
    
    private var filteredTasks = [Task]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController, let addTaskVC = navC.viewControllers.first as? AddTaskViewController else { return }
        
        let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
        
        addTaskVC.taskSubjectObservable.subscribe(onNext: {
            print($0)
            var _tasks = self.tasks.value
            _tasks.append($0)
            self.tasks.accept(_tasks)
            self.filterTasks(by: priority)
        }).disposed(by: disposeBag)
    }
    
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
        } else {
            let tasks = self.tasks.map { tasks in
                return tasks.filter({ $0.priority == priority })
            }
            tasks.subscribe(onNext: {
                self.filteredTasks = $0
                print($0)
            }).disposed(by: disposeBag)
        }
    }
    
    @IBAction func priorityValueChanged(segementedControl: UISegmentedControl) {
        let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = self.filteredTasks[indexPath.item].title
        return cell
    }
}
