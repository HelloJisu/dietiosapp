//
//  IndexController.swift
//  diet
//
//  Created by 유지수 on 2021/07/12.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var weightpointer: UIImageView!
    @IBOutlet weak var splashview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startanimation()

        // Do any additional setup after loading the view.
    }
    
    func startanimation(){
        
        UIView.animate(withDuration: 0.5, delay: 0,animations: {
            self.weightpointer.transform = CGAffineTransform(translationX: 40, y: 0)
        })
        UIView.animate(withDuration: 0.5, delay: 1, options: [.repeat , .autoreverse],animations: {
            self.weightpointer.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        
    }
    


}
