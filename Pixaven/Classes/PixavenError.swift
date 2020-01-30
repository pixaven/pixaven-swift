//
//  PixavenError.swift
//  Pixaven
//
//  Created by Dawid Płatek on 19/11/2019.
//  Copyright © 2019 Pixaven. All rights reserved.
//

enum PixavenError: Error {
    case requestTypeConflict
    case noPathProvided
    case operationNotSupported
    case invalidProxyUrl
    case cannotDetectFileSize
    case cannotCreateStreamFromFile
    case cannotReadStreamFromFile
    case unknownError
}
