What is Codeartifact?

AWS Codeartifact is a new release service (as on June 2020) fully managed by AWS for storing packages/artifacts. You can store Maven, Python and 
few other package types.

Storing such packages and later using it in builds ensures that you are using an authenticated package that you or someone in your team tested and 
pushed to the codeartifactory and not any random package/unapproved packages you download from Internet.

packages are stored in "domain" and "repository" format. You can have multiple domains and each domain can multiple repositories 
in your account.

Who can use these packages?

Using this package depends on the programming language you use. If you have python package, it can be used by Codebuild, Ec2, Lambda 
etc.. by calling the repository url configured in codeartifactory.

In python world, you can upload package to codeartifactory using "twine" utility. Configure twine to upload to codeartifactory
repository.
You can use "pip" utility to "use" such packages. Configure pip to use the codeartifactory repository and get authenticated.

How to create python package?

Once you have some python files that are ready to use, files needs to be packaged.
You cannot upload one off python files to codeartifactory. You must create a package locally and upload.

Instead of using local ec2 server for packaging, I am using "codebuild" project to perfom below activities.

A. Upgrade AWS CLI to latest
B. Install twine utility.
C. Do the actual package creation.
D. Get authenticated against codeartifactory repository and upload packages using twine.

D. Get authenticated against codeartifactory repository and upload packages using twine EXPLAINED.

aws codeartifact login --tool twine --repository <pypi-store> --domain <test-domain> --domain-owner <0123456789>
//this creates a file .pypirc
[distutils]
index-servers =
        pypi
        codeartifact

[codeartifact]
repository = https://test-domain-0123456789.d.codeartifact.us-east-1.amazonaws.com/pypi/pypi-store/
username = aws
password = eyJ2ZXIiOjEsImdffdfjU0U0VlcEZQYThCTSJ9.j4P1QdopPHjsoAWG686QSQ.QsivAWmtCUQjVmrd.BfQXmN2ujeQnRIo1jL20S8tIxd26b3fE0yEV9dQHGnvzJsVyLZ12y-JXQlArhxujG_KfpAppFO7VlV99E82Y2AzxT3vI1fNCxfmh8bfVjrgoFKx0MuFvfPGHHhf0UPM-5TemyeW3z5_b9eKkLYYmvjlbhR6n9idcPD5HZguPRQET7WDXzhcdfdfW70c_9P6PCDt8PKTzhJOeW9nBnrW7YXSPhxgABRnGzPnF2V0hXy48YMIad6pGuaZ4SJ7ReLLil1igGKn7J93C51aAuVxwD_8wYxSaeAUgjr-sT97zJ1HfBz14d0vRT7-1dQh7Lg21ynH--KKgTqrzo3oqmqZubCX0YEs64E4rYw2an2GTVNZ6zd6eU8GssK2T3WTjRuNxmtbGJWuf8FPTF8hn9ORTxMsUHBykyWDL0yDCkc3sdkdnLHWLyrul-J3mwdBmReI66KbEzKp4LAVhf75z9vmimcPfNfGoEOvAHfUqQR-IvkdnKkg5msnMJA9CSbLUei5NaOfIxEk7h_p8uHxUWKNzQt5oKlvCCrlKKNe4QpGNjM_twp27yyXgPfniqDZASgIIYm01ODBgux0XKnShtB6TCKYtG8wlf62BQF4pgnufdP5P2qETXHC5tX1mieGV6318N3WOCp3XFijxdxOxN_pXwWBqBm66p1RsCDfVnkuS2uSmq9eq5k6Kg4hGrlczn6KJzLCTtzmh_MMV20LAl5Sce2aeEfzFoq3ueXWKMEqv3obyie0lnbO0Sg748F7k6MFZzIQW2vfy4qpa-1kHn7XJwVmwNX6Bdz9TVCe6rKph80k1MlEzErbslDYxb0Fby3mqHhzjCwR28RSqdIitf67p6LOYXnvtYLVH17XzS-kifSqHmIbN4YursJv77MzKKT1kpewsj2Z8qsfkxssxDL8fUibsx8-M7seMecq3iA3RBeJJ07TNegdFBg6L_IYVLZvHilS4wBd9vaPNb0JsopJEUIZRv7u8KNE0p2-GpZxS6lnZebwaBvBTyDDD2XhFkxNtP4_4ja380_gVcuJaUx3c19Z8m4E0T__og0WSguhOY2leZDtHyzjJzPImWYgAAe9DalZ3aLUMtfaZ9On_MhIYrSTfvdy4xfsRRWNs59du9vNBibrR4coE-LywCqp4kyEU6DJNhngNHg1DbcS1x0cLa0aJoHIy7R4URBwSV9wqnom4RAlsYk9YQCBKYEskJsUJZ_mMfk8mjCyAJ_jT5CVQLUs2s280vLzF038klqcvJCWud9eYNoVXm2n-pNn2wlP9Sy0SX7QYQc4tCGiCtKvr7HnNBuxj4KVd7zXT08cbpPiQeq3OjhPsTpAxV65Fe.tkRnBRiCZZ2YBR4zM6YWLw


What is included in the git repostory?

Clone and download the git repository git@github.com:rshettynj/codeartifactory.git

You will have to ready create the following in advance.

1. Create a sample domain and a sample repository for pypi-store in AWS Codeartifactory. 
2. Create a AWS Codecommit repository for testing upload the cloned directory above in codeartifactory directory.
3. Create a AWS Codebuild project using codecommit.
4. Make sure codebuild role used has required AWS IAM permissions. 

What happens when you run codebuild project?

1. Latest AWS CLI gets installed.
2. Twine utlity gets installed.
3. A sample python package called boto3-botocore-requests with version 0.0.1 gets created and uploaded to AWS codeartifactory.

How to use the uploaded custom package in your python code?

In order to use the package, you need to have pip authenticate against AWS Codeartifact. This is simple one step process.

command is: aws codeartifact login --tool pip --repository <REPO NAME> --domain <DOMAIN NAME> --domain-owner <ACCOUNT-ID>
//REPO NAME is the name of the repo where custom module was uploaded.
//DOMAIN NAME is the name of the domain used for custom module upload.
//ACCOUNT-ID is the AWS account id.

If authentication is successful, you can test out a small python module like below for requests module. Main idea is to verify that program picks up the local custom module. You can also uninstall original requests module if it existed to test out.

import python.requests as requests
import json

def posttourl(ceresp):
    try:
        endpoint = "https://abccom/api/297397/integration"
        uid = "rest_user"
        password = "T34"
        print(json.dumps(ceresp))
        r = requests.post(url=endpoint, data=json.dumps(resp), auth=requests.auth.HTTPBasicAuth(uid,password))
        print(r)
    except Exception as e: print(e)

print("OK")
body = {'reqID':'RITM001','status':'Closed Complete','comments':'testing'}
posttourl(body)
