FROM lambci/lambda:build-python3.7

# Based on https://aws.amazon.com/premiumsupport/knowledge-center/lambda-linux-binary-package/
RUN yum install -y yum-utils rpmdevtools
WORKDIR /tmp
RUN yumdownloader libffi libffi-devel cairo pango && rpmdev-extract *rpm

RUN mkdir /opt/lib
WORKDIR /opt/lib
RUN cp -P -R /tmp/*/usr/lib64/* /opt/lib
RUN ln libpango-1.0.so.0 pango-1.0 && ln libpangocairo-1.0.so.0 pangocairo-1.0
RUN zip weasyprint_lambda_layer.zip *
