"syntax case ignore
"syntax keyword type1 integer unsigned signed byte 
"syntax keyword statement1 foreach if then else elseif while repeat until disable end 
"syntax match comment1 /\/\/.*/
"syntax match identifier1 "\t"
"syntax match longword1 "\w\{14,}"
"syntax match longline1 "^.\{80,}$"
"
"highlight link type1 Type
"highlight link statement1 Statement
"highlight link comment1 Comment
"highlight link indentifier1 Error
"highlight link longword1 Error
"highlight link longline1 Error

"perl << EOF
"sub checksize 
"{
"my $count = 0;
"my $startfunc = 0;
"my $filelen = scalar @_;
"while ($count < $filelen) 
"    {
"    if ($_[$count] =~ /^function/) 
"        {
"        $startfunc = $count;
"        }
"    elsif ($_[$count] =~ /endfunction/)
"    {
"    if ($count - $startfunc > 100)
"        {
"        Vim::Msg($_[$startfunc], "Error");
"        }
"        }
"        ++$count;
"        }
"        }
"EOF
"
"function! L1( )
"    perl checksize($curbuf->Get(1..$curbuf->Count()))
"endfunction 

"function! build()
"    make
"    cl "list the errors
"endfunction
"map <F3> :call build()<CR>
