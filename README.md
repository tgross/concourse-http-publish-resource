# concourse-http-publish-resource

*A [ConcourseCI resource](https://concourse-ci.org/resource-types.html) for publishing artifacts via HTTP PUT*

## Source Configuration

All fields are required.

* `url`: The http(s) url endpoint.
* `username`: The username used to authenticate.
* `password`: The password used to authenticate.

## `check`

Not currently implemented.

## `in`

Not currently implemented.

## `put`

Makes a HTTP PUT of the artifact. Optional parameters for this action can archive the file as a `tar.gz` and/or rename the file to include the build architecture or datestamp.

* `from`: [required] The relative path to get the artifact.
* `to`: [required] The subpath to which to upload the artifact.
* `os`: [optional] The operating system name to add to the artifact file name (ex. `linux`).
* `arch`: [optional] The architecture to add to the artifact file name (ex. `amd64`).
* `datefmt`: [optional] The format of the UTC timestamp added to the artifact file name (uses `date -u` under the hood, so ex. `+%Y%m%dT%H%MZ`).
* `archive`: [optional] A boolean value to make a gzipped tarball of the artifact.
* `dryrun`: [optional] A boolean value to rename the artifact and print metadata, but not actually upload. Used for testing.


Example usage of optional flags:

```yaml
# define the resource type from the published container
resource_types:
  - name: http-publish
    type: docker-image
    source:
      repository: machinistlabs/concourse-http-publish
      tag: latest

# create the resource
resources:
  - name: artifact-publish
    type: http-publish
    icon: docker
    source:
      url: "https://ci.example.com/releases"
      username: ((http-publish-username))
      password: ((http-publish-password))

jobs:
  - name: ship
    plan:
      get: artifact
      put: artifact-publish
        from: "artifact"
        to: "project-one"
        os: "linux"
        arch: "amd64"
        datefmt: "+%Y%m%dT%H%MZ"
        archive: true
```

Results in the file being pushed to `https://ci.example.com/releases/project-one/artifact_linux_amd64_20190712T1250Z.tar.gz`


## FAQ

Q: Is this done?
A: No. I want to implement `check` and `in`.

Q: Why not use [`http-put-resource`](https://github.com/lorands/http-put-resource)
A: Because I don't want to have to trust a community-built Docker image for artifact uploads, and because having a whole-ass custom golang application to do a HTTP PUT seems excessive. Also, I want to include archiving as part of the push process.
