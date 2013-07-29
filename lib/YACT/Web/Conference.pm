package YACT::Web::Conference;

use YACT::Web;

r "" => sub {
    use DDP;
    p( conf() );
    print "HAHAHAHAHHAHAHAHAH";
    text "Conference " . conf->conf_id;
};

1;
