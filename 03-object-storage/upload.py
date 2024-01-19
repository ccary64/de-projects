import boto3
import os


def get_s3_client(username=None, password=None, url=None):
    return boto3.client(
        "s3",
        endpoint_url=url or os.getenv("S3_URL"),
        aws_access_key_id=username or os.getenv("MINIO_ROOT_USER"),
        aws_secret_access_key=password or os.getenv("MINIO_ROOT_PASSWORD"),
        verify=False,
    )


def upload_files(bucket_name):
    s3 = get_s3_client()
    for customer_id in range(1, 4):
        s3.upload_file(
            f"./data/company_{customer_id}.csv",
            bucket_name,
            f"company={customer_id}/list.csv",
        )
    s3.close()


def create_bucket(bucket_name):
    s3 = get_s3_client()
    s3.create_bucket(Bucket=bucket_name)
    s3.close()


def main(bucket_name):
    create_bucket(bucket_name)
    upload_files(bucket_name)


if __name__ == "__main__":
    main("customers")
