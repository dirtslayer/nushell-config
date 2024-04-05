# config_local_nupm.nu
# setup nupm 

# check for all these environment variable and folders - too many, 
# nupm needs to have one root variable, like $env.config.nupm, 
# then the rest can be
# $env.config.nupm.git-manager = $env.HOME + '/git'   
# $env.confg.nupm.modules = $env.NU_LIB_DIR


print "config_local_nupm: [warn] March 2024 Learning about Nushell Modules and Package Manager"

# config_local_nupm set env
# checking for env


mut windows_appdata = $env.APPDATA?
if ( $windows_appdata | is-not-empty ) {
	print "config_local_nupm: [warn] unset XDG_CONFIG_HOME"
	$env.XDG_CONFIG_HOME = ( $env.XDG_CONFIG_HOME? | default $env.APPDATA )
	print $"config_local_nupm: [warn] setting XDG_CONFIG_HOME to ($env.XDG_CONFIG_HOME)"
	$env.HOME = ( $env.HOME? | default $env.USERPROFILE	)
	print $"config_local_nupm: [warn] setting HOME to ($env.HOME)"
}

# info "check for XDG_CONFIG_HOME"
mut xdgc_h = $env.XDG_CONFIG_HOME?
if ( $xdgc_h | is-empty ) { 
	print "config_local_nupm: [warn] unset XDG_CONFIG_HOME"
	$xdgc_h = $env.HOME + (char psep) + '.config'
	print $"config_local_nupm: [warn] setting XDG_CONFIG_HOME to ($xdgc_h)"
	$env.XDG_CONFIG_HOME =  $xdgc_h
} 

# todo: use $nu values?
#info "check for NU_HOME"
mut nu_h = $env.NU_HOME?
if ( $nu_h | is-empty ) { 
	print "config_local_nupm: [warn] unset NU_HOME"
	$nu_h = $nu.default-config-dir
	print $"config_local_nupm: [warn] setting NU_HOME to ($nu_h)"
	$env.NU_HOME = $nu_h
}

# is there an xdg_source_tree or xdg_local_repo??

#info "check for GIT_REPOS_HOME"
mut gr_h = $env.GIT_REPOS_HOME?
if ( $gr_h | is-empty ) { 
	print "config_local_nupm: [warn] unset GIT_REPOS_HOME"
	$gr_h = $env.HOME + (char psep) + 'git'

	# info $"check if ($gr_h) exists"
	if not ($gr_h | path exists) {
		print $"config_local_nupm: [warn] creating GIT_REPOS_HOME at ($gr_h)"
		mkdir $gr_h
	}
	if not ($"($gr_h)(char psep)github.com(char psep)amtoine(char psep)nu-git-manager" | path exists) {
		print $"config_local_nupm: [warn] creating GIT_REPOS_HOME at ($gr_h)(char psep)github.com(char psep)amtoine(char psep)nu-git-manager"
		mkdir $"($gr_h)(char psep)github.com(char psep)amtoine(char psep)nu-git-manager"
	}
	print $"config_local_nupm: [warn] setting GIT_REPOS_HOME to ($gr_h)"
	$env.GIT_REPOS_HOME = $gr_h
}

#info "check for NUPM_HOME"
mut nupm_h = $env.NUPM_HOME?
if ( $nupm_h | is-empty ) { 
	print "config_local_nupm: [warn] unset NUPM_HOME"
	$nupm_h = $nu_h +  (char psep) + 'nupm'

	# info $"check if ($nupm_h) exists"
	if not ($nupm_h | path exists) {
		print $"config_local_nupm: [warn] creating NUPM_HOME at ($nupm_h)"
		mkdir $nupm_h
	}
	print $"config_local_nupm: [warn] setting NUPM_HOME to ($nupm_h)"
	$env.NUPM_HOME =  $nupm_h
}

# info "check for NUPM_CACHE"
mut nupm_c = $env.NUPM_CACHE?
if ( $nupm_c | is-empty ) { 
	print "config_local_nupm: [warn] unset NUPM_CACHE"
	$nupm_c = $nupm_h +  (char psep) + 'cache'

	# info $"check if ($nupm_c) exists"
	if not ($nupm_c | path exists) {
		print $"config_local_nupm: [warn] creating NUPM_CACHE at ($nupm_c)"
		mkdir $nupm_c
	}
	
	print $"config_local_nupm: [warn] setting NUPM_CACHE to ($nupm_c)"
	$env.NUPM_CACHE =  $nupm_c
}

