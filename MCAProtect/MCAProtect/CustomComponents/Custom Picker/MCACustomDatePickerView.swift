//
//  MCACustomPickerView.swift
//  MCAProtect
//
//  Created by Manjunath on 05/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCACustomDatePickerView: UIView {
    
    var pickerDatasource : Array<String>!
    @IBOutlet weak var pickerView: UIDatePicker!
    
    func setDatasource(dataSource:Array<String>)
    {
        pickerDatasource = dataSource
    }
    
    @IBAction func dataPicked(_ sender: Any)
    {
        self.removeFromSuperview()
    }

}
                                                                                    
