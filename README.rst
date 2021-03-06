=============
Panko Formula
=============

Panko is a component of the OpenStack Telemetry project and is designed to
provide a metadata indexing, event storage service which enables users to
capture the state information of OpenStack resources at a given time. Its aim
is to enable a scalable means of storing both short and long term data for
use cases such as auditing and system debugging.

Sample pillars
==============

Single panko service

.. code-block:: yaml

    panko:
      server:
        enabled: true
        version: pike
        enable_proxy_headers_parsing: True
        database:
          engine: mysql
          host: 10.20.0.101
          port: 3306
          name: panko
          user: panko
          password: segreto
        bind:
          host: 10.20.0.102
          port: 8977
        identity:
          engine: keystone
          host: 10.20.0.101
          port: 35357
          user: panko
          password: segreto
          region: RegionOne
          tenant: service
          endpoint_type: internalURL
        cache:
          engine: memcached
          members:
          - host: 10.20.0.102
            port: 11211
          - host: 10.20.0.103
            port: 11211
          - host: 10.20.0.104
            port: 11211

Setting event cleanup

In order to allow events cleanup from one node of the cluster,
server:role field should be set to primary and all others to
secondary to avoid race conditions. On the example below
expirer is set to run every day at 2:00 AM. By default
it will be run every hour.

.. code-block:: yaml

    panko:
      server:
        role: primary
        expirer:
          cron:
            minute: 0
            hour: 2


Enhanced logging with logging.conf
----------------------------------

By default logging.conf is disabled.

That is possible to enable per-binary logging.conf with new variables:
  * openstack_log_appender - set it to true to enable log_config_append for all OpenStack services;
  * openstack_fluentd_handler_enabled - set to true to enable FluentHandler for all Openstack services.

Only WatchedFileHandler and FluentHandler are available.

Also it is possible to configure this with pillar:

.. note:: This works only if service doesnt run under apache-wsgi

.. code-block:: yaml

  panko:
    server:
      logging:
        log_appender: true
        log_handlers:
          watchedfile:
            enabled: true
          fluentd:
            enabled: true

Enable x509 and ssl communication between Panko and Galera cluster.
---------------------
By default communication between Panko and Galera is unsecure.

panko:
  server:
    database:
      x509:
        enabled: True

You able to set custom certificates in pillar:

panko:
  server:
    database:
      x509:
        cacert: (certificate content)
        cert: (certificate content)
        key: (certificate content)

You can read more about it here:
    https://docs.openstack.org/security-guide/databases/database-access-control.html

Panko server with memcached caching and security strategy:
--------------------
.. code-block:: yaml

    panko:
      server:
        enabled: true
        ...
        cache:
          engine: memcached
          members:
          - host: 127.0.0.1
            port: 11211
          - host: 127.0.0.1
            port: 11211
          security:
            enabled: true
            strategy: ENCRYPT
            secret_key: secret
More information
================

* https://wiki.openstack.org/wiki/Telemetry
* https://docs.openstack.org/developer/panko/
* https://github.com/openstack/panko
* https://bugs.launchpad.net/panko


Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use GitHub issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-panko/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

You should also subscribe to mailing list (salt-formulas@freelists.org):

    https://www.freelists.org/list/salt-formulas

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
