//
//  ViewController.swift
//  subTweet
//
//  Created by Trong Ton on 6/12/18.
//  Copyright © 2018 trong.ton2003@gmail.com. All rights reserved.
//

import UIKit

enum splitTweetToPartStatus: Int {
    case error = -1
    case failed
    case succeed
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tweetTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var sentButton: UIButton!
    var dataSource: Array<String> = []
    var isShowKeyBooard: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputTextView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        inputTextView.layer.cornerRadius = 5;
        inputTextView.layer.borderWidth = 1;
        inputTextView.layer.borderColor = UIColor.black.cgColor
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendButtonPress(_ sender: Any) {
        let inputString = inputTextView.text
        if (inputString?.count)! > 49 {
            var statusSplit: Int = -2
            for maxLenghtOfNumberPart in 1 ..< 50/2 { //for 1 ..< 25 because currentPart/maxPart < 50 character
                statusSplit = self.splipStringMaxCharSlip(inputString!, maxLenghtOfNumberPart)
                if statusSplit == splitTweetToPartStatus.error.rawValue {
                    let alertView = UIAlertController(title: "Alert", message: "Tweet trên là 1 chuỗi span of nonwhite space character", preferredStyle: UIAlertControllerStyle.alert)
                    alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertView, animated: true, completion: nil)
                    return;
                } else if statusSplit == splitTweetToPartStatus.succeed.rawValue {
                    break
                }
            }
            
            if statusSplit == splitTweetToPartStatus.failed.rawValue {
                let alertView = UIAlertController(title: "Alert", message: "Tweet trên don't split to parts", preferredStyle: UIAlertControllerStyle.alert)
                alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertView, animated: true, completion: nil)
                return;
            }
        } else if (inputString?.count)! > 0 {
            dataSource.append(inputString!)
        } else {
            let alertView = UIAlertController(title: "Alert", message: "Cần phải nhập nội dung cho tweet", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
            return;
        }
        
        inputTextView.text = ""
        self.dismissKeyboard()
        tweetTableView.reloadData()
    }
    
    func splipStringMaxCharSlip(_ tweet: String, _ number: Int) -> Int {
        var subStringArr: Array<String> = []
        let inputSplipArr = tweet.split(separator: " ")
        var subStringAdd: String = ""
        var currentIndex: Int = 1

        for splipString in inputSplipArr {
            let lenghtOfCurrentIndex = "\(currentIndex)".count
            let lenghtOfPartAdd: Int = lenghtOfCurrentIndex + number + 1
            
            if lenghtOfCurrentIndex > number || lenghtOfPartAdd > 49 {
                return splitTweetToPartStatus.failed.rawValue
            }
            
            if splipString.count + lenghtOfPartAdd > 49 {
                return splitTweetToPartStatus.error.rawValue;
            }
            
            let teampString = subStringAdd + " \(splipString)"
            if teampString.count + lenghtOfPartAdd > 49 {
                subStringArr.append(String(subStringAdd))
                subStringAdd = " \(splipString)"
                currentIndex += 1
            } else {
                subStringAdd = teampString;
            }
        }
        subStringArr.append(String(subStringAdd))
        var intdex: Int = 1
        for subString in subStringArr {
            dataSource.append(String("\(intdex)/\(subStringArr.count)\(subString)"))
            intdex += 1;
        }
        return splitTweetToPartStatus.succeed.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        let tweetString = dataSource[indexPath.row]
        cell.tweetLable.text = tweetString
        cell.countLable.text = "\(tweetString.count)"
        
        return cell
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardHeight =  (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        if  isShowKeyBooard == false {
            bottomConstraint.constant = keyboardHeight.height;
        }
        isShowKeyBooard = true
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if  isShowKeyBooard == true {
            bottomConstraint.constant = 0;
        }
        isShowKeyBooard = false
    }
    
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
}

