# Laravel Gitlab CI rules

This is a modification of the [lorisleiva/laravel-docker](https://github.com/lorisleiva/laravel-docker) container.

### Supported tags and respective `Dockerfile` links
* [7.3](https://github.com/andrey-helldar/laravel-gitlab-ci/blob/master/7.3/Dockerfile), [latest](https://github.com/andrey-helldar/laravel-gitlab-ci/blob/master/latest/Dockerfile)
* [7.2](https://github.com/andrey-helldar/laravel-gitlab-ci/blob/master/7.2/Dockerfile)
* [7.1](https://github.com/andrey-helldar/laravel-gitlab-ci/blob/master/7.1/Dockerfile)


### Modified:
* Removed installation of `nodejs` and `yarn` (By default, versions nodejs 10.x and yarn 1.16.x were installed). Now you can connect the `node:latest` image in the services to install the latest versions of these packages.
* Added installation of php-soap extension.
* Added installation of php-redis extension.
