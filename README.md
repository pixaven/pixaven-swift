[![Pixaven](media/readme-header.png "Pixaven: GPU-powered Image Processing Platform")](https://www.pixaven.com)

<p align="center">
Pixaven is a modern, GPU-powered image processing API.<br>We transform, enhance, adjust, crop, stylize, filter and watermark your images with blazing speed.
</p>

---
<p align="center">
<strong>The official Swift integration for the Pixaven API.</strong><br>
<br>
<img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"/>
<img src="https://img.shields.io/cocoapods/v/Pixaven?style=flat&color=success"/>
<img src="https://img.shields.io/github/issues-raw/pixaven/pixaven-node?style=flat&color=success"/>
<img src="https://img.shields.io/twitter/follow/pixaven?label=Follow%20Us&style=flat&color=success&logo=twitter"/>
</p>

---

### Documentation
See the [Pixaven API docs](https://docs.pixaven.com/).


### Installation with Carthage

Carthage is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application. You can install Carthage with Homebrew using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Pixaven into your Xcode project using Carthage, specify it in your Cartfile:

```bash
github "pixaven/pixaven-swift"
```

### Installation with CocoaPods

```bash
source 'https://github.com/CocoaPods/Specs.git'
pod 'Pixaven', '~> 1.0.1'
```

### Quick examples
Pixaven API enables you to provide your images for processing in two ways - by uploading them directly to the API ([Image Upload](https://docs.pixaven.com/requests/image-upload)) or by providing a publicly available image URL ([Image Fetch](https://docs.pixaven.com/requests/image-fetch)).

You may also choose your preferred [response method](https://docs.pixaven.com/introduction#choosing-response-method-and-format) on a per-request basis. By default, the Pixaven API will return a [JSON response](https://docs.pixaven.com/responses/json-response-format) with rich metadata pertaining to input and output images. Alternatively, you can use [binary responses](https://docs.pixaven.com/responses/binary-responses). When enabled, the API will respond with a full binary representation of the resulting (output) image. This Swift module exposes two convenience methods for interacting with binary responses: `.toFile()` and `.toBuffer()`.

#### Image upload
Here is a quick example of uploading a local file for processing. It calls `.toJSON()` at a final step and instructs the API to return a JSON response.

```swift
// Pass your Pixaven API Key to the constructor
let client = PixavenClient(key: "YOUR-API-KEY")

// Upload an image from disk and resize it to 1024 x 768,
// using 'fit' mode and gravity set to 'bottom'
let fileUrl = Bundle.main.url(forResource: "sample", withExtension: "jpg")!
let parameters: [String : Any] = ["width": 1024, "height": "768", "mode": "fit", "gravity": "bottom"]

do {
    try client.upload(fileUrl: fileUrl).resize(parameters).toJson() { [weak self] (result) in
        switch (result) {
        case .success(let data):
            DispatchQueue.main.async {
                let response = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(response!)
            }
        case .failure(let error):
            DispatchQueue.main.async {
                print(error)
            }
        }
    }
} catch let error {
    print(error)
}
```

#### Image fetch
If you already have your source visuals publicly available online, we recommend using Image Fetch by default. That way you only have to send a JSON payload containing image URL and processing steps. This method is also much faster than uploading a full binary representation of the image.

```swift
// Pass your Pixaven API Key to the constructor
let client = PixavenClient(key: "YOUR-API-KEY")

// Provide a publicly available image URL with `.fetch()` method
// and resize it to 1024 x 768 using 'fit' mode and gravity set to 'bottom'
let imageURL = URL(string: "https://www.website.com/image.jpg")!
let parameters: [String : Any] = ["width": 1024, "height": "768", "mode": "fit", "gravity": "bottom"]

do {
    try client.fetch(url: imageURL).resize(parameters).toJson() { [weak self] (result) in
        switch (result) {
        case .success(let data):
            DispatchQueue.main.async {
                let response = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(response!)
            }
        case .failure(let error):
            DispatchQueue.main.async {
                print(error)
            }
        }
    }
} catch let error {
    print(error)
}
```

### License
This software is distributed under the MIT License. See the [LICENSE](LICENSE) file for more information.

<p align="center"><br><br><a href="https://www.pixaven.com"><img src="media/logo-mono-light.png" alt="Pixaven" width="165" height="42"/></a></p>