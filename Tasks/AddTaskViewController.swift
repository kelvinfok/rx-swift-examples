//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by Kelvin Fok on 17/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    
    private let taskSubject = PublishSubject<Task>()
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var taskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex),
            let title = taskTextField.text else { return }        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }
    
}
