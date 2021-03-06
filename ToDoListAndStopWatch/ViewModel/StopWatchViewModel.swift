//
//  StopWatchViewModel.swift
//  ToDoListAndStopWatch
//
//  Created by Eldiiar on 23/2/22.
//

import UIKit

protocol StopWatchProtocol {
    var model: StopWatchModel {get set}
    var arr: [String] {get set}
    func timerUpdated(pickerView: UIPickerView, label: UILabel, timer: Timer)
    func conditions(label: UILabel)
    func segmentedValueHasChanged(sender: UISegmentedControl, pickerView: UIPickerView, label: UILabel, timer: Timer)
    func startButtonTapped(pickerView: UIPickerView, timer: Timer)
    func restartButtonTapped(pickerView: UIPickerView, label: UILabel, timer: Timer)
    func stopButtonTapped(pickerView: UIPickerView, timer: Timer)
    func pickerViewUpdated(val1: Int, val2: Int, val3: Int)
    func lazy()
}

class StopWatchViewModel: StopWatchProtocol {
    
    var model = StopWatchModel(hour: 0, min: 0, sec: 0, pickerHour: 0, pickerMin: 0, pickerSec: 0, picker: 0)
    var arr: [String] = []
    
    func timerUpdated(pickerView: UIPickerView, label: UILabel, timer: Timer) {
        if model.picker == 0 {
            model.sec += 1
            if model.min == 59 && model.sec == 60 {
                model.min = 0
                model.sec = 0
                model.hour += 1
            }else if model.sec == 60 {
                model.sec = 0
                model.min += 1
            }
        } else if model.picker == 1 && model.sec != 0 || model.min != 0 || model.hour != 0{
            if model.min == 0 && model.sec == 0 {
                model.min = 59
                model.sec = 60
                model.hour -= 1
            }else if model.sec == 0 {
                model.sec = 60
                model.min -= 1
            }
            model.sec -= 1
        } else {
            timer.invalidate()
            pickerView.isHidden = false
            pickerView.selectRow(0, inComponent: 0, animated: false)
            pickerView.selectRow(0, inComponent: 1, animated: false)
            pickerView.selectRow(0, inComponent: 2, animated: false)
        }
        conditions(label: label)
    }
    
    func conditions(label: UILabel) {
        if model.min >= 10 && model.sec >= 10 && model.hour >= 10 {
            label.text = "\(model.hour):\(model.min):\(String(model.sec))"
        }else if model.hour >= 10 && model.sec >= 10{
            label.text = "\(model.hour):0\(model.min):\(String(model.sec))"
        }else if model.hour >= 10 && model.min >= 10{
            label.text = "\(model.hour):\(model.min):0\(String(model.sec))"
        }else if model.hour >= 10{
            label.text = "\(model.hour):0\(model.min):0\(String(model.sec))"
        }else if model.min >= 10 && model.sec >= 10{
            label.text = "0\(model.hour):\(model.min):\(String(model.sec))"
        }else if model.min >= 10  {
            label.text = "0\(model.hour):\(model.min):0\(String(model.sec))"
        }else if model.sec >= 10 {
            label.text = "0\(model.hour):0\(model.min):\(String(model.sec))"
        } else {
            label.text = "0\(model.hour):0\(model.min):0\(String(model.sec))"
        }
    }
    
    func segmentedValueHasChanged(sender: UISegmentedControl, pickerView: UIPickerView, label: UILabel, timer: Timer){
        if sender.selectedSegmentIndex == 1 {
            pickerView.isHidden = false
            model.hour = 0
            model.min = 0
            model.sec = 0
            
            model.picker = 1
            label.text = "00:00:00"
            timer.invalidate()
        } else if sender.selectedSegmentIndex == 0 {
            pickerView.isHidden = true
            model.hour = 0
            model.min = 0
            model.sec = 0

            model.picker = 0
            label.text = "00:00:00"
            timer.invalidate()
        }
    }
    
    func startButtonTapped(pickerView: UIPickerView, timer: Timer) {
        timer.invalidate()
        if model.picker == 1 {
            pickerView.isHidden = true
            model.hour = model.pickerHour
            model.min = model.pickerMin
            model.sec = model.pickerSec
        }
    }
    
    func stopButtonTapped(pickerView: UIPickerView, timer: Timer) {
        timer.invalidate()

        if model.picker == 1 {
            pickerView.isHidden = false
            
            pickerView.selectRow(model.hour, inComponent: 0, animated: true)
            pickerView.selectRow(model.min, inComponent: 1, animated: true)
            pickerView.selectRow(model.sec, inComponent: 2, animated: true)
            
            model.pickerHour = model.hour
            model.pickerMin = model.min
            model.pickerSec = model.sec
        }
    }
    
    func restartButtonTapped(pickerView: UIPickerView, label: UILabel, timer: Timer) {
        timer.invalidate()

        if model.picker == 1 {
            pickerView.isHidden = false
        }
        
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.selectRow(0, inComponent: 1, animated: true)
        pickerView.selectRow(0, inComponent: 2, animated: true)
        model.sec = 0
        model.min = 0
        model.hour = 0
        
        model.pickerHour = 0
        model.pickerMin = 0
        model.pickerHour = 0
        
        label.text = "00:00:00"
    }
    
    func pickerViewUpdated(val1: Int, val2: Int, val3: Int) {
        model.pickerHour = val1
        model.pickerMin = val2
        model.pickerSec = val3
    }
    
    func lazy(){
        for i in 0...59 {
            arr.append(String(i))
        }
    }
}
