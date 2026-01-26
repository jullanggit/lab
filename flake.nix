{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # Jupyter and the kernel
            jupyter
            python3Packages.ipykernel

            # Your Python packages for analysis
            (python3.withPackages (ps: with ps; [
              numpy
              pandas
              matplotlib
              scikit-learn
	      ipywidgets
            ]))
          ];

          # Optional: Automatically start Jupyter Lab when you enter the shell
          shellHook = ''
            echo "Jupyter environment ready."
            echo "To start Jupyter Lab, run: jupyter lab"
          '';
        };
      }
    );
}
