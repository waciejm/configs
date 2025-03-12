{
  virtualisation.docker.enable = true;

  virtualisation.arion = {
    backend = "docker";

    projects.ydls = {
      serviceName = "ydls";
      settings = {
        project.name = "ydls";
        services.ydls.service = {
          image = "mwader/ydls:latest";
          restart = "always";
          ports = [
            "127.0.0.1:8451:8080"
          ];
        };
      };
    };
  };
}
