{
  pkgs,
  ...
}: {
  packages = with pkgs; [
    nodejs_20
    python3
    rustc
    cargo
    rust-analyzer
  ];

  enterShell = "echo Welcome to development environment!";
}
