Set-Alias ll ls
Set-Alias clr clear
Set-Alias subl 'C:\Apps\Sublime Text\sublime_text.exe'
Set-Alias play 'C:\Apps\DAUM\PotPlayer\PotPlayerMini64.exe'

function video {cd ~\Videos}
function pic {cd ~\Pictures}
function down {cd ~\Downloads}
function music {cd ~\Music}
function desk {cd ~\Desktop}
function docs {cd ~\Documents}

function movie {cd C:\Tools\Movie_Data_Capture}

function mkdirg ()
{
    mkdir $args[0]
    cd $args[0]
}

function mvg ()
{
    $DIR_TRUE=(Test-Path $args[0])
    if ($DIR_TRUE -eq "True")
    {
        mv $args[0] $args[1] && cd $args[1]
    }
    else
    {
        mv $args[0] $args[1]
    }
}

function cpg ()
{
    $DIR_TRUE=(Test-Path $args[0])
    if ($DIR_TRUE -eq "True")
    {
        cp $args[0] $args[1] && cd $args[1]
    }
    else
    {
        cp $args[0] $args[1]
    }
}
