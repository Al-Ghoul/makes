{
  hasPrefix,
  projectSrc,
  ...
}: rel:
if hasPrefix "/" rel
then
  (builtins.path {
    filter = path: type:
      if rel == "/"
      then type != "directory" || builtins.baseNameOf path != ".git"
      else true;
    name =
      if rel == "/"
      then "src"
      else builtins.replaceStrings ["/"] ["-"] rel;
    path = (builtins.unsafeDiscardStringContext projectSrc) + rel;
  })
else abort "projectPath arguments must start with: /, currently it is: ${rel}"
