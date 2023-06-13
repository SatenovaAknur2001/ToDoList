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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
     var models = [ToDoList]()
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
    
    let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        makeConstraints()
        
    }
    //MARK: -- UI Functions
    
    func setupUI() {
        view.backgroundColor = .systemBlue
        view.addSubview(addButton)
        view.addSubview(tableView)
        title = "To Do List"
        getAllItems()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.reloadData()
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
    
    //MARK: -- Core Data Functions
    
    func getAllItems() {
        do{
            models = try context.fetch(ToDoList.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }
    
    func createItem(name: String) {
        let newItem = ToDoList(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func deleteItem(item: ToDoList) {
        context.delete(item)
        getAllItems()
    }
    
    func updateItem(item: ToDoList, newName: String) {
        item.name = newName
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    @objc func addButtonTapped() {
        let alert = UIAlertController(title: "To Do List",
                                      message: "Write what you want to add to the To Do List",
                                      preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            
            self?.createItem(name: text)
        }))
        
        present(alert, animated: true)
    }
    
}

