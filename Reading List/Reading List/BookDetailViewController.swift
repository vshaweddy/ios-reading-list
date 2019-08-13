//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Vici Shaweddy on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    
    var bookController: BookController?
    var book: Book?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        self.titleTextField.text = book?.name
        self.reasonTextView.text = book?.reasonToRead
        
        if book?.name.isEmpty == true {
            titleTextField.text = "Add a new book"
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let title = titleTextField.text,
            !title.isEmpty,
            let reason = reasonTextView.text,
            !reason.isEmpty else { return }
        
        if let book = book {
            bookController?.editBook(book: book, newName: title, newReason: reason)
        } else {
            bookController?.createBook(named: title, reasoned: reason, readStatus: false)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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

extension BookDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            coverImage.image = image
            dismiss(animated: true, completion: nil)
        }
    }
}