# info "check for NU_LIB_DIRS"
mut nu_l =  $env.NU_LIB_DIRS?
if ( $nu_l | is-empty ) { 
	print "config_local_nupm: [warn] unset NU_LIB_DIRS"
	
	$nu_l = [$nupm_h +  (char psep) + 'modules']

	# info $"check if ($nu_l.0) exists"
	if not ($nu_l.0 | path exists) {
		print $"config_local_nupm: [warn] creating NU_LIB_DIRS at ($nu_l.0)"
		mkdir $nu_l.0
	}
	
	print $"config_local_nupm: [warn] setting NU_LIB_DIRS to ($nu_l)"
	$env.NU_LIB_DIRS =  $nu_l
} else {
	# info "check if NU_LIB_DIRS contains modules"
	let nupm_m = $nupm_h +  (char psep) + 'modules'
	if not ($nupm_m in $nu_l) {
		print $"config_local_nupm: [warn] adding ($nupm_m) to NU_LIB_DIRS"
		$env.NU_LIB_DIRS ++=  $nupm_m 
	}
}

if ( $env.PATH? | is-not-empty) {  # LINUX
	# info "check if scripts is in path"
	let nupm_p = $nupm_h + (char psep) + 'scripts'
	if not ($nupm_p in $env.PATH) {
		print $"config_local_nupm: [warn] adding ($nupm_p) to PATH"
		# TODO: is there a char env path seperator or is it always :?
		$env.PATH ++= $":($nupm_p)"
	}
} else { # WINDOWS
	let nupm_p = $nupm_h + (char psep) + 'scripts'
	if not ($nupm_p in $env.Path) {
		print $"config_local_nupm: [warn] adding ($nupm_p) to Path"
		# TODO: is there a char env path seperator or is it always :?
		$env.Path ++= $":($nupm_p)"
	}

}


# check for $env.NUPM_REGISTRIES?	
let nupm_r = $env.NUPM_REGISTRIES?

if ( $nupm_r | is-empty ) {	
	let fresh = { nupm: "https://raw.githubusercontent.com/nushell/nupm/main/registry.nuon",
	nupm-porcelain: "https://raw.githubusercontent.com/ddupas/nupm-porcelain/main/registry.nuon"}
	print $"config_local_nupm: [warn] set NUPM_REGISTRIES to ($fresh)"
	$env.NUPM_REGISTRIES = $fresh 
} else {

# check if nupm-porcelain is in list
if ( $env.NUPM_REGISTRIES | get -i nupm-porcelain | is-empty ) {
	let porcelain_r = { nupm-porcelain: "https://raw.githubusercontent.com/ddupas/nupm-porcelain/main/registry.nuon" }
	print  $"config_local_nupm: [warn] adding ($porcelain_r) to NUPM_REGISTRIES"
	$env.NUPM_REGISTRIES = ( 
		$env.NUPM_REGISTRIES
		| append $porcelain_r
	)
}

}


# info "check for NUPM_TEMP"
mut nupm_t = $env.NUPM_TEMP?
if ( $nupm_t | is-empty ) {
	print "config_local_nupm: [warn] unset NUPM_TEMP"
	$nupm_t =  (mktemp -d)
	print $"config_local_nupm: [warn] setting NUPM_TEMP to ($nupm_t)"
	$env.NUPM_TEMP = $nupm_t
}	

print $"(char newline) config_local_nupm: DONE"
{	# TODO: xop linux windows f PATH : ($env.PATH? | default $env.Path),
	GIT_REPOS_HOME : $env.GIT_REPOS_HOME,
	XDG_CONFIG_HOME : $env.XDG_CONFIG_HOME,
	NU_HOME : $env.NU_HOME,
	NUPM_HOME : $env.NUPM_HOME,	
	NUPM_CACHE : $env.NUPM_CACHE,
#	NUPM_REGISTRIES : $env.NUPM_REGISTRIES, # nupm config file?
	NUPM_TEMP : $env.NUPM_TEMP,
	NU_LIB_DIRS : $env.NU_LIB_DIRS
} | table -t compact -e

#
# even after all that
# we can not simply put 
# use nupm here or use $env.NUPM_HOME/nupm
#
# source configh_local_nupm.nu without 
# remaining lines  (ie this is my config file ;)
#
# ⚠ load modules from dir before nupm env is set (non-deterministic)

# linux
# rm -rf /home/dd/.config/nushell/nupm/modules/nupm-porcelain/  # [WIP]
# rm -rf /home/dd/.config/nushell/nupm/cache/git/nupm-porcelain*  # [WIP]
use /home/dd/.config/nushell/nupm/nupm
use /home/dd/git/nupm-porcelain/nupm-porcelain * # [WIP]

# windows
# rm -rf C:\Users\dirts\AppData\Roaming\nushell\modules\nupm-porcelain\  # [WIP]
# rm -rf C:\Users\dirts\AppData\Roaming\nushell\nupm-porcelain*  # [WIP]
# use C:\Users\dirts\AppData\Roaming\nushell\nupm\nupm
# use C:\Users\dirts\AppData\Roaming\nushell\nupm-porcelain\nupm-porcelain *