//
//  MaskRef.swift
//  DatingApp
//
//  Created by Laurent Azarnouche on 12/28/20.
//

import Foundation


let maskLocalURL = [Bundle.main.url(forResource: "art.scnassets/surgical_mask/surgical_mask.scn", withExtension: nil)]

let meshLocalURL  = [ URL(string: "art1.jpg"),
               URL(string: "art2.jpg"),
               URL(string: "keith.jpg"),
               URL(string: "clouds.jpg")]


let masktextures = [URL(string:"art.scnassets/surgical_mask/cycles_surgical_mask_ORMA.png"),
                    
                    URL(string:"art.scnassets/surgical_mask/cycles_surgical_mask_BaseColor.png"),
                       
                    URL(string:"art.scnassets/surgical_mask/UV-LAYOUT---surgical_mask.png")
                       ]

var maskOptions = MaskModel(fromlocal: maskLocalURL, fromremote: MaskApi.maskRemoteURL)

let textureOptions = MaskModel(fromlocal: meshLocalURL , fromremote: MaskApi.meshRemoteURL)



