//
//  CustomLocationPopupView.swift
//  WikipediaTest
//
//  Created by Parul Vats on 13/07/2020.
//  Copyright © 2020 Tekhsters. All rights reserved.
//

import UIKit

class CustomLocationPopupView: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.makeLayer(color: .lightGray, boarderWidth: 1.0, round: 8.0)
        }
    }
    
    @IBOutlet weak var latitudeTextField: UITextField! {
        didSet {
            latitudeTextField.placeholder = "Latitude"
            latitudeTextField.delegate = self
        }
    }
    
    @IBOutlet weak var longitudeTextField: UITextField! {
        didSet {
            longitudeTextField.placeholder = "Longitude"
            longitudeTextField.delegate = self
        }
    }
    
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.roundCorners(4.0)
        }
    }
    
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.roundCorners(4.0)
            submitButton.backgroundColor = .lightGray
            submitButton.isUserInteractionEnabled = false
        }
    }
    
    //MARK: - Variables
    fileprivate var strLatitude: String = ""
    fileprivate var strLongitude: String = ""
    private var submitButtonTapCompletion: ((_ lat: String, _ long: String) -> Void)?
    
    //MARK: - Private Methods
    private func initView() -> AnyObject {
        self.isUserInteractionEnabled = true
        return self
    }
    
    private func showWithView(view: UIView, animated : Bool) {
        let rect = view.frame
        self.frame = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        view.addSubview(self)
        if animated {
            self.fadeIn()
        }
    }
    
    //MARK: - Public Methods
    //Initialization Methods
    class func instancefromNib() -> CustomLocationPopupView? {
        if let view = UINib(nibName:CustomLocationPopupView.className, bundle:nil).instantiate(withOwner:nil, options:nil)[0] as? CustomLocationPopupView {
            
            return view
        }
        return nil
    }
    
    func initializeViewWith(handler: ((_ lat: String, _ long: String) -> Void)?) {
        if self === self.initView() {
            self.submitButtonTapCompletion = handler
        }
    }
    
    //Show view with animation
    func showWithAnimated(animated : Bool) {
        if #available(iOS 13.0, *) {
            guard let keywindow = Constants.Devices.keyWindow else {
                return
            }
            self.showWithView(view: keywindow, animated: animated)
        } else {
            guard let keywindow = UIApplication.shared.keyWindow else {
                return
            }
            self.showWithView(view: keywindow, animated: animated)
        }
    }
    
    //Method to check if coordinates entered are valid
    func checkForValidCoordinates() {
        guard let lat = Double(strLatitude), let long = Double(strLongitude), Utilities.isValidLocation(latitude: lat, longitude: long) else {
            self.submitButton.backgroundColor = .lightGray
            self.submitButton.isUserInteractionEnabled = false
            return
        }
        
        self.submitButton.backgroundColor = .systemBlue
        self.submitButton.isUserInteractionEnabled = true
    }
    
    //MARK: - IBActions
    @IBAction func tapCancel(_ sender: UIButton) {
        self.fadeOut()
    }
    
    @IBAction func tapSubmit(_ sender: UIButton) {
        if (self.submitButtonTapCompletion != nil) {
            self.submitButtonTapCompletion!(self.strLatitude, self.strLongitude)
            self.fadeOut()
        }
    }
}

//MARK: - UITextFieldDelegate
extension CustomLocationPopupView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let finalText = text.replacingCharacters(in: textRange, with: string)
            switch textField {
            case self.latitudeTextField:
                self.strLatitude = finalText
            case self.longitudeTextField:
                self.strLongitude = finalText
            default:
                break
            }
            checkForValidCoordinates()
        }
        return true
    }
}
