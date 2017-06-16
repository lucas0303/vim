syntax match identifier1 "\t"
syntax match longword1 "\w\{34,}"
syntax match longline1 "^.\{120,}$"

highlight link indentifier1 Error
highlight link longword1 Error
highlight link longline1 Error

function! Build()
    make 
    <CR>
    cd .
    cl "list the errors
endfunction
map <F3> :call Build()<CR> <CR>

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
