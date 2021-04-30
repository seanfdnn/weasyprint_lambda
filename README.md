# Weasyprint Lambda Layer for Docker
This repository contains a Dockerfile which will build a AWS Lambda layer containing the native libraries for the WeasyPrint HTML to PDF 

The procedure is based upon the [instructions here](https://aws.amazon.com/premiumsupport/knowledge-center/lambda-linux-binary-package/).

This currently only supports the Python 3.7 runtime, but should be easy to adapt by modifying the base image in the Dockerfile

# How to Build

```
# Build the Docker image, which creates the zip file
docker build -t weasyprint .

# Create an instance of the image (without actually running it)
# this is just so we can copy the zip file out
docker create --name weasyprint weasyprint .
docker cp weasyprint:/opt/weasyprint_lambda_layer.zip .
docker rm weasyprint
```

The `weasyprint_lambda_layer.zip` file can now be uploaded as an AWS Lambda layer

# Using the Library
The `weasyprint` pip package still needs to be included in the deployed package; it is not included in the zip file. Only the native (binary) libraries are included.

The deployed should now support use of WeasyPrint like the below:
```
from weasyprint import HTML
html = HTML(string='<html><body><h1>Hello, world</h1></body></html>')
html.write_pdf('/tmp/hello_world.pdf')
```
