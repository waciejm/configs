{config, ...}: let
  inherit (builtins) attrNames concatMap toJSON;

  cfg = config.networking.firewall;
  expectedCfg = {
    allowedTCPPorts = [
      22 # ssh
    ];
    allowedUDPPorts = [
      41641 # tailscale wireguard
    ];
    allowedTCPPortRanges = [];
    allowedUDPPortRanges = [];
    trustedInterfaces = ["tailscale0" "lo"];
    interfaces = {};
  };

  portFieldNames = [
    "allowedTCPPorts"
    "allowedUDPPorts"
    "allowedTCPPortRanges"
    "allowedUDPPortRanges"
  ];

  mkAssert = what: value: expected: {
    assertion = value == expected;
    message = "unexpected ${what}, got ${toJSON value}, expected ${toJSON expected}";
  };
  mkGlobalAssert = fieldName: mkAssert fieldName cfg.${fieldName} expectedCfg.${fieldName};
  mkIfaceAssert = ifaceName: fieldName:
    mkAssert
    "${fieldName} for ${ifaceName}"
    (cfg.interfaces.${ifaceName} or {}).${fieldName} or []
    expectedCfg.interfaces.${ifaceName}.${fieldName};
in {
  config.assertions =
    [
      {
        assertion = cfg.enable == true;
        message = "firewall must be enabled";
      }
      (mkAssert "interfaces with open ports"
        (attrNames cfg.interfaces) (attrNames expectedCfg.interfaces))
      (mkGlobalAssert "trustedInterfaces")
    ]
    ++ map mkGlobalAssert portFieldNames
    ++ (concatMap
      (ifaceName: map (mkIfaceAssert ifaceName) portFieldNames)
      (attrNames expectedCfg.interfaces));
}
