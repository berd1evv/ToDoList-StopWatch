//
//  ToDoListViewModel.swift
//  ToDoListAndStopWatch
//
//  Created by Eldiiar on 26/2/22.
//

import UIKit

protocol ToDoListViewModelProtocol {
    var data: [Lists] {get set}
    func configureForLoop()
    func didTapAdd(alert: UIAlertController, tableView: UITableView)
    func didSelectRow(indexPath: IndexPath, tableView: UITableView)
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func dataCount() -> Int
    func editButtonTapped(tableView: UITableView, indexPath: IndexPath, sheet: UIAlertController, alert: UIAlertController)
    func moveRowAt(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)
    func editingStyle(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, indexPath: IndexPath)
}

class ToDoListViewModel: ToDoListViewModelProtocol{
    

    var data = [Lists]()

    func configureForLoop() {
        let models = ["To Wash Dishes", "Take a shower", "Do homework"]
        for list in models {
            data.append(Lists(list: list))
        }
    }

    func didTapAdd(alert: UIAlertController, tableView: UITableView) {
        alert.addTextField { field in
            field.placeholder = "Enter Item"
            field.returnKeyType = .done
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    self.data.append(Lists(list: text))
                    tableView.reloadData()
                }
            }
        }))
    }
    
    func editButtonTapped(tableView: UITableView, indexPath: IndexPath, sheet: UIAlertController, alert: UIAlertController) {
        alert.addTextField { field in
            field.placeholder = "Edit an Item"
            field.returnKeyType = .done
        }
        alert.textFields?.first?.text = self.data[indexPath.row].list
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    if let i = self.data.firstIndex(of: self.data[indexPath.row]) {
                        self.data[i].list = text
                    }
                    tableView.reloadData()
                }
            }
        }))
    }

    func didSelectRow(indexPath: IndexPath, tableView: UITableView) {
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

    func cellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].list

        cell.imageView?.image = UIImage(systemName: "checkmark.circle")
        cell.accessoryType = .detailDisclosureButton

        return cell
    }

    func dataCount() -> Int {
        return data.count
    }
    
    func moveRowAt(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        let movedObject = data[sourceIndexPath.row]
        data.remove(at: sourceIndexPath.row)
        data.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func editingStyle(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
