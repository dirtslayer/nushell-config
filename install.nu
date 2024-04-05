
cd $nu.default-config-dir

git clone git@gist.github.com:03ef41086fe6abc91f8aff89e8b066fd.git

$"source '($nu.default-config-dir)(char psep)03ef41086fe6abc91f8aff89e8b066fd(char psep)config_local.nu'"
    | save -a ./config.nu
