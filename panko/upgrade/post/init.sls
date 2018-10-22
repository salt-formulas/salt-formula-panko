panko_post:
  test.show_notification:
    - text: "Running panko.upgrade.post"

keystone_os_client_config_absent:
  file.absent:
    - name: /etc/openstack/clouds.yml
