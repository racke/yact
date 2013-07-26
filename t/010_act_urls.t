#!/usr/bin/env perl

use Test::More;
use strict;
use warnings;

exit 0;

# TODO TODO TODO TODO TODO TODO TODO TODO 
# TODO TODO TODO TODO TODO TODO TODO TODO 
# TODO TODO TODO TODO TODO TODO TODO TODO 
# TODO TODO TODO TODO TODO TODO TODO TODO 

# the order is important
use YACT::Web;
use Dancer::Test;

route_exists [ GET => '/' ], 'a route handler is defined for /';
response_status_is [ 'GET' => '/' ], 200, 'response status is 200 for /';

route_exists [ GET => '/LOGIN' ], 'a route handler is defined for /LOGIN';
response_status_is [ GET => '/LOGIN' ], 200,
    'response status is 200 for /LOGIN';

route_exists [ GET => '/LOGOUT' ], 'a route handler is defined for /LOGOUT';
response_status_is [ GET => '/LOGOUT' ], 200,
    'response status is 200 for /LOGOUT';

TODO: {
    local ($TODO) = "Not yet implemented";

    route_exists [ GET => '/main' ], 'a route handler is defined for /main';
    response_status_is [ GET => '/main' ], 200,
        'response status is 200 for /main';

    # /user -> /user/{user_id}
    route_exists [ GET => '/user' ], 'a route handler is defined for /user';
    response_status_is [ GET => '/user' ], 304,
        'response status is 304 for /user';

    # /photo -> /user/{user_id}/photo
    route_exists [ GET => '/photo' ], 'a route handler is defined for /photo';
    response_status_is [ GET => '/photo' ], 304,
        'response status is 304 for /photo';

    route_exists [ GET => '/wikiedit' ],
        'a route handler is defined for /wikiedit';
    response_status_is [ GET => '/wikiedit' ], 200,
        'response status is 200 for /wikiedit';
    route_exists [ GET => '/wiki' ], 'a route handler is defined for /wiki';
    response_status_is [ GET => '/wiki' ], 200,
        'response status is 200 for /wiki';
    route_exists [ GET => '/updatemytalks' ],
        'a route handler is defined for /updatemytalks';
    response_status_is [ GET => '/updatemytalks' ], 200,
        'response status is 200 for /updatemytalks';
    route_exists [ GET => '/updatemytalks_a' ],
        'a route handler is defined for /updatemytalks_a';
    response_status_is [ GET => '/updatemytalks_a' ], 200,
        'response status is 200 for /updatemytalks_a';
    route_exists [ GET => '/unregister' ],
        'a route handler is defined for /unregister';
    response_status_is [ GET => '/unregister' ], 200,
        'response status is 200 for /unregister';
    route_exists [ GET => '/tracks' ],
        'a route handler is defined for /tracks';
    response_status_is [ GET => '/tracks' ], 200,
        'response status is 200 for /tracks';
    route_exists [ GET => '/trackedit' ],
        'a route handler is defined for /trackedit';
    response_status_is [ GET => '/trackedit' ], 200,
        'response status is 200 for /trackedit';
    route_exists [ GET => '/timetable.ics' ],
        'a route handler is defined for /timetable.ics';
    response_status_is [ GET => '/timetable.ics' ], 200,
        'response status is 200 for /timetable.ics';
    route_exists [ GET => '/talks' ], 'a route handler is defined for /talks';
    response_status_is [ GET => '/talks' ], 200,
        'response status is 200 for /talks';
    route_exists [ GET => '/talk' ], 'a route handler is defined for /talk';
    response_status_is [ GET => '/talk' ], 200,
        'response status is 200 for /talk';
    route_exists [ GET => '/stats' ], 'a route handler is defined for /stats';
    response_status_is [ GET => '/stats' ], 200,
        'response status is 200 for /stats';
    route_exists [ GET => '/search' ],
        'a route handler is defined for /search';
    response_status_is [ GET => '/search' ], 200,
        'response status is 200 for /search';
    route_exists [ GET => '/schedule' ],
        'a route handler is defined for /schedule';
    response_status_is [ GET => '/schedule' ], 200,
        'response status is 200 for /schedule';
    route_exists [ GET => '/rights' ],
        'a route handler is defined for /rights';
    response_status_is [ GET => '/rights' ], 200,
        'response status is 200 for /rights';
    route_exists [ GET => '/register' ],
        'a route handler is defined for /register';
    response_status_is [ GET => '/register' ], 200,
        'response status is 200 for /register';
    route_exists [ GET => '/purchase' ],
        'a route handler is defined for /purchase';
    response_status_is [ GET => '/purchase' ], 200,
        'response status is 200 for /purchase';
    route_exists [ GET => '/punregister' ],
        'a route handler is defined for /punregister';
    response_status_is [ GET => '/punregister' ], 200,
        'response status is 200 for /punregister';
    route_exists [ GET => '/proceedings' ],
        'a route handler is defined for /proceedings';
    response_status_is [ GET => '/proceedings' ], 200,
        'response status is 200 for /proceedings';
    route_exists [ GET => '/payments' ],
        'a route handler is defined for /payments';
    response_status_is [ GET => '/payments' ], 200,
        'response status is 200 for /payments';
    route_exists [ GET => '/payment' ],
        'a route handler is defined for /payment';
    response_status_is [ GET => '/payment' ], 200,
        'response status is 200 for /payment';
    route_exists [ GET => '/orders' ],
        'a route handler is defined for /orders';
    response_status_is [ GET => '/orders' ], 200,
        'response status is 200 for /orders';
    route_exists [ GET => '/openid_trust' ],
        'a route handler is defined for /openid_trust';
    response_status_is [ GET => '/openid_trust' ], 200,
        'response status is 200 for /openid_trust';
    route_exists [ GET => '/openid' ],
        'a route handler is defined for /openid';
    response_status_is [ GET => '/openid' ], 200,
        'response status is 200 for /openid';
    route_exists [ GET => '/newtalk' ],
        'a route handler is defined for /newtalk';
    response_status_is [ GET => '/newtalk' ], 200,
        'response status is 200 for /newtalk';
    route_exists [ GET => '/newsedit' ],
        'a route handler is defined for /newsedit';
    response_status_is [ GET => '/newsedit' ], 200,
        'response status is 200 for /newsedit';
    route_exists [ GET => '/news' ], 'a route handler is defined for /news';
    response_status_is [ GET => '/news' ], 200,
        'response status is 200 for /news';
    route_exists [ GET => '/newsadmin' ],
        'a route handler is defined for /newsadmin';
    response_status_is [ GET => '/newsadmin' ], 200,
        'response status is 200 for /newsadmin';
    route_exists [ GET => '/newevent' ],
        'a route handler is defined for /newevent';
    response_status_is [ GET => '/newevent' ], 200,
        'response status is 200 for /newevent';
    route_exists [ GET => '/myschedule.ics' ],
        'a route handler is defined for /myschedule.ics';
    response_status_is [ GET => '/myschedule.ics' ], 200,
        'response status is 200 for /myschedule.ics';
    route_exists [ GET => '/myschedule' ],
        'a route handler is defined for /myschedule';
    response_status_is [ GET => '/myschedule' ], 200,
        'response status is 200 for /myschedule';
    route_exists [ GET => '/invoice' ],
        'a route handler is defined for /invoice';
    response_status_is [ GET => '/invoice' ], 200,
        'response status is 200 for /invoice';
    route_exists [ GET => '/ical_import' ],
        'a route handler is defined for /ical_import';
    response_status_is [ GET => '/ical_import' ], 200,
        'response status is 200 for /ical_import';
    route_exists [ GET => '/favtalks' ],
        'a route handler is defined for /favtalks';
    response_status_is [ GET => '/favtalks' ], 200,
        'response status is 200 for /favtalks';
    route_exists [ GET => '/faces' ], 'a route handler is defined for /faces';
    response_status_is [ GET => '/faces' ], 200,
        'response status is 200 for /faces';
    route_exists [ GET => '/export_talks' ],
        'a route handler is defined for /export_talks';
    response_status_is [ GET => '/export_talks' ], 200,
        'response status is 200 for /export_talks';
    route_exists [ GET => '/export' ],
        'a route handler is defined for /export';
    response_status_is [ GET => '/export' ], 200,
        'response status is 200 for /export';
    route_exists [ GET => '/events' ],
        'a route handler is defined for /events';
    response_status_is [ GET => '/events' ], 200,
        'response status is 200 for /events';
    route_exists [ GET => '/event' ], 'a route handler is defined for /event';
    response_status_is [ GET => '/event' ], 200,
        'response status is 200 for /event';
    route_exists [ GET => '/edittalk' ],
        'a route handler is defined for /edittalk';
    response_status_is [ GET => '/edittalk' ], 200,
        'response status is 200 for /edittalk';
    route_exists [ GET => '/editevent' ],
        'a route handler is defined for /editevent';
    response_status_is [ GET => '/editevent' ], 200,
        'response status is 200 for /editevent';
    route_exists [ GET => '/csv' ], 'a route handler is defined for /csv';
    response_status_is [ GET => '/csv' ], 200,
        'response status is 200 for /csv';
    route_exists [ GET => '/create' ],
        'a route handler is defined for /create';
    response_status_is [ GET => '/create' ], 200,
        'response status is 200 for /create';
    route_exists [ GET => '/confirm_attend' ],
        'a route handler is defined for /confirm_attend';
    response_status_is [ GET => '/confirm_attend' ], 200,
        'response status is 200 for /confirm_attend';
    route_exists [ GET => '/changepwd' ],
        'a route handler is defined for /changepwd';
    response_status_is [ GET => '/changepwd' ], 200,
        'response status is 200 for /changepwd';
    route_exists [ GET => '/change' ],
        'a route handler is defined for /change';
    response_status_is [ GET => '/change' ], 200,
        'response status is 200 for /change';
    route_exists [ GET => '/atom' ], 'a route handler is defined for /atom';
    response_status_is [ GET => '/atom' ], 200,
        'response status is 200 for /atom';
    route_exists [ GET => '/api' ], 'a route handler is defined for /api';
    response_status_is [ GET => '/api' ], 200,
        'response status is 200 for /api';

}

done_testing;
