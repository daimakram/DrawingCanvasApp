//
//  ViewController.swift
//  DrawingCanvas
//
//  Created by Daim Armaghan on 31/08/2023.
//

import UIKit


class ViewController: UIViewController {
    
    let canvas = Canvas()
    var undoButton: UIButton
    var clearButton: UIButton
    var saveButton: UIButton
    var stackView: UIStackView
    
    
    required init?(coder: NSCoder) {
        self.undoButton = UIButton(type: .system)
        self.clearButton = UIButton(type: .system)
        self.saveButton = UIButton(type: .system)
        self.stackView = UIStackView()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStyle()
        setupLayout()
    }
    
    func setupView() {
        view.addSubview(canvas)
        canvas.frame = view.frame
        
        self.undoButton.addTarget(self, action: #selector(undoHandler), for: .touchUpInside)
        self.clearButton.addTarget(self, action: #selector(clearHandler), for: .touchUpInside)
        self.saveButton.addTarget(self, action: #selector(saveHandler), for: .touchUpInside)
        
        self.stackView = UIStackView(arrangedSubviews: [
            self.undoButton,
            self.clearButton,
            self.saveButton
        ])
        
        view.addSubview(self.stackView)
    }
    
    func setupStyle() {
        
        canvas.backgroundColor = .white
        self.undoButton.setTitle("Undo", for: .normal)
        self.clearButton.setTitle("Clear", for: .normal)
        self.saveButton.setTitle("Save", for: .normal)
        
        self.undoButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.clearButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.saveButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
    }
    
    func setupLayout() {
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.distribution = .fillEqually
        
        self.stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc fileprivate func undoHandler(){
        canvas.undo()
    }
    
    @objc fileprivate func clearHandler(){
        canvas.clear()
    }
    
    @objc fileprivate func saveHandler(){
        saveImage()
    }
    
    func saveImage() {
        let selector = #selector(self.onImageSaved(_:error:contextInfo:))
        canvas.takeSnapshot()?.saveToPhotoLibrary(self, selector)
    }

    @objc private func onImageSaved(_ image: UIImage, error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true, completion: nil)
        }
    }
}

