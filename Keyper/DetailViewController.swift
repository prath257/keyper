//
//  DetailViewController.swift
//  Keyper
//
//  Created by Prathamesh Vaidya on 06/08/17.
//  Copyright © 2017 Prathamesh Vaidya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UpdateAccountViewControllerDelegate {

    @IBOutlet weak var lbl_uname: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_mob: UILabel!
    @IBOutlet weak var lbl_pwd: UILabel!
    @IBOutlet weak var accUname: UILabel!
    @IBOutlet weak var accEmail: UILabel!
    @IBOutlet weak var accMob: UILabel!
    @IBOutlet weak var accPwd: UILabel!

    @IBOutlet weak var lbl_social: UILabel!
    @IBOutlet weak var socialLink: UIButton!

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            navigationItem.title = detail.title
            
            let updateButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(updateAcc(_:)))
            navigationItem.rightBarButtonItem = updateButton
            
            
            if detail.socialLogin != nil {
                var label = lbl_uname
                label?.isHidden=true
                
                label = lbl_email
                label?.isHidden=true
                
                label = lbl_mob
                label?.isHidden=true
                
                label = lbl_pwd
                label?.isHidden=true
                
                label = accUname
                label?.isHidden=true
                
                label = accEmail
                label?.isHidden=true
                
                label = accMob
                label?.isHidden=true
                
                label = accPwd
                label?.isHidden=true
                
                label = lbl_social
                label?.isHidden=false
                
                let button = socialLink
                button?.setTitle(detail.socialLogin?.title, for: .normal)
                button?.isHidden=false
            }
            else {
                var label = lbl_social
                label?.isHidden=true
                
                let button = socialLink
                button?.isHidden=true
                
                label = lbl_uname
                label?.isHidden=false
                
                label = lbl_email
                label?.isHidden=false
                
                label = lbl_mob
                label?.isHidden=false
                
                label = lbl_pwd
                label?.isHidden=false
                
                if let label = accUname {
                    label.isHidden=false
                    if detail.uname != "" {
                        label.text = detail.uname
                    }
                    else {
                    label.text = "--"
                    }
                }
                if let label = accEmail {
                    label.isHidden=false
                    if detail.email != "" {
                        label.text = detail.email
                    }
                    else {
                        label.text = "--"
                    }
                }
                if let label = accMob {
                    label.isHidden=false
                    if detail.mob != "" {
                        label.text = detail.mob
                    }
                    else {
                        label.text = "--"
                    }
                }
                if let label = accPwd {
                    label.isHidden=false
                    if detail.password != "" {
                        label.text = detail.password
                    }
                    else {
                        label.text = "--"
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

    func updateAcc(_ sender: Any) {
        self.performSegue(withIdentifier: "updateAccount", sender: self)
    }
    
    func sendValue(value: Account) {
        detailItem=value
        configureView()
    }
    
    @IBAction func openMasterAcc(_ sender: Any) {
        detailItem = detailItem?.socialLogin
        configureView()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateAccount" {
            
            let controller = (segue.destination as! UINavigationController).topViewController as! UpdateAccountViewController
            controller.detailItem = detailItem
            //controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            controller.delegate=self;
            //self.presentingViewController(controller, animated:true, completion: nil)
        }
    }
}

