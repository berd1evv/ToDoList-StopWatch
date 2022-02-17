//
//  StopWatchViewController.swift
//  ToDoListAndStopWatch
//
//  Created by Eldiiar on 8/2/22.
//

import UIKit

class StopWatchViewController: ViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var sec = 0
    var min = 0
    var hour = 0
    
    var sec1 = 0
    var min1 = 0
    var hour1 = 0
    
    var picker = 0
    var timer = Timer()
    
    var arr: [String] = []
    
    
    func lazy() {
        for i in 0...59 {
            arr.append(String(i))
        }
    }
    
// MARK: Components
    
    let pickerView: UIPickerView = {
        let p = UIPickerView()
        p.frame = CGRect(x: 30, y: 240, width: 360, height: 270)
        return p
    }()
    
    let restartButton: UIButton = {
        let rb = UIButton()
        rb.frame = CGRect(x: 60, y: 620, width: 80, height: 60)
        rb.backgroundColor = .black
        rb.setTitle("Restart", for: .normal)
        rb.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        rb.layer.cornerRadius = 30
        return rb
    }()
    
    let stopButton: UIButton = {
        let sb = UIButton()
        sb.frame = CGRect(x: 160, y: 620, width: 80, height: 60)
        sb.backgroundColor = .black
        sb.setTitle("Stop", for: .normal)
        sb.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        sb.layer.cornerRadius = 30
        return sb
    }()
    
    let startButton: UIButton = {
        let stb = UIButton()
        stb.frame = CGRect(x: 260, y: 620, width: 80, height: 60)
        stb.backgroundColor = .black
        stb.setTitle("Start", for: .normal)
        stb.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        stb.layer.cornerRadius = 30
        return stb
    }()
    
    let label: UILabel = {
        let l = UILabel()
        l.frame = CGRect(x: 120, y: 180, width: 170, height: 60)
        l.text = "00:00:00"
        l.font = .systemFont(ofSize: 37)
        return l
    }()
    
    let mySegmentedControl: UISegmentedControl = {
        let s = UISegmentedControl(items: ["StopWatch", "Timer"])
        let mySegmentedControl = UISegmentedControl()
        let xPostion:CGFloat = 100
        let yPostion:CGFloat = 150
        let elementWidth:CGFloat = 200
        let elementHeight:CGFloat = 30
               
        s.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
        s.selectedSegmentIndex = 0
        s.tintColor = .yellow
        s.backgroundColor = .white
        s.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        return s
    }()
    
// MARK: ViewDidLoad
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        let layout = view.layoutMarginsGuide

        
        lazy()
        pickerView.isHidden = true
        pickerView.dataSource = self
        pickerView.delegate = self
        
        view.addSubview(mySegmentedControl)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(restartButton)
        view.addSubview(pickerView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: mySegmentedControl.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            
            mySegmentedControl.topAnchor.constraint(equalTo: layout.topAnchor),
            mySegmentedControl.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            
            pickerView.topAnchor.constraint(equalTo: label.bottomAnchor),
            pickerView.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            
            stopButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20),
            stopButton.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            stopButton.widthAnchor.constraint(equalToConstant: 80),
            stopButton.heightAnchor.constraint(equalToConstant: 60),
            
            startButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20),
            startButton.leadingAnchor.constraint(equalTo: stopButton.trailingAnchor,constant: 10),
            startButton.widthAnchor.constraint(equalToConstant: 80),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            
            restartButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20),
            restartButton.trailingAnchor.constraint(equalTo: stopButton.leadingAnchor, constant: -10),
            restartButton.widthAnchor.constraint(equalToConstant: 80),
            restartButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

// MARK: PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let val1 = arr[pickerView.selectedRow(inComponent: 0)]
        let val2 = arr[pickerView.selectedRow(inComponent: 1)]
        let val3 = arr[pickerView.selectedRow(inComponent: 2)]
        hour1 = Int(val1) ?? 0
        min1 = Int(val2) ?? 0
        sec1 = Int(val3) ?? 0
        
    }

