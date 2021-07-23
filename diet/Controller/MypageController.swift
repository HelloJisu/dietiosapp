//
//  MypageController.swift
//  diet
//
//  Created by 유지수 on 2021/07/22.
//

import UIKit
import Firebase
import FirebaseAuth

class MypageController: UIViewController {
    
    
    @IBOutlet weak var profileview: UIView!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    
    var name : String = ""
    var image : UIImage?
    var imagepicker : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let namekey = UserDefaults.standard.string(forKey: "name") {
            name = namekey
        }
        
        profileview.layer.cornerRadius = 40
        
        profileimg?.layer.cornerRadius = (profileimg?.frame.size.width ?? 0.0) / 2
        profileimg?.clipsToBounds = true
        
        namelabel.text = name+"님 안녕하세요"
        
        
        imagepicker = UIImagePickerController()
        imagepicker.allowsEditing = true
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backpress(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let imgData = UserDefaults.standard.object(forKey: "profileImage") as? NSData
           {
               if let image = UIImage(data: imgData as Data)
               {
                        self.profileimg.image = image
               }
           }
    }
    @IBAction func presslogout(_ sender: Any) {
        do {
                    try Auth.auth().signOut()
                  } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                  }
        guard let loginpage = self.storyboard?.instantiateViewController(withIdentifier: "login") as? LoginController         else{
            return
        }
        
        //화면 전환 애니메이션을 설정합니다.
        loginpage.modalPresentationStyle = .fullScreen
        
        
        //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출합니다.
        self.present(loginpage, animated: false)
    }
    
    @IBAction func profilebutton(_ sender: Any) {
        self.present(imagepicker, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MypageController: UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil )
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage]{
            profileimg.image = image as! UIImage
            self.image = image as! UIImage
            let jpgImage = (image as! UIImage).jpegData(compressionQuality: 0.1)
            UserDefaults.standard.set(jpgImage, forKey: "profileImage")
            UserDefaults.standard.synchronize()
        }
        picker.dismiss(animated:  true, completion: nil )
    }
}

