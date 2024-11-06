## Create a bucket
```sh
aws s3 mb s3://fun-cors-example-dd-8833 --region us-east-1
```
## Change block public access
```sh
aws s3api put-public-access-block \
--bucket fun-cors-example-dd-8833 \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create bucket policy
```sh
aws s3api put-bucket-policy --bucket fun-cors-example-dd-8833 --policy file://bucket-policy.json
```

## Turn on static website hosting
```sh
aws s3api put-bucket-website --bucket fun-cors-example-dd-8833 --website-configuration file://website.json
```

## Upload our index.html file and include a resource that would be cross-origin
```sh
aws s3 cp index.html s3://fun-cors-example-dd-8833
```
## Create a Post Method Mock Integration Rest API in api Gateway and get the endpoint
```sh
curl -X POST \
https://5c2n5gxqa2.execute-api.us-east-1.amazonaws.com/cors-stage-1/hello \
-H 'Content-Type: application/json'
``` 

## Update the index.html to do a post request to the api gateway endpoint
```js
 fetch("https://5c2n5gxqa2.execute-api.us-east-1.amazonaws.com/cors-stage-1/hello", {
    method: "POST",
    headers: {
        "Content-Type": "application/json"
    }
    })
    .then(res => {
    if (!res.ok) throw new Error("Failed to fetch data")
    return res.json()
    })
    .then(data => console.log(data))
    .catch(err => console.log(err.message))
```

## Add CORS policy to bucket and enable cors in resource api gateway
```sh
aws s3api put-bucket-cors --bucket fun-cors-example-dd-8833 --cors-configuration file://cors.json
```

## cleanup
```sh
aws s3 rm s3://fun-cors-example-dd-8833 --recursive
aws s3 rb s3://fun-cors-example-dd-8833
```
