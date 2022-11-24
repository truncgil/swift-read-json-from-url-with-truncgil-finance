//
//  ViewController.swift
//  ReadJSONFileURL
//
//  Created by ProgrammingWithSwift on 2020/03/22.
//  Copyright © 2020 ProgrammingWithSwift. All rights reserved.
//

import UIKit



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let truncgilFinance = try? newJSONDecoder().decode(TruncgilFinance.self, from: jsonData)

import Foundation


struct TruncgilFinance: Codable {
    let updateDate: String
    let usd, eur, gbp, chf: Aed
    let cad, rub, aed, aud: Aed
    let dkk, sek, nok, jpy: Aed
    let kwd, zar, bhd, lyd: Aed
    let sar, iqd, ils, irr: Aed
    let inr, mxn, huf, nzd: Aed
    let brl, idr, csk, pln: Aed
    let ron, cny, ars, all: Aed
    let azn, bam, clp, cop: Aed
    let crc, dzd, egp, hkd: Aed
    let hrk, isk, jod, krw: Aed
    let kzt, lbp, lkr, mad: Aed
    let mdl, mkd, myr, omr: Aed
    let pen, php, pkr, qar: Aed
    let rsd, sgd, syp, thb: Aed
    let twd, uah, uyu, gel: Aed
    let tnd, bgn, ons, gra: Aed
    let cey, yar, tam, cum: Aed
    let ata, res, ham, iki: Aed
    let gre, bes, oda, osa: Aed
    let yia, gum: Aed

    enum CodingKeys: String, CodingKey {
        case updateDate = "Update_Date"
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
        case chf = "CHF"
        case cad = "CAD"
        case rub = "RUB"
        case aed = "AED"
        case aud = "AUD"
        case dkk = "DKK"
        case sek = "SEK"
        case nok = "NOK"
        case jpy = "JPY"
        case kwd = "KWD"
        case zar = "ZAR"
        case bhd = "BHD"
        case lyd = "LYD"
        case sar = "SAR"
        case iqd = "IQD"
        case ils = "ILS"
        case irr = "IRR"
        case inr = "INR"
        case mxn = "MXN"
        case huf = "HUF"
        case nzd = "NZD"
        case brl = "BRL"
        case idr = "IDR"
        case csk = "CSK"
        case pln = "PLN"
        case ron = "RON"
        case cny = "CNY"
        case ars = "ARS"
        case all = "ALL"
        case azn = "AZN"
        case bam = "BAM"
        case clp = "CLP"
        case cop = "COP"
        case crc = "CRC"
        case dzd = "DZD"
        case egp = "EGP"
        case hkd = "HKD"
        case hrk = "HRK"
        case isk = "ISK"
        case jod = "JOD"
        case krw = "KRW"
        case kzt = "KZT"
        case lbp = "LBP"
        case lkr = "LKR"
        case mad = "MAD"
        case mdl = "MDL"
        case mkd = "MKD"
        case myr = "MYR"
        case omr = "OMR"
        case pen = "PEN"
        case php = "PHP"
        case pkr = "PKR"
        case qar = "QAR"
        case rsd = "RSD"
        case sgd = "SGD"
        case syp = "SYP"
        case thb = "THB"
        case twd = "TWD"
        case uah = "UAH"
        case uyu = "UYU"
        case gel = "GEL"
        case tnd = "TND"
        case bgn = "BGN"
        case ons = "ONS"
        case gra = "GRA"
        case cey = "CEY"
        case yar = "YAR"
        case tam = "TAM"
        case cum = "CUM"
        case ata = "ATA"
        case res = "RES"
        case ham = "HAM"
        case iki = "IKI"
        case gre = "GRE"
        case bes = "BES"
        case oda = "ODA"
        case osa = "OSA"
        case yia = "YIA"
        case gum = "GUM"
    }
}

// MARK: - Aed
struct Aed: Codable {
    let buying: String
    let type: TypeEnum
    let selling, change: String
    let name: String?

    enum CodingKeys: String, CodingKey {
        case buying = "Buying"
        case type = "Type"
        case selling = "Selling"
        case change = "Change"
        case name
    }
}

enum TypeEnum: String, Codable {
    case currency = "Currency"
    case gold = "Gold"
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://finans.truncgil.com/v4/today.json"
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }

    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(TruncgilFinance.self,
                                                       from: jsonData)

            print(decodedData.usd.buying)
        } catch {
            print("decode error")
        }
    }
}

