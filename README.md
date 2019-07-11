# concourse-http-put-resource

*A [ConcourseCI resource](https://concourse-ci.org/resource-types.html) for publishing artifacts via HTTP PUT*

## Source Configuration

All field are required.

* `url`: The http(s) url endpoint.
* `username`: The username used to authenticate.
* `password`: The password used to authenticate.

## `check`

Not currently implemented.

## `in`

Not currently implemented.

## `put`

Makes a HTTP PUT of the artifact.

* `from`: The relative path to get the artifact.
* `to`: The subpath to which to upload the artifact.

## FAQ

Q: Is this done?
A: No. I want to implement `check` and `in`.

Q: Why not use [`http-put-resource`](https://github.com/lorands/http-put-resource)
A: Because I don't want to have to trust a community-built Docker image for artifact uploads, and because having a whole-ass custom golang application to do a HTTP PUT seems excessive.
