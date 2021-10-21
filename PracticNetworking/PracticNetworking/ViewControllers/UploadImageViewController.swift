//
//  UploadImageViewController.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 22.10.2021.
//

import UIKit

class UploadImageViewController: UIViewController {
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    
    var backgroundTaskIdentifier:UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressSelectImageButton(_ sender: UIButton) {
        uploadButton.isHidden = false
        setupAlertChangePhoto()
    }
    
    @IBAction func pressUploadButton(_ sender: UIButton) {
        uploadImage()
    }
    
    private func uploadImage() {
        guard let imageData: Data = uploadImageView.image?.jpegData(compressionQuality: 1),
              let url = URLStorage.uploadImage else { return }
        
        let clientId = "5af4a79c42ea7df"
        
        let session = URLSession.shared
        
        DispatchQueue.global().async {
            self.backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(withName: "backgroundTask") {
                UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier)
                self.backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
            }
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Client-ID \(clientId)", forHTTPHeaderField: "Authorization")
        request.httpBody = imageData
        
        session.dataTask(with: request) { data, responce, error in
            guard let responce = responce,
                  let data = data else { return }
            print(responce)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
        
        UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
        backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    }
    
    private func setupAlertChangePhoto() {
        let changePhotoBtn = UIAlertAction(
            title: "Change photo",
            style: .default,
            handler: { _ in
                self.showImagePickerController(sourceType: .photoLibrary)
            })
        
        let chooseCameraBtn = UIAlertAction(
            title: "Choose camera",
            style: .default,
            handler: { _ in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.showImagePickerController(sourceType: .camera)
                } else {
                    let okAction = UIAlertAction(
                        title: "Alright",
                        style: .default,
                        handler: nil)
                                    
                    self.showAlert(title: "", message: "Device has no camera.", action: okAction, type: .alert)
                }
            })
        let cancelBtn = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil)
        
        showAlert(title: "Alert", message: "", action: changePhotoBtn, chooseCameraBtn, cancelBtn, type: .actionSheet)
    }
}

// MARK: - URLSessionDelegate

extension UploadImageViewController: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                  let backgroundCompletionHandler =
                  appDelegate.backgroundCompletionHandler
            else {
                return
            }
            backgroundCompletionHandler()
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension UploadImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            uploadImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            uploadImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}
