mkdir -p ~/minio_data
MINIO_ROOT_USER=minioadmin MINIO_ROOT_PASSWORD=minioadmin minio server ~/minio_data --address ":5016" --console-address ":5017"
