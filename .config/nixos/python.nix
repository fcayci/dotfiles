{ pkgs, ... }:
with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    numpy
    scipy
    matplotlib
    mpmath
    pandas
    scikitlearn
    pillow
    requests
  ]; 
  python-with-my-packages = python38.withPackages my-python-packages;
in
{
  environment.systemPackages = with pkgs; [
   python-with-my-packages
  ];
}
