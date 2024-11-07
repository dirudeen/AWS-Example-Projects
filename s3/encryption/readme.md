## Create a bucket
```sh
aws s3 mb s3://encrytion-bucket-dd-1233 --region us-east-1
```
## Upload and download an object with SSE-KMS encrytion
```sh
echo "Hello World!" > hello.txt

export SSE_KMS_KEY_ID='your kms key id'

aws s3api put-object \
--bucket encrytion-bucket-dd-1233 \
--key hello.txt \
--body hello.txt \
--server-side-encryption aws:kms \
--ssekms-key-id $SSE_KMS_KEY_ID

aws s3 cp s3://encrytion-bucket-dd-1233/hello.txt hello.txt
```

## Upload and download object with SSE-C encrytion

```sh
openssl rand -out sse.key 32 

echo "Hello Mars!" > hello-sse-c.txt
//upload 
aws s3 cp hello-sse-c.txt s3://encrytion-bucket-dd-1233 \
--sse-c AES256 \
--sse-c-key fileb://sse.key

//download
aws s3 cp s3://encrytion-bucket-dd-1233/hello-sse-c.txt hello-ssec.txt \
--sse-c AES256 \
--sse-c-key fileb://sse.key
```

## Cleanup
```sh
aws s3 rm s3://encrytion-bucket-dd-1233 --recursive
aws s3 rb s3://encrytion-bucket-dd-1233
```