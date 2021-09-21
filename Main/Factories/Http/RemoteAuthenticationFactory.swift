//
//  RemoteAuthenticationFactory.swift
//  Main
//
//  Created by Macbook on 20/09/21.
//

import Foundation
import Data
import Domain

func makeRemoteAuthentication(httpClient: HttpPostClient) -> Authentication {
    let remoteAuthentication = RemoteAuthentication(url: makeApiUrl(path: "login"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAuthentication)
}
