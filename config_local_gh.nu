# select gist, returns gist url
export def 'gh gist browse' [ ] {
	print 'Select Gist to Browse '
	let repo = ( gh gist list 
		| select description id
		| input list -d description  
	)
	$"https://gist.github.com/($repo.id)"
}

# select gist to clone here
export def 'gh gist clone' [ ] {
	print 'Select Gist to Clone '
	let repo = ( gh gist list 
		| select description id
		| input list -d description  
	)
		^gh gist clone $"($repo.id)" 
}


# select gist to delete
export def 'gh gist delete' [ ] {
	print 'Select Gist to Delete '
	let repo = ( gh gist list 
		| select description id
		| input list -d description  
	)

	let areyousure = (
		 [ "yes" "no" ] | input list "Are you sure? "   
	)

	if $areyousure == "yes" {
		^gh gist delete $"($repo.id)" 
	}
		
}

# list your gists
export def "gh gist list" [
    --files      # show file names
] {
    let basiclist = ([ $"id(char tab)description(char tab)files(char tab)"
        $"visibility(char tab)updated(char newline)" 
        $"(^gh gist list)" ] 
        | str join
        | from tsv )

    if $files == false {
      $basiclist
    } else {

# par-upsert  
# $basiclist | upsert files {|i| ^gh gist view $i.id --files }
     
    let parres = ( $basiclist
        | par-each {|i|
            ^gh gist view $i.id --files
            | lines
        } )
    $basiclist 
        | merge ( $parres | wrap files )
    }
}

# set gist description
export def 'gh gist mv' [ ] {
	print 'Select Gist to Change Description (mv)'
	let repo = ( gh gist list 
		| select description id
		| input list -d description
	)
	let newdesc = ( input "New Gist Description: " ) 
	print "    you must touch a file and submit now"
	^gh gist edit $"($repo.id)" -d $"($newdesc)"
		
}

# rename a file in a gistdd

export def 'gh gist rename' [ ] {  
	print 'select gist'
	let repo = ( gh gist list 
		| select description id
		| input list -d description  
	)

	let file = ( gh gist list --files 
		| where id == $repo.id
		| get files
		| input list "select file"
		| get 0 )

  let newname = ( input "new file name: " )
	 
	run-external gh gist rename $"($repo.id)" $"($file)" $"($newname)"  
}

# list your github repositorys
export def "gh repo list" [
] {
    ^gh repo list 
        | lines
        | parse "{name}\t{description}\t{info}\t{updated}"

}

