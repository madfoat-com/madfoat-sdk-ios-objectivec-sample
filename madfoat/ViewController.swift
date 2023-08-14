//
//  ViewController.swift
//  madfoat
//
//  Created by Jyothi Babu on 07/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let userTitle = "Mr"
    let userFirstname = "JB"
    let userLastName = "Pakala "
    let purchaseAmount = "25"
    let EMAIL:String = "test@test.com" // TODO fill email id
    
    //MARK:- LOCAL PROPERTIES
    let storeKey:String = "pQ6nP-7rHt@5WRFv"//"3T4x@bGfnD~4BxHj"
    let storeID = "15996"//"26286"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickPay(_ sender: Any) {
        sendPayment()
    }
    
    func sendPayment(){
        let customBackButton = UIButton(type: .custom)
        customBackButton.setTitle("Cancel", for: .normal)
        customBackButton.setTitleColor(.red, for: .normal)
        
       // paymentRequest = preparePaymentRequest()
        let madFoatController = MadFoatController()
        madFoatController.delegate = self
        madFoatController.customBackButton = customBackButton
        madFoatController.paymentRequest = preparePaymentRequest()
        //self.present(telrController, animated: true, completion: nil)
        self.navigationController?.pushViewController(madFoatController, animated: true)
    }


}

//Mark:- Payment Request Builder
extension ViewController{
    
    private func preparePaymentRequest() -> PaymentRequest{
        let paymentReq = PaymentRequest()
        paymentReq.key = storeKey //KEY
        paymentReq.store = storeID //STOREID
        paymentReq.appId = "123456789"
        paymentReq.appName = "TelrSDK"
        paymentReq.appUser = "123456"
        paymentReq.appVersion = "0.0.1"
        paymentReq.transTest = "1" //0
        paymentReq.transType = "paypage"
        paymentReq.transClass = "ecom"
        paymentReq.transCartid = String(arc4random())
        paymentReq.transDesc = "Test API"
        paymentReq.transCurrency = "AED"
        paymentReq.transAmount = purchaseAmount
        paymentReq.billingEmail = EMAIL
        paymentReq.billingPhone = "8888888888"
        paymentReq.billingFName = userFirstname
        paymentReq.billingLName = userLastName
        paymentReq.billingTitle = userTitle
        paymentReq.city = "Dubai"
        paymentReq.country = "AE"
        paymentReq.region = "dubai"
        paymentReq.address = "line 1"
        paymentReq.zip = "414202"
        paymentReq.language = "en"
        return paymentReq
    }
}

extension ViewController: MadFoatControllerDelegate{
    
    //Mark:- This method will be called when user clicks on back button
    func didPaymentCancel() {
        print("didPaymentCancel")
    }
    
    //Mark:- This method will be called when the payment is completed successfully
    func didPaymentSuccess(response: MadFoatResponseModel) {
        print("didPaymentSuccess")
        print("month \(String(describing: response.month))")
        print("year \(String(describing: response.year))")
        print("Trace \(String(describing: response.trace))")
        print("Status \(String(describing: response.status))")
        print("Avs \(String(describing: response.avs))")
        print("Code \(String(describing: response.code))")
        print("Ca_valid \(String(describing: response.ca_valid))")
        print("Card Code \(String(describing: response.cardCode))")
        print("Card Last4 \(String(describing: response.cardLast4))")
        print("CVV \(String(describing: response.cvv))")
        print("TransRef \(String(describing: response.transRef))")
        
        //To save the card for future transactions, you will be required to store tranRef.
        //When the customer will be attempting transaction using the previously used card tranRef will be used
       // self.displaySavedCard()
    }
    
    //Mark:- This method will be called when user clicks on cancel button and the
    //payment gets failed
    func didPaymentFail(messge: String) {
        print("didPaymentFail  \(messge)")
    }
}



