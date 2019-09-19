# Laravel Gitlab CI rules

This is a modification of the [lorisleiva/laravel-docker](https://github.com/lorisleiva/laravel-docker) container.

### Modified:
* Removed installation of nodejs and yarn (Bz default, versions nodejs 10.x and yarn 1.16.x were installed). Now you can connect the `node:latest` image in the services to install the latest versions of these packages.
* Added installation of php-soap extension.
* Added installation of php-redis extension.
