//
//  QuoteBuilderVC.swift
//  QuotePro
//
//  Created by Aaron Chong on 2/28/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

import UIKit

protocol QuoteBuilderVCDelegate {
    func didSaveQuote(userQuotesPhotos: UserQuotesPhotos)
}


class QuoteBuilderVC: UIViewController {

    var quote: Quote?
    var photo: Photo?
    var userQuotesPhotos: UserQuotesPhotos?
    var savedQuotesArray = [UserQuotesPhotos]()
    var delegate: QuoteBuilderVCDelegate?

    @IBOutlet weak var quoteView: QuoteView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        
        if let savedPhoto = photo, let savedQuote = quote{
            let newSavedQuote = UserQuotesPhotos(image: savedPhoto, quote: savedQuote)
            delegate?.didSaveQuote(userQuotesPhotos: newSavedQuote)
        }
    }

    
    
    

    @IBAction func generateQuote(_ sender: UIButton) {
        
        var components = URLComponents(string:"https://api.forismatic.com")
        components?.path = "/api/1.0/"

        let queryItem1 = URLQueryItem(name: "method", value: "getQuote")
        let queryItem2 = URLQueryItem(name: "format", value: "json")
        let queryItem3 = URLQueryItem(name: "lang", value: "en")
        
        components?.queryItems = [queryItem1, queryItem2, queryItem3]
        
        let url = components?.url
        guard let urlWithComponents = url else {
            fatalError("generateQuote - Error with combining URL components")
        }
        
        var request = URLRequest(url: urlWithComponents)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print("error: \(error!.localizedDescription)")
                return
            }
            
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("generateQuote URL Session Task: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("generateQuote URL Session Task Failed: %@", error!.localizedDescription);
                return
            }
            
            do {
                guard let quoteDictionary = try JSONSerialization.jsonObject(with: data) as? Dictionary<String, String> else {
                    print("error serialization")
                    return
                }
                
                let quoteText = quoteDictionary["quoteText"] ?? ""
                let quoteAuthor = quoteDictionary["quoteAuthor"] ?? "Anonymous"
                
                self.quote = Quote(quote: quoteText, personName: quoteAuthor)
                
                OperationQueue.main.addOperation {
                    self.quoteView.quoteTextLabel.text = "\"\(quoteText)\""
                    self.quoteView.authorTextLabel.text = quoteAuthor
                }
                
            } catch {
                print(#line, error.localizedDescription)
            }
        }
        task.resume()
    }

    
    @IBAction func generateImage(_ sender: UIButton) {
        
        var components = URLComponents(string:"https://lorempixel.com")
        components?.path = "/300/300/"
        
        let url = components?.url
        
        guard let urlWithComponents = url else {
            fatalError("generateImage - Error with combining URL components")
        }
        
        var request = URLRequest(url: urlWithComponents)
        request.httpMethod = "GET"
    
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print("generateImage error: \(error!.localizedDescription)")
                return
            }
            
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("generateImage URL Session Task: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("generateImage URL Session Task Failed: %@", error!.localizedDescription);
                return
            }
            
            self.photo = Photo(image: UIImage(data: data))
            if let validImage = self.photo?.image {
                
                OperationQueue.main.addOperation {
                    self.quoteView.photoView.image = validImage
                }
            }
        }
        task.resume()
    }
    
}
