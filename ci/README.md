# Description

This folder contains materials to update this ansible role automatically when new version of tools come out.

### How to run it
```
fly set-pipeline -t tutorial -c ci/pipeline.yml -p ansible-role-bosh-jumpbox --load-vars-from ci/stub.yml
```