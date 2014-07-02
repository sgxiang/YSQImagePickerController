# YSQImagePickerController
========================

## Usage

`#import "YSQImagePicker.h"`

```obj-c
YSQImagePickerViewController *picker = [[YSQImagePickerViewController alloc]init];
picker.maxSelectImageCount = 10;   //Set max count  .  Default is 9
picker.selectedImageArray = _selectedAssetArray;   //Set selected image
[self presentImagePickerController:picker animated:YES completion:nil finish:^(NSMutableArray *array) {
    _selectedAssetArray = array;
    [self resetScrollView];
}];
```
Read select images :

```obj-c
for (int i=0; i<[_selectedAssetArray count]; i++) {
    ALAsset *object = _selectedAssetArray[i];
    UIImage *img = [ASSETHELPER getAssetThumbnail:object];
    //.....
}
```

## License

The MIT License

Copyright (c) 2010 ELC Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
