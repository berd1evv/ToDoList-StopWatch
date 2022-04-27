//
//  AddNewCellViewController.swift
//  ToDoListAndStopWatch
//
//  Created by Eldiiar on 27/4/22.
//

import UIKit

class AddNewCellViewController: UIViewController  {
    
    private var viewModel: AddNewCellProtocol
    
    init(vm: AddNewCellProtocol = AddNewCellViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
        
    let textField1: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text here!"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let textField2: UITextView = {
        let textField = UITextView()
        textField.textAlignment = .natural
        textField.font = .systemFont(ofSize: 17)
        textField.layer.borderWidth = 0.1
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
                
        view.addSubview(textField1)
        view.addSubview(textField2)
        
        textField1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(340)
        }
        
        textField2.snp.makeConstraints { make in
            make.top.equalTo(textField1.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(340)
            make.height.equalTo(450)
        }
    }
    
    @objc func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonPressed() {
        viewModel.list.append(ToDoListModel(title: textField1.text ?? "", description: textField2.text ?? ""))
        let name = Notification.Name("addNotification")
        NotificationCenter.default.post(name: name, object: viewModel.list)

        dismiss(animated: true, completion: nil)
    }
}
