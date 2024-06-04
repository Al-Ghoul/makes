{ __nixpkgs__, makeTemplate, makeTerraformEnvironment, ... }:
{ name, setup, src, variable ? "", version, ... }:
makeTemplate {
  name = "test-terraform-for-${name}";
  replace = {
    __argSrc__ = src;
    __argVariable__ = variable;
  };
  searchPaths = {
    bin = [ __nixpkgs__.gnugrep ];
    source = [ (makeTerraformEnvironment { inherit version; }) ] ++ setup;
  };
  template = ./template.sh;
}
