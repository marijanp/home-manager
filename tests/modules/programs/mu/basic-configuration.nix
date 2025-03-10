{
  imports = [ ../../accounts/email-test-accounts.nix ];

  accounts.email.accounts = {
    "hm@example.com" = {
      mu.enable = true;
      aliases = [ "foo@example.com" ];
    };
  };

  programs.mu.enable = true;

  nmt.script = ''
    assertFileContains activate \
      'if [[ ! -d "/home/hm-user/.cache/mu" || ! "$MU_SORTED_ADDRS" = "foo@example.com hm@example.com" ]]; then'

    assertFileContains activate \
      'run @mu@/bin/mu init --maildir=/home/hm-user/Mail --muhome "/home/hm-user/.cache/mu" --my-address=foo@example.com --my-address=hm@example.com $VERBOSE_ARG;'
  '';
}
