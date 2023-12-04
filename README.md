# Deploying Docker container (with Gitlab CI and other)

<img src="https://preview.dragon-code.pro/andrey-helldar/deploy-container.svg?brand=gitlab&mode=dark" alt="Laravel Gitlab CI"/>

> 🐳 Generic docker image for Laravel Applications
>
> It is not recommended to use this container in production. Only for development and deployment.
>
> The configuration file for GitLab can be found [here](.gitlab-ci.yml).

[![Docker Badge](https://img.shields.io/docker/pulls/helldar/laravel-gitlab-ci)](https://hub.docker.com/r/helldar/laravel-gitlab-ci/)
[![Docker Build](https://github.com/andrey-helldar/laravel-gitlab-ci/actions/workflows/build.yml/badge.svg)](https://github.com/andrey-helldar/laravel-gitlab-ci/actions/workflows/build.yml)

## Supported tags and respective `Dockerfile` links

| Tags                                         | Stability                                                                            |
|:---------------------------------------------|:-------------------------------------------------------------------------------------|
| `latest`, `stable`, `8.3`, `8.3.x`           | latest stable                                                                        |
| `edge`, `unstable`, `edge-8.3`, `edge-8.3.x` | latest unstable                                                                      |
| `8.3`, `8.2`, `8.1`                          | stable minor                                                                         |
| `8.3.x`, `8.2.x`, `8.1.x`                    | stable patch, where `x` is the [PHP version number](https://www.php.net/downloads)   |
| `edge-8.3`, `edge-8.2`, `edge-8.1`           | unstable                                                                             |
| `edge-8.3.x`, `edge-8.2.x`, `edge-8.1.x`     | unstable patch, where `x` is the [PHP version number](https://www.php.net/downloads) |

## Unsupported but available

| Tags                       | Stability                                                                            |
|:---------------------------|:-------------------------------------------------------------------------------------|
| `8.0`, `7.4`               | stable minor                                                                         |
| `8.0`, `7.4.x`             | stable patch, where `x` is the [PHP version number](https://www.php.net/downloads)   |
| `edge-8.0`, `edge-7.4`     | unstable                                                                             |
| `edge-8.0.x`, `edge-7.4.x` | unstable patch, where `x` is the [PHP version number](https://www.php.net/downloads) |

