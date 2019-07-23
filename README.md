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

Makes a HTTP PUT of the artifact.

* `from`: [required] The relative path to get the artifact.
* `to`: [required] The path to which to upload the artifact. (If you are uploading to webdav or similar, this should include the destination file name.) Will interpolate the [resource metadata](https://concourse-ci.org/implementing-resource-types.html#resource-metadata) fields as well as a `$BUILD_DATETIME` field as formatted by the `datefmt` field (see below).
* `datefmt`: [optional] The format of the UTC timestamp added to the artifact file name (uses `date -u` under the hood). Defaults to `+%Y%m%dT%H%MZ`.
* `dryrun`: [optional] A boolean value to print metadata, but not actually upload. Used for testing.

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
    icon: file-upload
    source:
      url: "https://ci.example.com/releases"
      username: ((http-publish-username))
      password: ((http-publish-password))

jobs:
  - name: ship
    plan:
      get: artifact
      put: artifact-publish
        from: "dist/artifact.tar.gz"
        to: "project-one/${BUILD_DATE}/artifact.tar.gz"
        datefmt: "+%Y%m%dT%H%MZ"
```

This results in the file being pushed to `https://ci.example.com/releases/project-one/20190712T1250Z/artifact.tar.gz`


## FAQ

Q: Is this done?
A: No. I want to implement `check` and `in`.

Q: Why not use [`http-put-resource`](https://github.com/lorands/http-put-resource)
A: That resource publishes an entire directory, which means it has no reasonable way to implement `check` with the hash of the uploaded files. I also don't want to have to trust a community-built Docker image for artifact uploads, and because having a whole-ass custom golang application to do a HTTP PUT seems excessive. And it has no license. =(
