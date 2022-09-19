//
//  MarketData.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/19.
//

/*
 APIRequest: https://api.coingecko.com/api/v3/global#
 
 {
     "data": {
         "active_cryptocurrencies": 12912,
         "upcoming_icos": 0,
         "ongoing_icos": 49,
         "ended_icos": 3376,
         "markets": 574,
         "total_market_cap": {
             "btc": 50100218.85025219,
             "eth": 723828848.2632537,
             "ltc": 18232711849.583355,
             "bch": 8637523793.395784,
             "bnb": 3630172447.1401005,
             "eos": 758920136568.558,
             "xrp": 2683322816902.555,
             "xlm": 8996308073271.422,
             "link": 127674679406.25423,
             "dot": 149288638425.1276,
             "yfi": 115066431.43803164,
             "usd": 977039738834.5538,
             "aed": 3588764664713.2104,
             "ars": 137529973922014.86,
             "aud": 1453198101476.1,
             "bdt": 91792874670148.72,
             "bhd": 364151504021.2887,
             "bmd": 977039738834.5538,
             "brl": 5131608116306.872,
             "cad": 1295574234489.3965,
             "chf": 942417358649.2151,
             "clp": 901192143908829.5,
             "cny": 6819541969117.435,
             "czk": 23940405697702.85,
             "dkk": 7259981712986.67,
             "eur": 976185806102.8127,
             "gbp": 855237079792.7445,
             "hkd": 7669229463193.623,
             "huf": 395629758602583.56,
             "idr": 14626340044246574,
             "ils": 3354744106467.555,
             "inr": 77910181505671.66,
             "jpy": 139675158464440.92,
             "krw": 1355586144218209.8,
             "kwd": 302110457645.033,
             "lkr": 347737783551121.9,
             "mmk": 2028521367418026.8,
             "mxn": 19569324337065.1,
             "myr": 4438203013655.974,
             "ngn": 408126706535074.3,
             "nok": 9963637284932.006,
             "nzd": 1631644639376.8433,
             "php": 56043481100141.41,
             "pkr": 216921285141216.1,
             "pln": 4604568455186.028,
             "rub": 62892051896939.36,
             "sar": 3671422226618.6104,
             "sek": 10507766348124.805,
             "sgd": 1374272831373.0461,
             "thb": 36021569484134.13,
             "try": 17847877044172.754,
             "twd": 30617495272898.234,
             "uah": 35668630488155.71,
             "vef": 97830989049.50389,
             "vnd": 23116760220825580,
             "zar": 17214658566473.797,
             "xdr": 695435391228.1843,
             "xag": 50135455653.85293,
             "xau": 583253642.4946746,
             "bits": 50100218850252.19,
             "sats": 5010021885025219
         },
         "total_volume": {
             "btc": 3468662.130978683,
             "eth": 50113907.14250393,
             "ltc": 1262332153.2132936,
             "bch": 598014387.4646665,
             "bnb": 251333067.70482698,
             "eos": 52543433912.35059,
             "xrp": 185778434780.91092,
             "xlm": 622854627155.3324,
             "link": 8839488842.653803,
             "dot": 10335919853.731388,
             "yfi": 7966563.468892836,
             "usd": 67644829111.15387,
             "aed": 248466221808.18002,
             "ars": 9521814941440.67,
             "aud": 100611401288.81677,
             "bdt": 6355231086189.447,
             "bhd": 25211836613.189117,
             "bmd": 67644829111.15387,
             "brl": 355284171457.6044,
             "cad": 89698396297.97237,
             "chf": 65247766946.7712,
             "clp": 62393561027255.14,
             "cny": 472147378230.03296,
             "czk": 1657501315355.4353,
             "dkk": 502640990745.0504,
             "eur": 67585707530.51075,
             "gbp": 59211886490.0119,
             "hkd": 530975042090.6952,
             "huf": 27391216905754.33,
             "idr": 1012646910344580,
             "ils": 232263932339.47626,
             "inr": 5394070173907.808,
             "jpy": 9670335657657.793,
             "krw": 93853289100062.34,
             "kwd": 20916457609.459934,
             "lkr": 24075441365226.027,
             "mmk": 140443603052416.34,
             "mxn": 1354871811233.127,
             "myr": 307276636237.41736,
             "ngn": 28256436480459.336,
             "nok": 689827153057.974,
             "nzd": 112966052877.67795,
             "php": 3880140746716.549,
             "pkr": 15018430347011.9,
             "pln": 318794859514.31915,
             "rub": 4354297920464.3037,
             "sar": 254188974350.98343,
             "sek": 727499640707.2424,
             "sgd": 95147051993.21785,
             "thb": 2493934294808.0645,
             "try": 1235688319177.3552,
             "twd": 2119786077501.064,
             "uah": 2469498750253.7554,
             "vef": 6773276738.899838,
             "vnd": 1600476656769903,
             "zar": 1191847773075.2441,
             "xdr": 48148101175.07911,
             "xag": 3471101732.422979,
             "xau": 40381257.186194375,
             "bits": 3468662130978.683,
             "sats": 346866213097868.3
         },
         "market_cap_percentage": {
             "btc": 38.232541572827046,
             "eth": 16.68679724911076,
             "usdt": 6.95701082726405,
             "usdc": 5.140178980286611,
             "bnb": 4.503196259294313,
             "busd": 2.1162377435803497,
             "xrp": 1.8590584140879198,
             "ada": 1.563618798416258,
             "sol": 1.150851150803673,
             "doge": 0.790360217014673
         },
         "market_cap_change_percentage_24h_usd": -3.744679145415065,
         "updated_at": 1663550651
     }
 }
 */

import Foundation


struct GlobalMarketData: Codable {
    let data: MarketData
}


struct MarketData: Codable {
    
    let totalMarketCap: [String: Double]
    let totalVolume: [String: Double]
    let marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    

    enum CodingKeys: String, CodingKey {
      
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        
    }
    
    var marketCap: String{
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$ \(item.value.formattedWithAbbreviations())"
        }
        
        return ""
    }
    
    var volume: String{
        if let item = totalVolume.first(where: { $0.key == "usd"}) {
            return "$ \(item.value.formattedWithAbbreviations())"
        }
        
        return ""
    }
    
    var btcDominance: String{
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return "\(item.value.asPercentString())"
        }
        
        return ""
    }
}
