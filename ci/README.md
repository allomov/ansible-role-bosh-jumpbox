# Description

This folder contains materials to update this ansible role automatically when new version of tools come out.

### How to run it
```
cp ci/stub.yml{.example,}
vi ci/stub.yml
fly set-pipeline -t tutorial -c ci/pipeline.yml -p ansible-role-bosh-jumpbox --load-vars-from ci/stub.yml
```

I want it to

 - [ ] be triggered by every new github release of dependency
 - [ ] update dependencies
 - [ ] create new brunch on github telling what dependency is updated
 - [ ] run tests localy
 - [ ] create PR if tests are ok


```
---
resource_types:
- name: pull-request-status
  type: docker-image
  source:
    repository: jtarchie/pr
- name: pull-request
  type: docker-image
  source:
    repository: allomov/pull-request-resource

resources:
- name: ansible-role-bosh-jumpbox-repo
  type: git
  source:
    uri: https://github.com/allomov/ansible-role-bosh-jumpbox.git
    branch: master
- name: version
  type: semver
  source:
    version: minor
- name: pr
  type: pull-request
  source:
    repo: allomov/ansible-role-bosh-jumpbox
    private_key: {{ private-github-key }}

- name: slack-notification
  type: slack-notification
  source:
    uri: {{ slack-notification-url }}

- name: new-spiff-github-release
  type: github-release
  # https://github.com/cloudfoundry-incubator/spiff
  source: 
    name: cloudfoundry-incubator
    repository: spiff
- name: new-spruce-github-release
  type: github-release
  # https://github.com/geofffranks/spruce
  source:
    name: geofffranks
    repository: spruce
- name: new-cf-cli-github-release
  type: github-release
  # https://github.com/cloudfoundry/cli
  source: 
    name: cloudfoundry
    repository: cli
- name: new-cf-cli-github-release
  type: github-release
  # https://github.com/cloudfoundry/cli
  source: 
    name: cloudfoundry
    repository: cli

# - name: bosh-init
#   type: gem
# - name: bosh_cli
#   type: gem
# - name: cf-uaac
#   type: gem
# - name: bosh-workspace
#   type: gem

jobs:
- name: update-cli
  plan:
  - get: ansible-role-bosh-jumpbox-repo
    trigger: false
  - get: new-cf-cli-github-release
    trigger: true
  - task: update-cf-cli-version
    file: ansible-role-bosh-jumpbox-repo/ci/tasks/run-tests.yml
  - task: run-tests
    file: ansible-role-bosh-jumpbox-repo/ci/tasks/run-tests.yml
  - put: pull-request
    params:
      path: repo
      status: pending      

```