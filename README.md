# Cloud Eye Exporter Docker Image

Docker image for Huawei Cloud - [Cloud Eye Exporter](https://github.com/huaweicloud/cloudeye-exporter).

## Environment Variables

- `HUAWEICLOUD_IAM_REGION_ID` = region id for authenticating to IAM
- `HUAWEICLOUD_IAM_ACCESS_KEY` = access key for authenticating to IAM
- `HUAWEICLOUD_IAM_SECRET_KEY` = secret key for authenticating to IAM
- `HUAWEICLOUD_CES_PROJECT_NAME` = IAM project name for cloud eye service
- `HUAWEICLOUD_CES_REGION_ID` = regioun id fo the cloud eye service

## Custom Configuration file

You can mount your own custom `logs.yml`, `clouds.yml`, or `metrics.yml` to `/opt/cloudeye-exporter` to customize how the cloudeye exporter run.

## Custom file with templating

You can mount any file to `/opt/gomplate/<custom/path>` and have gomplate used it as input file which will be saved to `<custom/path>` upon container start (only if `<custom/path>` does not exist).

Furthermore, you can customize the gomplate exuction by specifying:

- [`config.yaml`](https://docs.gomplate.ca/config/#file-format) under `/etc/gomplate`.
  - note that the config file should not contains any setting related to input and output file so that the previously mentioned templating behavior does not change.
- [`context.yaml`](https://docs.gomplate.ca/config/#context) under `/etc/gomplate`.
- [datasource](https://docs.gomplate.ca/datasources/#mime-types) files under `/etc/gomplate/datasource.d`.
