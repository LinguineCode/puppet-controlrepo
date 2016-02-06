# Class: SSH
#
#
class profile::base::ssh {

  # Hiera lookups
  #
  $ssh_storeconfigs_enabled = str2bool(hiera('ssh::storeconfigs_enabled'))
  # server
  $ssh_acceptenv                       = hiera('ssh::server_options::acceptenv')
  $ssh_banner                          = hiera('ssh::server_options::banner')
  $ssh_challengeresponseauthentication = hiera('ssh::server_options::challengeresponseauthentication')
  $ssh_ciphers                         = hiera('ssh::server_options::ciphers')
  $ssh_clientalivecountmax             = hiera('ssh::server_options::clientalivecountmax')
  $ssh_clientaliveinterval             = hiera('ssh::server_options::clientaliveinterval')
  $ssh_gssapiauthentication            = hiera('ssh::server_options::gssapiauthentication')
  $ssh_permitrootlogin                 = hiera('ssh::server_options::permitrootlogin')
  $ssh_printlastlog                    = hiera('ssh::server_options::printlastlog')
  $ssh_protocol                        = hiera('ssh::server_options::protocol')
  $ssh_subsystem                       = hiera('ssh::server_options::subsystem')
  $ssh_syslogfacility                  = hiera('ssh::server_options::syslogfacility')
  $ssh_usepam                          = hiera('ssh::server_options::usepam')
  $ssh_x11forwarding                   = hiera('ssh::server_options::x11forwarding')
  $ssh_printmotd                       = hiera('ssh::server_options::printmotd')
  # client
  $ssh_sendenv             = hiera('ssh::client_options::sendenv')
  $ssh_forwardx11trusted   = hiera('ssh::client_options::forwardx11trusted')
  $ssh_serveraliveinterval = hiera('ssh::client_options::serveraliveinterval')


  class { '::ssh':
    storeconfigs_enabled => $ssh_storeconfigs_enabled,
    server_options       => {
      'AcceptEnv'                       => $ssh_acceptenv,
      'Banner'                          => $ssh_banner,
      'ChallengeResponseAuthentication' => $ssh_challengeresponseauthentication,
      'Ciphers'                         => $ssh_ciphers,
      'ClientAliveCountMax'             => $ssh_clientalivecountmax,
      'ClientAliveInterval'             => $ssh_clientaliveinterval,
      'GSSAPIAuthentication'            => $ssh_gssapiauthentication,
      'PermitRootLogin'                 => $ssh_permitrootlogin,
      'PrintLastLog'                    => $ssh_printlastlog,
      'Protocol'                        => $ssh_protocol,
      'Subsystem'                       => $ssh_subsystem,
      'SyslogFacility'                  => $ssh_syslogfacility,
      'UsePAM'                          => $ssh_usepam,
      'X11Forwarding'                   => $ssh_x11forwarding,
      'PrintMotd'                       => $ssh_printmotd,
    },

  client_options         => {

    'Host *' => {
      'SendEnv'             => $ssh_sendenv,
      'ForwardX11Trusted'   => $ssh_forwardx11trusted,
      'ServerAliveInterval' => $ssh_serveraliveinterval,
      }

    },

  }

}