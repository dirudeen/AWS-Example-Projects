/**
 * Imports required AWS SDK commands for interacting with S3 and
 * other necessary modules for user input and client configuration.
 */
import { ListObjectsCommand, DeleteObjectCommand, DeleteBucketCommand } from "@aws-sdk/client-s3";
import { client } from "./index";
import { createInterface } from "node:readline/promises";

/**
 * Retrieves all object keys (filenames) from the specified S3 bucket.
 * 
 * @param {string} bucketName - The name of the S3 bucket from which to retrieve the objects.
 * @returns {Promise<Array<string> | undefined>} - Returns an array of object keys if the bucket contains objects, or undefined if the bucket is empty or an error occurs.
 */
const getObjects = async (bucketName: string): Promise<Array<string> | undefined> => {
    try {
        // Sends a command to list objects in the bucket
        const data = await client.send(new ListObjectsCommand({
            Bucket: bucketName
        }));
        // Returns an array of object keys, or undefined if there are no objects
        return data.Contents?.map(object => object.Key) as string[];
    } catch (error) {
        console.error(error);
    }
};

/**
 * Deletes a list of objects from the specified S3 bucket.
 * 
 * @param {Array<string>} objects - Array of object keys to be deleted from the bucket.
 * @param {string} bucketName - The name of the S3 bucket where the objects are stored.
 * @returns {Promise<void>} - Deletes objects asynchronously and logs errors if any occur.
 * @throws {Error} - Throws an error if an object cannot be deleted.
 */
const deleteObjects = async (objects: Array<string>, bucketName: string): Promise<void> => {
    // Loops through the array of object keys and deletes each one
    objects.forEach(async (key) => {
        try {
            await client.send(new DeleteObjectCommand({
                Bucket: bucketName,
                Key: key
            }));
        } catch (error) {
            console.error(error);
            throw new Error("Error: failed to delete objects");
        }
    });
};

/**
 * Deletes the specified S3 bucket.
 * 
 * @param {string} bucketName - The name of the S3 bucket to be deleted.
 * @returns {Promise<void>} - Sends the delete bucket command and logs errors if they occur.
 */
const deleteBucket = async (bucketName: string): Promise<void> => {
    try {
        await client.send(new DeleteBucketCommand({
            Bucket: bucketName
        }));
    } catch (error) {
        console.error(error);
    }
};

/**
 * The main function orchestrates the process of deleting objects from an S3 bucket
 * and the bucket itself. It prompts the user for confirmation before proceeding.
 * 
 * @returns {Promise<void>} - Runs the entire script logic for bucket deletion.
 * @throws {Error} - Throws an error if no bucket name is provided or the process is canceled.
 */
const main = async (): Promise<void> => {
    // Retrieve the bucket name from the command-line arguments
    const bucketName = process.argv[2];
    if (!bucketName) throw new Error("Bucket name must be provided. e.g., node delete-bucket-and-content bucket-name");

    // Create an interface to prompt the user for input in the terminal
    const prompt = createInterface({
        input: process.stdin,
        output: process.stdout
    });

    // Prompt the user for confirmation before deleting the bucket
    const result = await prompt.question("Empty and delete bucket? (y/n) ");
    prompt.close();

    if (result !== "y") {
        return console.log("Cancelled!");  // Exit if the user cancels the operation
    }

    // Retrieve objects from the bucket
    const objects = await getObjects(bucketName);

    // If no objects are found, delete the bucket immediately
    if (objects === undefined) {
        await deleteBucket(bucketName);
        return console.log("Bucket has been deleted");
    }

    // Delete the objects and then the bucket itself
    await deleteObjects(objects, bucketName);
    await deleteBucket(bucketName);
    console.log("Bucket and its contents have been deleted");
};

// Execute the main function
main();

