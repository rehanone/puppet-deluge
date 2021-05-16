## 0.9.1 (May 16, 2021)

**Improvements:**

- Removed the unused docker node files.

## 0.9.0 (May 15, 2021)

**Improvements:**

- Updated `pdk` templates.

## 0.8.0 (July 5, 2020)

**Improvements:**

- Updated `pdk` templates.

**Bugfixes:**

- Fixed type for `service_port` parameter.

## 0.7.1 (May 5, 2020)

**Bugfixes:**

- Fix firewall rule naming issue.

## 0.7.0 (May 5, 2020)

**Improvements:**

- Added support for applying firewall rules if `ferm` is defined as firewall manager. It uses [ferm](https://forge.puppet.com/puppet/ferm) for managing firewall rules.
- Change deprecated dependency from [stahnma/epel](https://forge.puppet.com/stahnma/epel) to [puppet/epel](https://forge.puppet.com/puppet/epel).
- Removed unused test files.

## 0.6.0 (March 26, 2020)

**Improvements:**

- Added support for service umask to be configurable using `deluge::service_server_umask`.
- Added support for service webui umask to be configurable using `deluge::service_webui_umask`.
- Updated `pdk` templates.

## 0.5.0 (February 17, 2020)

**Improvements:**

- Added support for CentOS 8.
- Updated os support matrix.
- Updated `pdk` templates.

## 0.4.0 (August 25, 2019)

**Improvements:**

- Added support for Debian 10.
- Updated os support matrix.
- Updated `pdk` templates.

## 0.3.0 (July 11, 2019)

**Improvements:**

- Updated deluge repository to v2.0.
- Added debian 9 as an integration test target.
- Updated `pdk` templates.

## 0.2.2 (June 16, 2019)

**Improvements:**

- Updated minimum `puppet` version to 5.5.10.
- Updated os support matrix.
- Updated `pdk` templates.

## 0.2.1 (January 6, 2019)

**Improvements:**

- Updated `pdk` templates.

## 0.2.0 (October 17, 2018)

**Improvements:**

- Updated `pdk` templates.
- Added support for `puppet` version 6.

## 0.1.0 (April 21, 2018)

**Features:**

  - Initial release
