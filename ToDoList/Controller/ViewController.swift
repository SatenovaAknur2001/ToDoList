//
//  ViewController.swift
//  ToDoList
//
//  Created by Aknura Kanabekova on 08.06.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: --Constants
    private let addButton: UIButton = {
        let addButton = UIButton()
        addButton.backgroundColor = .white
        addButton.layer.cornerRadius = 10
        addButton.layer.borderWidth = 1
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return addButton
    }()
    
    let list = ["My Name is Aknur", "First","Second","Third"]
    
    let tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        makeConstraints()
        
    }
//MARK: --Functions
    
        func setupUI() {
            view.backgroundColor = .systemBlue
            view.addSubview(addButton)
            view.addSubview(tableView)
            title = "To Do List"
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
            tableView.delegate = self
            tableView.dataSource  = self
        }
    
        func makeConstraints() {
            addButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().inset(32)
                make.right.equalToSuperview().inset(50)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
            
            tableView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.right.equalToSuperview().inset(0)
                make.bottom.equalTo(addButton.snp.top)
            }
    }
    
    @objc func addButtonTapped() {
        let alert = UIAlertController(title: "To Do List", message: "Write what you want to add to the To Do List", preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "To Do List option"
            field.returnKeyType = .next
            field.keyboardType = .emailAddress
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Continue", style: .default))
        
        present(alert, animated: true)
    }
    
}

