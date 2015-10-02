# define access_and_sudoers::allow
#
# The only difference between user/group type is the "%" down by sudo::conf
# Try to combine these two, because right now all of this code is duplicated
define profile::base::access_and_sudoers::allow (
  $ensure             = present,
  $entity             = $name,
  $pamaccess_priority = '90',
  $pamaccess_origin   = 'ALL',
  $sudoer             = true,
  $sudo_priority      = '10',
  $sudoer_content     = 'ALL=(ALL)       ALL',
  $entity_type        = 'group',
) {

  validate_re($entity_type, [ 'user', 'group', ] )
  validate_bool($sudoer)

  pam::access { $name:
    ensure     => $ensure,
    entity     => $entity,
    priority   => $pamaccess_priority,
    origin     => $pamaccess_origin,
    permission => '+',
  }

  if $sudoer {

    # If "group", then add a % character at beginning of sudo line
    if $entity_type == 'group' {
      $content = "%${entity}     ${sudoer_content}"
    }
    elsif $entity_type == 'user' {
      $content = "${entity}     ${sudoer_content}"
    }
    
    sudo::conf { $name:
      ensure   => $ensure,
      priority => $sudo_priority,
      content  => $content,
    }
    
  }
}