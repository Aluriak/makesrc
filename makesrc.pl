#!/usr/bin/env perl
###########################################
#
# makesrc
# générateur de squelette de fichiers source
#
###########################################

# arguments attendus :
#       -s type de source
#       -n nom fichier/module (main par défaut)
#       -t titre (aucun par défaut)
#       -a auteur (aucun par défaut)


##################
# USES
##################
use strict;
use warnings;
use Cwd; # répertoire de lancement du script
use File::Basename; # répertoire du script
use File::Copy; # copie de fichiers





##################
# INITIALISATIONS
##################
my $DOC_arg = "makesrc source [-n name] [-t title] [-a author]";
my $DOC_source = "c, cpp, tex, py, pl";
my $dir_name = dirname($0); # répertoire du script
my $pattern = $dir_name."/"; # chemin vers fichiers pattern
#my $pattern = $dir_name."/"; # chemin vers fichiers pattern
# arguments
my $source = "";
my $name = "main";
my $title = "TITLE";
my $author = "AUTHOR";




##################
# IDENTIFICATIONS
##################

if(scalar(@ARGV) <= 0) {
    print ("Arguments attendus : ", $DOC_arg);
    exit(0);
}


# arguments (le premier est le type de source)
$source = $ARGV[0];
# (les suivants des options supplémentaires)
for (my $i = 2; $i < (scalar(@ARGV)); $i++) {
    if($ARGV[$i] eq "-n" and $i < (scalar(@ARGV)-1)) {
        $name = $ARGV[$i+1];
    }
    if($ARGV[$i] eq "-t" and $i < (scalar(@ARGV)-1)) {
        $title = $ARGV[$i+1];
    }
    if($ARGV[$i] eq "-a" and $i < (scalar(@ARGV)-1)) {
        $author = $ARGV[$i+1];
    }
}

# si aucune source indiquée
if($source eq "") {
    print("Pas de langage indiqué !\n");
    exit(0);
}
# sinon, on choppe la source correspondante
if(lc($source) eq "c") {
    $pattern = $pattern."c/*";
} elsif(lc($source) eq "beamer") {
    $pattern = $pattern."beamer/*";
} elsif(lc($source) eq "tex") {
    $pattern = $pattern."tex/*";
} elsif(lc($source) eq "cpp") {
    $pattern = $pattern."cpp/*";
} elsif(lc($source) eq "py") {
    $pattern = $pattern."py/*";
} elsif(lc($source) eq "pl") {
    $pattern = $pattern."pl/*";
} elsif(lc($source) eq "pro") {
    $pattern = $pattern."pro/*";
} else {
    print("Langage non géré. Essayez parmi $DOC_source\n");
    exit(0);
}

# Liste des fichiers d'entrée
my @INfiles = glob $pattern;




##################
# COPIE
##################
# Pour chaque fichier d'entrée
foreach my $corps (@INfiles) {


    # NOM DE LA CIBLE
    my $cible = $corps;                # à partir du nom du pattern on déduit le nom
    $cible =~ s/.*\.(.*)$/$name\.$1/;  # de la cible : name.extension. Le name est connu
    $cible = cwd()."/".$cible;         # et l'dxtension celle du fichier corps

    # OUVERTURES
    print "cible    : ".$cible."\n";
    print "patterns : ".$corps."\n";
    open(OUT, ">$cible") or die("err: $!\n");
    open(IN,  "<$corps") or die("err: $!\n");

    # RECOPIAGE
    my $line;
    while($line = <IN>) {
        # NORMALs substitutions
        $line =~ s/SCRIPTPERLTITLE/$title/;
        $line =~ s/SCRIPTPERLAUTHOR/$author/;
        $line =~ s/SCRIPTPERLNAME/$name/;
        # UPPERs substitutions
        my $upperName = uc($name);
        $line =~ s/SCRIPTPERLUPPERNAME/$upperName/;
        print (OUT $line);
    }

    # FERMETURES
    close(OUT);
    close(IN);



}


