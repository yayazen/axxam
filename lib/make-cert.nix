{ lib, pkgs }:
{
  #mkSecret =
  #  {
  #    name,
  #    path ? "/var/run/secrets/${name}",
  #    owner ? "root",
  #    mode ? "400",
  #    command ? "${pkgs.openssl}/bin/openssl rand -hex 32",
  #  }
  #  {
  #    create = ''
  #      install -o ${owner} -m ${mode} <(${command}) ${path} 
  #    '';
  #  };

  mkCert =
    {
      hosts ? [],
      CN ? builtins.elemAt hosts 0,
      file ? CN,
      action ? null,
      owner ? "root",
      group ? "root",
      directory ? "/var/run/secrets"
    }:
    let
      secret = name: "${directory}/${name}";
    in
    {
      inherit action;

      authority = {
        remote = "https://cfssl.local:8888";
        auth_key_file = secret "auth.key";
        label = "ca";
        profile = "default";
        root_ca = secret "ca.pem";
      };

      private_key = {
        inherit owner group;
        mode = "0600";
        path = secret "${file}-key.pem";
      };

      certificate = {
        inherit owner group;
        mode = "0644";
        path = secret "${file}.pem";
      };

      #key_usages = [
      #  "server auth"
      #];

      request = {
        inherit CN hosts;
        key = {
          algo = "ecdsa";
          size = 256;
        };
        names = [
          {
            C = "FR";
            L = "Paris";
            O = CN;
          }
        ];
      };
    };
}
