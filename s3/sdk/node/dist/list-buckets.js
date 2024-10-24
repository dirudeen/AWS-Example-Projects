"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var index_1 = require("../index");
var client_s3_1 = require("@aws-sdk/client-s3");
var region = process.env.AWS_DEFAULT_REGION;
if (!region) {
    throw new Error("Region must be specified in env");
}
var listBucketConfig = new client_s3_1.ListBucketsCommand({
    BucketRegion: region
});
index_1.client.send(listBucketConfig).then(function (res) {
    console.log(res);
}).catch(function (err) { return console.log(err); });
