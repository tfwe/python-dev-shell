{
  description = "Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python3
            python3Packages.virtualenv
            python3Packages.pip
            stdenv.cc.cc
            zlib
            libGL
            libGLU
            xorg.libX11
            fish
          ];

          shellHook = ''
            # Get the base name of the current directory
            PROJ_NAME=$(basename $(pwd))
            VENV_PATH="$HOME/.cache/nix-shell-venvs/$PROJ_NAME"

            # Create and activate Python venv if it doesn't exist
            if [ ! -d "$VENV_PATH" ]; then
              echo "Creating Python virtual environment for $PROJ_NAME..."
              ${pkgs.python3}/bin/python3 -m venv "$VENV_PATH"
            fi

            # Prepare Fish shell configuration
            FISH_CONFIG=$(cat <<EOT
            # Activate Python venv
            source $VENV_PATH/bin/activate.fish

            # Install dependencies from requirements.txt if it exists
            if test -f "requirements.txt"
              echo "Installing dependencies from requirements.txt..."
              pip install -r requirements.txt
            else
              echo "No requirements.txt found. Skipping dependency installation."
            end

            # Set environment variables
            set -x LD_LIBRARY_PATH ${pkgs.stdenv.cc.cc.lib}/lib ${pkgs.zlib}/lib ${pkgs.libGL}/lib ${pkgs.libGLU}/lib \$LD_LIBRARY_PATH

            echo "Nix shell activated with Python venv for $PROJ_NAME. Use 'deactivate' to exit the venv."
            EOT
            )

            # Write Fish configuration to a temporary file
            echo "$FISH_CONFIG" > /tmp/nix-shell-fish-config.fish

            # Start Fish shell with the prepared configuration
            exec ${pkgs.fish}/bin/fish --init-command "source /tmp/nix-shell-fish-config.fish"
          '';
        };
      }
    );
}
