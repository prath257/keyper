//
//  UpdateAccountViewController.swift
//  Keyper
//
//  Created by Prathamesh Vaidya on 21/08/17.
//  Copyright © 2017 Prathamesh Vaidya. All rights reserved.
//

import UIKit
import RealmSwift

protocol UpdateAccountViewControllerDelegate {
    func sendValue( value:Account)
}

class UpdateAccountViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var masterAcc: UISwitch!
    @IBOutlet weak var accTitle: UITextField!
    @IBOutlet weak var accUname: UITextField!
    @IBOutlet weak var accEmail: UITextField!
    @IBOutlet weak var accMob: UITextField!
    @IBOutlet weak var accPwd: UITextField!
    @IBOutlet weak var socialLoginPicker: UIPickerView!
    
    var accounts = [Account]()
    var social_login:Account? = nil
    let social_login_txt = "Regular"
    
    var delegate:UpdateAccountViewControllerDelegate!

    func configureView() {
        // Update the user interface for the update item.
        if let detail = detailItem {
            navigationItem.title = detail.title
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(updateAccount))

            if detail.socialLogin != nil {
                var i = 0
                for acc in accounts {
                    if acc.title == detail.socialLogin?.title {
                        break
                    }
                    i += 1
                }
                let picker = socialLoginPicker
                picker?.selectRow(i+1, inComponent: 0, animated: true)
                toggleControls(state: false)
            }
            
            if let masterSwitch = masterAcc {
                masterSwitch.isOn = detail.masterInd
            }
            if let textField = accTitle {
                textField.text = detail.title
            }
            if let textField = accUname {
                textField.text = detail.uname
            }
            if let textField = accEmail {
                textField.text = detail.email
            }
            if let textField = accMob {
                textField.text = detail.mob
            }
            if let textField = accPwd {
                textField.text = detail.password
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Loading the pickerview with Master Accounts
        let realm = try! Realm()
        let allAcconts = realm.objects(Account.self)
        let masterAccByTitle = allAcconts.filter("masterInd = true").sorted(byKeyPath: "title")
        for account in masterAccByTitle{
            accounts.append(account)
        }
        
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var detailItem: Account? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    func updateAccount(){
        
        let acc = Account()
        acc.accID = detailItem!.accID
        acc.title = accTitle.text!
        
        if social_login != nil {
            acc.socialLogin = social_login
        }
        else {
            acc.masterInd = masterAcc.isOn
            acc.uname = accUname.text!
            acc.email = accEmail.text!
            acc.mob = accMob.text!
            acc.password = accPwd.text!
        }
        
        let realm = try! Realm()
        
        try! realm.write{
            realm.add(acc, update:true)
        }
        delegate?.sendValue(value: acc)
        self.dismiss(animated: true, completion: nil)
    }
    
    func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //Pickerview implementation
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accounts.count+1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return social_login_txt
        }
        else {
            return accounts[row-1].title
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            social_login = nil
            
            toggleControls(state: true)
        }
        else {
            social_login = accounts[row-1]
            toggleControls(state: false)
        }
    }
    
    func toggleControls(state:Bool){
        let mAcc = masterAcc
        mAcc?.isEnabled=state
        
        var txtbox = accUname
        txtbox?.isEnabled=state
        
        txtbox = accEmail
        txtbox?.isEnabled=state
        
        txtbox = accMob
        txtbox?.isEnabled=state
        
        txtbox = accPwd
        txtbox?.isEnabled=state
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
