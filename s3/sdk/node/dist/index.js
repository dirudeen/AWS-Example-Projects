"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.client = void 0;
var client_s3_1 = require("@aws-sdk/client-s3");
var region = "us-east-1";
exports.client = new client_s3_1.S3Client({
    region: region
});