// MARK: Functions
    
    @objc func restartButtonTapped() {
        timer.invalidate()
//        startButton.image = UIImage(systemName: "play.circle.fill")
//        pauseButton.image = UIImage(systemName: "pause.circle.fill")
//        resetButton.image = UIImage(systemName: "stop.circle")
        if picker == 1 {
            pickerView.isHidden = false
        }
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.selectRow(0, inComponent: 1, animated: true)
        pickerView.selectRow(0, inComponent: 2, animated: true)
        sec = 0
        min = 0
        hour = 0
        
        sec1 = 0
        min1 = 0
        hour1 = 0
        label.text = "00:00:00"
    }
    
    @objc func stopButtonTapped() {
        timer.invalidate()
//        startButton.image = UIImage(systemName: "play.circle.fill")
//        pauseButton.image = UIImage(systemName: "pause.circle")
//        resetButton.image = UIImage(systemName: "stop.circle.fill")
        if picker == 1 {
            pickerView.isHidden = false
            
            pickerView.selectRow(hour, inComponent: 0, animated: true)
            pickerView.selectRow(min, inComponent: 1, animated: true)
            pickerView.selectRow(sec, inComponent: 2, animated: true)
            
            hour1 = hour
            min1 = min
            sec1 = sec
        }

    }
    
    @objc func startButtonTapped() {
        timer.invalidate()
//        startButton.image = UIImage(systemName: "play.circle")
//        pauseButton.image = UIImage(systemName: "pause.circle.fill")
//        resetButton.image = UIImage(systemName: "stop.circle.fill")
        if picker == 1 {
            pickerView.isHidden = true
            hour = hour1
            min = min1
            sec = sec1
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(StopWatchViewController.update), userInfo: nil, repeats: true)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!){
        if sender.selectedSegmentIndex == 1 {
            pickerView.isHidden = false
            sec = 0
            min = 0
            hour = 0
            
            sec1 = 0
            min1 = 0
            hour1 = 0
            picker = 1
            label.text = "00:00:00"
            timer.invalidate()
        } else if sender.selectedSegmentIndex == 0 {
            pickerView.isHidden = true
            sec = 0
            min = 0
            hour = 0
            
            sec1 = 0
            min1 = 0
            hour1 = 0
            
            picker = 0
            label.text = "00:00:00"
            timer.invalidate()
        }
    }
    
    func conditions() {
        if min >= 10 && sec >= 10 && hour >= 10 {
            label.text = "\(hour):\(min):\(String(sec))"
        }else if hour >= 10 && sec >= 10{
            label.text = "\(hour):0\(min):\(String(sec))"
        }else if hour >= 10 && min >= 10{
            label.text = "\(hour):\(min):0\(String(sec))"
        }else if hour >= 10{
            label.text = "\(hour):0\(min):0\(String(sec))"
        }else if min >= 10 && sec >= 10{
            label.text = "0\(hour):\(min):\(String(sec))"
        }else if min >= 10  {
            label.text = "0\(hour):\(min):0\(String(sec))"
        }else if sec >= 10 {
            label.text = "0\(hour):0\(min):\(String(sec))"
        } else {
            label.text = "0\(hour):0\(min):0\(String(sec))"
        }
    }
    
    @objc func update() {
        if picker == 0 {
            sec += 1
            if min == 59 && sec == 60 {
                min = 0
                sec = 0
                hour += 1
            }else if sec == 60 {
                sec = 0
                min += 1
            }
        } else if picker == 1 && sec != 0 || min != 0 || hour != 0{
            if min == 0 && sec == 0 {
                min = 59
                sec = 60
                hour -= 1
            }else if sec == 0 {
                sec = 60
                min -= 1
            }
            sec -= 1
        }
        conditions()
    }
    
}
