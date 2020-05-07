//
//  ViewController.swift
//  McKinley1
//
//  Created by Devesh Tyagi on 07/05/20.
//  Copyright © 2020 deveshtyagi7. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class LoginViewController: UIViewController {
//MARK:- Properties
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailIdTextField: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    let mainUrl = "https://reqres.in/api/login"
    var token = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.textColor = .white
       
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.string(forKey: "token") != nil{
                  performSegue(withIdentifier: "goToWEB", sender: nil)
               }
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
       validateFields()
       
        
    }
    
    func validateFields() {
              
              // Check that all fields are filled in
              if EmailIdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                  ErrorLabel.textColor = .red
                  ErrorLabel.text = "Please fill in all fields."
               
              }else{
                loadWebPage(emailId: EmailIdTextField.text!, password: PasswordTextField.text!)
            }
              
              
          
          }
    
    func loadWebPage(emailId : String ,password : String){
        let parameters = ["email" : EmailIdTextField.text! ,"password" : PasswordTextField.text!]
                       Alamofire.request(mainUrl , method: .post , parameters: parameters).responseJSON { (response) in
                           if response.result.isSuccess{
                            let resposeJSON : JSON = JSON(response.result.value!)
                             let statusCode = (response.response?.statusCode)!
                            if let dict = resposeJSON.object as? [String : Any]{
                                if(statusCode == 200){
                                   
                                    self.token = dict["token"] as! String
                                    UserDefaults.standard.set(self.token, forKey: "token")
                                    UserDefaults.standard.synchronize()
                                    self.performSegue(withIdentifier: "goToWEB", sender: nil)
                                   
                                }
                                else{
                                    
                                    print(statusCode)
                                    self.ErrorLabel.textColor = .red
                                    self.ErrorLabel.text = "Invaild User Id Or Password!"
                                }
                            }
                            
                           }
                        else{
                             print("error\(String(describing: response.result.error))")
                                     
                        }
                       
                   }
        
    }
    

  
        
      
    
    
    
}

