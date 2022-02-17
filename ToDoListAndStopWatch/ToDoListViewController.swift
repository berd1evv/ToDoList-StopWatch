//
//  ToDoListViewController.swift
//  ToDoListAndStopWatch
//
//  Created by Eldiiar on 8/2/22.
//

import UIKit

class ToDoListViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var numbers : [String] = ["To Wash Dishes", "Take a shower", "Do homework"]
    let tableView = UITableView()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        title = "To Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem = editButtonItem
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = false
        tableView.allowsMultipleSelection = true

    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.frame
    }
    
    @objc func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter New Item", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Enter Item"
            field.returnKeyType = .done
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    self.numbers.append(text)
                    self.tableView.reloadData()
                }
            }
        }))
        present(alert, animated: true)
    }
    
// MARK: TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = numbers[indexPath.row]
        
        cell.imageView?.image = UIImage(systemName: "checkmark.circle")
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            numbers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.imageView?.image == UIImage(systemName: "checkmark.circle") {
                cell.imageView?.image = UIImage(systemName: "checkmark.circle.fill")
            }
            else{
                cell.imageView?.image = UIImage(systemName: "checkmark.circle")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let sheet = UIAlertController(title: .none, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { item in
            let alert = UIAlertController(title: "Edit Item", message: "Edit New Item", preferredStyle: .alert)
            alert.addTextField { field in
                field.placeholder = "Edit an Item"
                field.returnKeyType = .done
            }
            alert.textFields?.first?.text = self.numbers[indexPath.row]
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
                if let field = alert.textFields?.first {
                    if let text = field.text, !text.isEmpty {
                        if let i = self.numbers.firstIndex(of: self.numbers[indexPath.row]) {
                            self.numbers[i] = text
                        }
                        self.tableView.reloadData()
                    }
                }
            }))
            self.present(alert, animated: true)

        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(sheet, animated: true)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = numbers[sourceIndexPath.row]
        numbers.remove(at: sourceIndexPath.row)
        numbers.insert(movedObject, at: destinationIndexPath.row)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }

}
