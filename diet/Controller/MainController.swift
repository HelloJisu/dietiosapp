//
//  ViewController.swift
//  diet
//
//  Created by 유지수 on 2021/07/10.
//

import UIKit
import WebKit
import SystemConfiguration

class MainController: UIViewController,WKUIDelegate,WKNavigationDelegate {
    
    @IBOutlet weak var splashview: UIView!
    @IBOutlet weak var rightimg: UIImageView!
    @IBOutlet weak var record: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var runanimation: UIImageView!
    @IBOutlet weak var day: UILabel!
    @IBOutlet var webview: WKWebView!
    @IBOutlet weak var moncheck: UIImageView!
    @IBOutlet weak var tuecheck: UIImageView!
    @IBOutlet weak var wedcheck: UIImageView!
    @IBOutlet weak var thucheck: UIImageView!
    @IBOutlet weak var fricheck: UIImageView!
    @IBOutlet weak var satcheck: UIImageView!
    @IBOutlet weak var suncheck: UIImageView!
    @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var weightpointer: UIImageView!
    
    
    var date : String = ""
    let today = NSDate() //현재 시각 구하기
    let dateFormatter = DateFormatter()
    
    
    var javaavgstring : [String] = ["0.3","0.4","0.5"]
    var javaavg : String = ""
    var javaresult : String = ""
    var javastring : [String] = ["0.7","0.7","0.7"]
    
    var yearint : Int = 0
    var monthint : Int = 0
    var dayint : Int = 0
    
    var todayyear : Int = 0
    var todaymonth : Int = 0
    var todayday : Int = 0
    
    func loadWebPage(_ url: String) {
        print("왜안돼")
        javaresult += javastring[0]
        javaavg += javaavgstring[0]
        print(javastring)
        print(javaavg)
        
        for i in 1..<javastring.count{
            javaresult =  javaresult + "/" + javastring[i]
            print(javaresult)
        }
        
        for i in 1..<javaavgstring.count{
            javaavg =  javaavg + "/" + javaavgstring[i]
            print(javaavg)
        }
        
        // url에 공백이나 한글이 포함되었있을 경우, 에러가 발생하니 url을 인코딩
        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        webview.uiDelegate = self as! WKUIDelegate
        webview.navigationDelegate = self as! WKNavigationDelegate
        
        print("여기까지는 실행")
        let myUrl = URL(string: escapedString!)
        let myRequest = URLRequest(url: myUrl!)
        webview.load(myRequest)
        
        print("s"+javaresult)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        print("들어옴?")
        let scriptString = "init()"
        
        webview.evaluateJavaScript("init('\(javaresult)', '\(javaavg)')", completionHandler: {(result, error) in
            if let result = result {
                print("ㄱㄷㄴㄷ")
                print(result)  // Javascript 함수 complete()에서 반환한 값을 표시
            }
        })
    }
    
    
    func webViewDidFinishLoad(webView: WKWebView) {
        
        print("안들어왔지")
        
        javaresult += javastring[0]
        
        for i in 1..<javastring.count-1{
            javaresult =  javaresult + "/" + javastring[i]
        }
        
        
    }
    
    //영어요일 구하는 함수
    func weekday() -> String? {
        
        let calendar = Calendar(identifier: .gregorian)
        
        guard let targetDate: Date = {
            let comps = DateComponents(calendar:calendar, year: yearint, month: monthint, day: dayint)
            return comps.date
        }() else { return nil }
        
        let day = Calendar.current.component(.weekday, from: targetDate) - 1
        
        return Calendar.current.shortWeekdaySymbols[day]
    }
    
    func printweek(day : String) -> String? {
        
        var weekend : String = ""
        
        switch day {
        case "Mon":
            weekend = "월요일";
        case "Tue":
            weekend = "화요일";
        case "Wed":
            weekend = "수요일";
        case "Thu":
            weekend = "목요일";
        case "Fri":
            weekend = "금요일";
        case "Sat":
            weekend = "토요일";
        case "Sun":
            weekend = "일요일";
        default:
            break
        }
        return weekend;
    }
    
    func settoday(){
        var formatter_year = DateFormatter()
        formatter_year.dateFormat = "yyyy"
        var yearstring = formatter_year.string(from: Date())
        
        var formatter_month = DateFormatter()
        formatter_month.dateFormat = "MM"
        var monthstring = formatter_month.string(from: Date())
        
        var formatter_day = DateFormatter()
        formatter_day.dateFormat = "dd"
        var daystring = formatter_day.string(from: Date())
        
        print("야"+yearstring+monthstring+daystring)
        
        yearint = Int(yearstring)!
        monthint = Int(monthstring)!
        dayint = Int(daystring)!
        todaymonth = monthint
        todayday = dayint
        todayyear = yearint
    }
    
    func startanimation(){
        
        UIView.animate(withDuration: 0.5, delay: 0,animations: {
            self.weightpointer.transform = CGAffineTransform(translationX: 45, y: 0)
        })
        UIView.animate(withDuration: 0.5, delay: 1, options: [.repeat , .autoreverse],animations: {
            self.weightpointer.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        
    }
    
    func yesterday(year : Int, month : Int, day : Int) {
        var newyear : Int = 0
        var newmonth: Int = 0
        var newday: Int = 0
        
        if(day == 1 && month == 1){
            yearint = year-1
            monthint = 12
            dayint = 31
            
        }
        else if(day==1){
            monthint = monthint-1
            if(month == 3){
                dayint = 28
            }
            else if( month == 5 || month == 7 || month == 8 || month == 10 || month == 12){
                dayint = 30
            }
            else{
                dayint = 31
            }
        }
        else{
            dayint = day - 1
        }
        
    }
    
    func tommorrow(year : Int, month : Int, day : Int) -> Bool?{
        var newyear : Int = 0
        var newmonth: Int = 0
        var newday: Int = 0
        var bool : Bool = false
        
        print(todayyear)
        print(todaymonth)
        print(todayday)
        print(yearint)
        print(monthint)
        print(dayint)
        
        if(todayyear == year && todaymonth == month && todayday == day+1){
            yearint = year
            monthint = month
            dayint = day + 1
            bool = true
        }else{
            
            if(day == 31 && month == 12){
                yearint = year+1
                monthint = 1
                dayint = 1
                bool = false
            }
            else if(day == 31){
                monthint = month + 1
                dayint = 1
                bool = false
            }
            else if(day == 30){
                monthint = month + 1
                dayint = 1
                bool = false
            }else{
                dayint = dayint + 1
            }
            
        }
        
        return bool
    }
    
    @IBAction func backpress(_ sender: Any) {
        yesterday(year: yearint, month: monthint, day: dayint)
        day.text = printweek(day: weekday()!)
        rightimg.alpha = 1
        nextbtn.isHidden = false
    }
    
    
    
    @IBAction func nextpress(_ sender: Any) {
        if(tommorrow(year: yearint, month: monthint, day: dayint)!){
            rightimg.alpha = 0.5
            nextbtn.isHidden = true
        }
        day.text = printweek(day: weekday()!)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startanimation()
        
        loadWebPage("http://dbwltn0606.dothome.co.kr")
        settoday()
        day.text = printweek(day: weekday()!)
        
        dateFormatter.dateFormat = "yyyy-mm-dd"
        var yearstring = dateFormatter.string(from: Date())
        
        rightimg.alpha = 0.5
        nextbtn.isHidden = true
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
}


