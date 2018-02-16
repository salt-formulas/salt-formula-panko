panko:
  server:
    enabled: true
    version: pike
    bind:
      host: 127.0.0.1
      port: 8977
    identity:
      engine: keystone
      host: 127.0.0.1
      port: 35357
      tenant: service
      user: panko
      password: misterio
      endpoint_type: internalURL
      region: RegionOne
    database:
      engine: mysql
      host: 127.0.0.1
      port: 3306
      name: panko
      user: panko
      password: misterio
    cache:
      engine: memcached
      members:
        - host: 127.0.0.1
          port: 11211
apache:
  server:
    enabled: true
    default_mpm: event
    mpm:
      prefork:
        enabled: true
        servers:
          start: 5
          spare:
            min: 2
            max: 10
        max_requests: 0
        max_clients: 20
        limit: 20
    site:
      panko:
        enabled: false
        available: true
        type: wsgi
        name: panko
        host:
          name: panko.ci.local
          address: 127.0.0.1
          port: 8977
        log:
          custom:
            format: >-
              %v:%p %{X-Forwarded-For}i %h %l %u %t \"%r\" %>s %D %O \"%{Referer}i\" \"%{User-Agent}i\"
        wsgi:
          daemon_process: panko-api
          processes: 2
          threads: 10
          user: panko
          group: panko
          display_name: '%{GROUP}'
          script_alias: '/ /usr/bin/panko-api'
          application_group: '%{GLOBAL}'
          authorization: 'On'
