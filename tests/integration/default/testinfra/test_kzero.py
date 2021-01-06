def test_file_exists(host):
    kzero = host.file('/kzero.yml')
    assert kzero.exists
    assert kzero.contains('your')

# def test_kzero_is_installed(host):
#     kzero = host.package('kzero')
#     assert kzero.is_installed
#
#
# def test_user_and_group_exist(host):
#     user = host.user('kzero')
#     assert user.group == 'kzero'
#     assert user.home == '/var/lib/kzero'
#
#
# def test_service_is_running_and_enabled(host):
#     kzero = host.service('kzero')
#     assert kzero.is_enabled
#     assert kzero.is_running
