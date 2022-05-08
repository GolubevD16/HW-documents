//
//  ViewController.swift
//  Documents
//
//  Created by Дмитрий Голубев on 02.05.2022.
//

import UIKit

class GallaryViewController: UIViewController {
    
    var images = [UIImage?]()
    var imagesName = [String?]()
    
    lazy var imagePicker: UIImagePickerController = {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        return imagePicker
    }()
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: "MyTable")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setupLayout()
        setUpGallary()
        setUpNotification()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setUpNavBar() {
        navigationController?.isNavigationBarHidden = false
        let rightButtonItem = UIBarButtonItem.init(
              title: "Добавить картинку",
              style: .done,
              target: self,
              action: #selector(addImage)
        )
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    @objc private func addImage(){
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func setUpGallary(){
        for imageURL in Model.getImages(){
            images.append(UIImage(contentsOfFile: imageURL.path))
            imagesName.append(imageURL.lastPathComponent)
        }
        tableView.reloadData()
    }
    
    private func setUpNotification(){
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: nil) { notification in
            self.images = []
            self.imagesName = []
            self.setUpGallary()
        }
    }
    
}

extension GallaryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomCell(style: .default, reuseIdentifier: "MyTable")
        
        cell.customImageView.image = images[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let myImage = self.images[indexPath.row] {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = view.frame.size.width

            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGFloat(scaledHeight + 4)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let name = imagesName[indexPath.row] else { return }
            images.remove(at: indexPath.row)
            imagesName.remove(at: indexPath.row)
            Model.deleteImage(name: name)
            tableView.reloadData()
        }
    }
}

extension GallaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//            images.append(pickedImage)
//            imagesName.append(pickedImageURL.lastPathComponent)
            
            Model.addImage(imageData: pickedImage.jpegData(compressionQuality: 1.0) ?? Data(), name: pickedImageURL.lastPathComponent)
        }
        self.imagesName = []
        self.images = []
        self.setUpGallary()
        self.tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
