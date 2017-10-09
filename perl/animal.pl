use strict;
use warnings;
use Data::Dumper;

my $store = require('data.pm');
my $is_playing = 0;

sub ask_question {
    my $about = shift;
    print $store->{$about},"\n";
}

sub start_msg {
    print $store->{'start'},"\n";
    $is_playing = 1;
}

sub exit_msg {
    print $store->{'exit'},"\n";
}

sub list_known_animals {
    print join(', ',  map { (@{$_})[1,2] } @{$store->{'data'}}), "\n";
}

sub play {
    my $about = shift;
    ask_question($about);
    my $answer = <STDIN>;
    chomp $answer;

    if (("$about" eq 'confirmExit') && ("$answer" =~ /[Yy]/)){
        $is_playing = 0;
        return;
    }

    if ("$answer" =~ /list/){
        list_known_animals();
        return;
    }

    if ("$answer" =~ /[Qq]/){
        play('confirmExit');
    }
    else{
        play('mood');
    }
}

sub game_loop {
    while($is_playing){
        play('mood');
    }
}

start_msg();
game_loop();
exit_msg();
