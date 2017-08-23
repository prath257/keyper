//
//  AccountViewController.swift
//  Keyper
//
//  Created by Prathamesh Vaidya on 06/08/17.
//  Copyright © 2017 Prathamesh Vaidya. All rights reserved.
//

import UIKit
import RealmSwift

class AddAccountViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var accounts = [Account]()
    var social_login:Account? = nil
    let social_login_txt = "Regular"
    
    @IBOutlet weak var masterAcc: UISwitch!
    @IBOutlet weak var accTitle: UITextField!
    @IBOutlet weak var accUname: UITextField!
    @IBOutlet weak var accEmail: UITextField!
    @IBOutlet weak var accMob: UITextField!
    @IBOutlet weak var accPwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addAccount))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
        //Loading the pickerview with Master Accounts
        let realm = try! Realm()
        let allAcconts = realm.objects(Account.self)
        let masterAccByTitle = allAcconts.filter("masterInd = true").sorted(byKeyPath: "title")
        for account in masterAccByTitle{
            accounts.append(account)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            let mAcc = masterAcc
            mAcc?.isEnabled=true
            
            var txtbox = accUname
            txtbox?.isEnabled=true
            
            txtbox = accEmail
            txtbox?.isEnabled=true
            
            txtbox = accMob
            txtbox?.isEnabled=true
            
            txtbox = accPwd
            txtbox?.isEnabled=true
        }
        else {
            social_login = accounts[row-1]
            
            let mAcc = masterAcc
            mAcc?.isEnabled=false
            
            var txtbox = accUname
            txtbox?.isEnabled=false
            
            txtbox = accEmail
            txtbox?.isEnabled=false
            
            txtbox = accMob
            txtbox?.isEnabled=false
            
            txtbox = accPwd
            txtbox?.isEnabled=false
        }
    }
    
    //View functionality
    func addAccount(){
        
        let acc = Account()
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
            realm.add(acc)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func cancel(){
        self.dismiss(animated: true, completion: nil)
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
