//
//  Model.swift
//  Documents
//
//  Created by Дмитрий Голубев on 03.05.2022.
//

import Foundation

final class Model{
    static let manager = FileManager.default
    
    static func addImage(imageData: Data, name: String){
        do{
            let imagesURL: URL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(name)
            manager.createFile(atPath: imagesURL.path, contents: imageData, attributes: nil)
        } catch {
            print(error)
        }
    }
    
    static func getImages() -> [URL]{
        var imagesData = [URL]()
        do{
            let imagesURL: URL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let contents = try manager.contentsOfDirectory(at: imagesURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            for file in contents {
                imagesData.append(file.absoluteURL)
            }
            return imagesData
        } catch {
            print(error)
            return []
        }
    }
    
    static func deleteImage(name: String){
        do{
            let imagesURL: URL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            try manager.removeItem(at: imagesURL.appendingPathComponent(name))
        } catch {
            print(error)
        }
    }
}
