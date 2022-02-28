//
//  StopWatchViewController.swift
//  ToDoListAndStopWatch
//
//  Created by Eldiiar on 8/2/22.
//

import UIKit
import SnapKit

class StopWatchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let viewModel: StopWatchProtocol
    
    init(vm: StopWatchProtocol = StopWatchViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    var timer = Timer()
    
    
// MARK: COMPONENTS
    
    let pickerView: UIPickerView = {
        let p = UIPickerView()
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    }()
    
    let restartButton: UIButton = {
        let rb = UIButton()
        rb.tintColor = .black
        rb.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 80), forImageIn: .normal)
        rb.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
        rb.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        rb.translatesAutoresizingMaskIntoConstraints = false
        return rb
    }()
    
    let stopButton: UIButton = {
        let sb = UIButton()
        sb.tintColor = .black
        sb.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 80), forImageIn: .normal)
        sb.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        sb.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    let startButton: UIButton = {
        let stb = UIButton()
        stb.tintColor = .black
        stb.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 80), forImageIn: .normal)
        stb.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        stb.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        stb.translatesAutoresizingMaskIntoConstraints = false
        return stb
    }()
    
    let label: UILabel = {
        let l = UILabel()
        l.text = "00:00:00"
        l.font = .systemFont(ofSize: 47)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let mySegmentedControl: UISegmentedControl = {
        let s = UISegmentedControl(items: ["StopWatch", "Timer"])
        let mySegmentedControl = UISegmentedControl()
        s.selectedSegmentIndex = 0
        s.tintColor = .yellow
        s.backgroundColor = .white
        s.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "stopwatch")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        pickerView.isHidden = true
        pickerView.dataSource = self
        pickerView.delegate = self

        
        view.addSubview(mySegmentedControl)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(restartButton)
        view.addSubview(pickerView)
        view.addSubview(label)
        view.addSubview(imageView)
        
        viewModel.lazy()
        setUpConstraints()
    }
    

// MARK: PICKERVIEW
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let val1 = pickerView.selectedRow(inComponent: 0)
        let val2 = pickerView.selectedRow(inComponent: 1)
        let val3 = pickerView.selectedRow(inComponent: 2)
        viewModel.pickerViewUpdated(val1: val1, val2: val2, val3: val3)
    }

// MARK: FUNCTIONS
    
    @objc func restartButtonTapped() {
        viewModel.restartButtonTapped(pickerView: pickerView, label: label, timer: timer)
    }
    
    @objc func stopButtonTapped() {
        viewModel.stopButtonTapped(pickerView: pickerView, timer: timer)
    }
    
    @objc func startButtonTapped() {
        viewModel.startButtonTapped(pickerView: pickerView, timer: timer)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!){
        viewModel.segmentedValueHasChanged(sender: sender, pickerView: pickerView, label: label, timer: timer)
    }
    
    func conditions() {
        viewModel.conditions(label: label)
    }
    
    @objc func update() {
        viewModel.timerUpdated(pickerView: pickerView, label: label, timer: timer)
    }
    
//MARK: CONSTRAINTS
    
    func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        mySegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(mySegmentedControl.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.bounds.size.width)
            make.height.equalTo(240)
        }
        
        stopButton.snp.makeConstraints { make in
            make.top.equalTo(pickerView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(85)
        }
        
        restartButton.snp.makeConstraints { make in
            make.top.equalTo(pickerView.snp.bottom).offset(50)
            make.right.equalTo(stopButton.snp.left).offset(-10)
            make.width.equalTo(90)
            make.height.equalTo(85)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(pickerView.snp.bottom).offset(50)
            make.left.equalTo(stopButton.snp.right).offset(10)
            make.width.equalTo(90)
            make.height.equalTo(85)
        }
    }
    
}
