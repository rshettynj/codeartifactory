echo "installing twine requirement keyrings"
pip3 install keyrings.alt

echo "Preparing Python package.."
mkdir -p /tmp/package && cd /tmp/package
touch LICENSE README.md setup.py tests
mkdir python && cd python
touch __init__.py

cd /tmp/package
cat <<EOF >setup.py
import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="boto3-botocore-requests", # Replace with your own username
    version="0.0.1",
    author="John Doe",
    author_email="author@example.com",
    description="A small example package",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://johndoe.com/pypa/sampleproject",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
)
EOF

echo "Updating Boto3  to 1.10.27 and Botocore to 1.13.27 version"
echo "boto3==1.10.45" >/tmp/requirements.txt
echo "botocore==1.13.45" >>/tmp/requirements.txt
echo "requests==2.21.0" >>/tmp/requirements.txt
mkdir -p /tmp/package/python && cd /tmp/package/python && pip3 -q install -r /tmp/requirements.txt -t .
#cd /tmp/package
#zip -qr /tmp/lambda_layer.zip python

cd /tmp/package && pip3 -q install --user --upgrade setuptools wheel && python3 setup.py sdist bdist_wheel >/tmp/null

#ls -la /tmp/lambda_layer.zip

cd /tmp/package/dist
ls -la

echo "lambda_layer.zip file is created containing python modules.."

/bin/aws codeartifact login --tool twine --repository pypi-store --domain test-domain --domain-owner $1
echo "Uploading Package"
twine upload --repository codeartifact /tmp/package/dist/*
