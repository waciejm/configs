{ config, lib, ... }:
{
  options.custom.assertions.firewall = {
    enable = lib.mkEnableOption "firewall assertions";
  };

  config =
    let
      cfg = config.custom.assertions.firewall;
    in
    lib.mkIf cfg.enable (
      let
        inherit (builtins) attrNames concatMap toJSON;
        fwCfg = config.networking.firewall;

        expectedFwCfg = {
          allowedTCPPorts = [ ];
          allowedUDPPorts =
            if config.custom.capabilities.networking.tailscale then
              [
                41641
              ]
            else
              [ ];
          allowedTCPPortRanges = [ ];
          allowedUDPPortRanges = [ ];
          trustedInterfaces =
            (
              if config.custom.capabilities.networking.tailscale then
                [
                  "tailscale0"
                ]
              else
                [ ]
            )
            ++ [ "lo" ];
          interfaces = { };
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
        mkGlobalAssert = fieldName: mkAssert fieldName fwCfg.${fieldName} expectedFwCfg.${fieldName};
        mkIfaceAssert =
          ifaceName: fieldName:
          mkAssert "${fieldName} for ${ifaceName}" (fwCfg.interfaces.${ifaceName} or { }).${fieldName} or [ ]
            expectedFwCfg.interfaces.${ifaceName}.${fieldName};
      in
      {
        assertions = [
          {
            assertion = fwCfg.enable == true;
            message = "firewall must be enabled";
          }
          (mkAssert "interfaces with open ports" (attrNames fwCfg.interfaces) (
            attrNames expectedFwCfg.interfaces
          ))
          (mkGlobalAssert "trustedInterfaces")
        ]
        ++ map mkGlobalAssert portFieldNames
        ++ (concatMap (ifaceName: map (mkIfaceAssert ifaceName) portFieldNames) (
          attrNames expectedFwCfg.interfaces
        ));
      }
    );
}
