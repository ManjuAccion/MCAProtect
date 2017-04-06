//
//  MCACustomPickerView.swift
//  MCAProtect
//
//  Created by Manjunath on 05/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCACustomPickerView: UIView,UIPickerViewDataSource,UIPickerViewDelegate {

    
    var pickerDatasource : Array<String>!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    func setDatasource(dataSource:Array<String>)
    {
        pickerDatasource = dataSource
        pickerView.reloadAllComponents()
    }
    
    @IBAction func dataPicked(_ sender: Any)
    {
        self.removeFromSuperview()
    }
    
    
    //MARK: - PickerView Datasource and Delegates
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerDatasource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDatasource[row]
    }

}
