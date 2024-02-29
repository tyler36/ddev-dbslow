[![tests](https://github.com/tyler36/ddev-dbslow/actions/workflows/tests.yml/badge.svg)](https://github.com/tyler36/ddev-dbslow/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2024.svg)

# dbslow <!-- omit in toc -->

- [What is dbslow?](#what-is-dbslow)
- [Getting started](#getting-started)
- [Usage](#usage)
- [Starting and stopping](#starting-and-stopping)
- [Viewing](#viewing)
- [TODO](#todo)

## What is dbslow?

This addon is designed to log slow queries (>1 second). Slow queries degrade site performance.
By tracking slow queries, developer gain insight to how the database is being used and specific areas to focus for improvement.

This addon was inspired by [ChromaticHQ/ddev-dblog](https://github.com/ChromaticHQ/ddev-dblog). The main difference is

- `ddev-dblog` logs _all_ queries.
- `ddev-dbslow` logs queries slow queries (>1 second)

As both addons mature, it is possible this functionality will merge into `ddev-dblog` or DDEV core.

## Getting started

1. Install the addon.

    ```shell
    ddev get tyler36/dbslow
    ```

2. Restart DDEV.

    ```shell
    ddev restart
    ```

## Usage

## Starting and stopping

- `ddev dbslow on`: Start logging slow queries.
- `ddev dbslow off`: Stop logging slow queries.
- `ddev dbslow toggle`: Toggle the current state of the logging. Ie. OFF => ON, ON => OFF.

## Viewing

- `ddev dbslow view`: Display the log file.
- `ddev dbslow tail`: Stream the log file in the terminal.

## TODO

- [ ] Add configuration options for settings.
- [ ] Add tests for `ddev dbslow tail`
- [ ] Add tests for MySQL
- [ ] Add support for Postgres

**Contributed and maintained by [@tyler36](https://github.com/tyler36)**
