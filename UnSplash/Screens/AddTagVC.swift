//
//  AddTag.swift
//  UnSplash
//
//  Created by Mutee Ur Rehman on 20/11/2021.
//

import UIKit

protocol AddTagVCDelegate: AnyObject {
    func addTagDidStartEditing()
    func addTagDidEndEditing()
    func addTagAddPressed(tag: String)
    func addTagCancelPressed()
}

class AddTagVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var inputActivityMessageView: UIView!
    @IBOutlet weak var inputActivityMessageTextView: UITextView!
   
    //MARK:- Properties
    weak var delegate: AddTagVCDelegate?
    
    //MARK:- Vc's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculatePreferredSize()
    }
    
    //MARK:- Calculate Preferred Size
    private func calculatePreferredSize() {
      let targetSize = CGSize(width: view.bounds.width,
          height: UIView.layoutFittingCompressedSize.height)
      preferredContentSize = inputActivityMessageView.systemLayoutSizeFitting(targetSize)
    }
    
    //MARK:- IBActions
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if !inputActivityMessageTextView.text!.isEmpty {
            inputActivityMessageTextView.resignFirstResponder()
            delegate?.addTagAddPressed(tag: inputActivityMessageTextView.text!)
            inputActivityMessageTextView.text = ""
        }
    }
   
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        inputActivityMessageTextView.text = ""
        inputActivityMessageTextView.resignFirstResponder()
        delegate?.addTagCancelPressed()
    }
}

//MARK: - TextView Delegates
extension AddTagVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        delegate?.addTagDidStartEditing()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.addTagDidEndEditing()
    }
}



