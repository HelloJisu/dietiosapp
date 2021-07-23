//
//  RullerController.swift
//  diet
//
//  Created by 유지수 on 2021/07/20.
//

import UIKit

class RullerController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var framset: UIView!
    @IBOutlet weak var startbtn: UIButton!
    
    var setweight : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var frm: CGRect = framset.frame
        var scrollView: UIScrollView!
        
        scrollView = UIScrollView(frame: CGRect(x: frm.origin.x, y: frm.origin.y, width: frm.size.width, height: frm.size.height))
        scrollView.contentSize = CGSize(width: (120.0*150) + (frm.size.width/2), height: frm.size.height)
        scrollView.showsHorizontalScrollIndicator = false
       
        
        let minTemp = 30.0
        let maxTemp = 150.0
        let interval = 0.1


        // LINES
        let lines = UIBezierPath()
        // DRAW TEMP OTHER LINES
        for temp in stride(from: minTemp, to: maxTemp, by: interval)
        {
            let isInteger = floor(temp) == temp
            let isfive = (temp*10).truncatingRemainder(dividingBy: 10) == 5
            
            var height : Double
            
            if (isInteger) {
                height = 60.0
            }
            else if (isfive) {
                height = 50.0
            }
            else{
                height = 30.0
            }
            
            let oneLine = UIBezierPath()
            oneLine.move(to: CGPoint(x: CGFloat((temp-30.0))*150 + (frm.size.width/2), y: 0))
            oneLine.addLine(to: CGPoint(x: (temp-30.0)*150 + (Double(frm.size.width)/2), y: height))
            lines.append(oneLine)
           

            // INDICATOR TEXT
            if(isInteger)
            {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 21))
                label.center = CGPoint(x: (temp-30.0)*150 + (Double(frm.size.width)/2), y: height+15)
                label.font = UIFont(name: "HelveticaNeue",
                                    size: 20.0)
                label.textColor = UIColor.white
                label.textAlignment = .center
                if(isInteger){
                    label.text = "\(Int(temp))"
                }
                scrollView.addSubview(label)
            }
        }

        // DESIGN LINES IN LAYER
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = lines.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 3

        // ADD LINES IN LAYER
        scrollView.layer.addSublayer(shapeLayer)

        view.addSubview(scrollView)
        
        self.view = view
        
        scrollView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setweight = Double(scrollView.contentOffset.x/150.0)
        startbtn.setTitle(String(round(setweight*10)/10 + 30.0), for: .normal)
        startbtn.isEnabled = false
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startbtn.isEnabled = true
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        startbtn.isEnabled = true
    }
    
    @IBAction func pressstart(_ sender: Any) {
        UserDefaults.standard.set(String(round(setweight*10)/10 + 30.0), forKey: "nowweight")
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
