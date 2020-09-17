//
//  YRPayment.swift
//  YRPayment
//
//  Created by Yassir RAMDANI on 6/27/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import Foundation

public final class YRPayment: NSObject, UITextFieldDelegate {
    public let creditCard: YRPaymentCreditCard
    public var flipOnClick: Bool = true {
        didSet {
            creditCard.flipOnClick = flipOnClick
        }
    }

    public var numberTextField: UITextField! {
        didSet {
            numberTextField.delegate = self
            numberTextField.keyboardType = .numberPad
            numberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    public var numberTextField2: UITextField! {
        didSet {
            numberTextField2.delegate = self
            numberTextField2.keyboardType = .numberPad
            numberTextField2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    public var numberTextField3: UITextField! {
        didSet {
            numberTextField3.delegate = self
            numberTextField3.keyboardType = .numberPad
            numberTextField3.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    public var numberTextField4: UITextField! {
        didSet {
            numberTextField4.delegate = self
            numberTextField4.keyboardType = .numberPad
            numberTextField4.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }

    public var holderNameTextField: UITextField! {
        didSet {
            holderNameTextField.delegate = self
            holderNameTextField.keyboardType = .default
            holderNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }

    public var validityTextField: UITextField! {
        didSet {
            validityTextField.delegate = self
            validityTextField.keyboardType = .numbersAndPunctuation
            validityTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }

    public var cryptogramTextField: UITextField! {
        didSet {
            cryptogramTextField.delegate = self
            cryptogramTextField.keyboardType = .numberPad
            cryptogramTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }

    public init(creditCard: YRPaymentCreditCard, flipOnClick: Bool = true) {
        self.creditCard = creditCard
        self.flipOnClick = flipOnClick
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        creditCard.cardNumber = "\(numberTextField.text!)\(numberTextField2.text!)\(numberTextField3.text!)\(numberTextField4.text!)"
        if textField == numberTextField || textField == numberTextField2 || textField == numberTextField3 || textField == numberTextField4{
            //creditCard.cardNumber = textField.text
            if !creditCard.isFace { creditCard.flip() }
        } else if textField == holderNameTextField {
            creditCard.cardHolderName = textField.text
            if !creditCard.isFace { creditCard.flip() }
        } else if textField == validityTextField {
            creditCard.cardValidity = textField.text
            if !creditCard.isFace { creditCard.flip() }
        } else if textField == cryptogramTextField {
            creditCard.cardCryptogram = textField.text
            if creditCard.isFace { creditCard.flip() }
        }
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        creditCard.unselectAll()
        if textField == numberTextField || textField == numberTextField2 || textField == numberTextField3 || textField == numberTextField4{
            creditCard.cardNumberLabel.select()
            if !creditCard.isFace { creditCard.flip() }
        } else if textField == holderNameTextField {
            creditCard.cardHolderNameLabel.select()
            if !creditCard.isFace { creditCard.flip() }
        } else if textField == validityTextField {
            creditCard.cardValidityLabel.select()
            if !creditCard.isFace { creditCard.flip() }
        } else if textField == cryptogramTextField {
            creditCard.cardCryptogramLabel.select()
            if creditCard.isFace { creditCard.flip() }
        }
    }

    public func textFieldDidEndEditing(_: UITextField) {
        creditCard.unselectAll()
    }

    public func getCardNumber() -> String {
        return creditCard.cardNumber.replacingOccurrences(of: "X", with: "").replacingOccurrences(of: " ", with: "")
    }

    public func getCardHolderName() -> String {
        return creditCard.cardHolderName
    }

    public func getCardValidity() -> String {
        return creditCard.cardValidity
    }

    public func getCardCryptogram() -> String {
        return creditCard.cardCryptogram
    }

    func flip() {
        creditCard.flip()
    }
}
