//
//  IndexController.swift
//  diet
//
//  Created by 유지수 on 2021/07/12.
//

import UIKit
import Firebase
import FirebaseAuth

class SigninController: UIViewController {
    
    @IBOutlet weak var passwordfield: UITextField!
    @IBOutlet weak var emailfield: UITextField!
    @IBOutlet weak var namefield: UITextField!
    @IBOutlet weak var weightpointer: UIImageView!
    @IBOutlet weak var splashview: UIView!
    @IBOutlet weak var passwordeye: UIImageView!
    @IBOutlet weak var startbtn: UIButton!
    @IBOutlet weak var startimg: UIImageView!
    
    var namestring : String = ""
    var emailstring : String = ""
    var passwordstring : String = ""
    var passwordclick : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startimg.alpha = 0.5
        startbtn.isHidden = true
        
        emailfield.keyboardType = .emailAddress
        
        passwordfield.addTarget(self, action: #selector(password(textField:)), for: .editingChanged)
        
        emailfield.addTarget(self, action: #selector(email(textField:)), for: .editingChanged)
        
        namefield.addTarget(self, action: #selector(name(textField:)), for: .editingChanged)
        
        startanimation()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func passwordhide(sender: AnyObject) {
        if(passwordclick == true) {
            passwordeye.image = UIImage(named: "openeyes.png")
            passwordfield.isSecureTextEntry = false
        } else {
            passwordeye.image = UIImage(named: "hideeyes.png")
            passwordfield.isSecureTextEntry = true
        }
        
        passwordclick = !passwordclick
    }
    
    @objc func password(textField: UITextField) {
        passwordstring = passwordfield.text!
        check()
    }
    
    @objc func email(textField: UITextField) {
        emailstring=emailfield.text!
        check()
    }
    
    @objc func name(textField: UITextField) {
        namestring=namefield.text!
        check()
    }
    
    func check(){
        if(emailstring != "" && namestring != "" && passwordstring != ""){
            startimg.alpha = 1
            startbtn.isHidden = false
        }else{
            startimg.alpha = 0.5
            startbtn.isHidden = true
        }
    }
    
    
    func startanimation(){
        
        UIView.animate(withDuration: 0.5, delay: 0,animations: {
            self.weightpointer.transform = CGAffineTransform(translationX: 40, y: 0)
        })
        UIView.animate(withDuration: 0.5, delay: 1, options: [.repeat , .autoreverse],animations: {
            self.weightpointer.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        
    }
    
    func splash(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.splashview.isHidden = false
        }
    }
    
    @IBAction func startpress(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailstring, password: passwordstring) { authResult, error in
            
            guard let mainpage = self.storyboard?.instantiateViewController(withIdentifier: "home") as? MainController         else{
                return
            }
            
            //화면 전환 애니메이션을 설정합니다.
            mainpage.modalPresentationStyle = .fullScreen
            
            
            //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출합니다.
            self.present(mainpage, animated: false)
            
        }

    }
    

}
