import YouTubePlayer from 'youtube-player';


var player;

if ($('#playerYoutube').length != 0) {

    if ($('.hide-video').length != 0) {
        $('.hide-video').hide();
    }

    player = YouTubePlayer('playerYoutube', {
        videoId: $('#playerYoutube').data('videoid'),
        playerVars: {'autoplay': 0, 'controls': 1, 'showinfo': 0, 'rel': 0}
    });

    var youtube = {
        init: false,
        scondTriger: 0
    }

    var getrespons = {
        init: false,
        scondTriger: 0,
        done: false
    }

    var facebook = {
        init: false,
        scondTriger: 0,
        done: false
    }


    player.on('stateChange', function (event) {

        setInterval(function () {
            var videotime = Math.floor(event.target.getCurrentTime());

            if (facebook.init) {
                if (videotime > facebook.scondTriger) {
                    if (!facebook.done) {

                        if (typeof fbq !== 'undefined') {
                            fbq('track', "VideSeen");
                        }

                        facebook.done = true;
                    }
                }
            }

            if (getrespons.init) {
                if (videotime > getrespons.scondTriger) {
                    if (!getrespons.done) {

                        if ($.cookie('user_email') != undefined) {
                            console.log('GetresonseDone: ' + $.cookie('user_email'));
                        }
                        getrespons.done = true;
                    }
                }
            }


            if (youtube.init) {
                if ($('.hide-video').length != 0 && videotime >= youtube.scondTriger) {
                    $('.hide-video').show();
                } else {
                    $('.hide-video').hide();
                }
            }

        }, 1000);
    });
}

global.yotubeStart = function(initB, secondI){
    youtube.init = initB;
    youtube.scondTriger = secondI;

    return 'Tube Done';
}

global.gereponsStart = function(initB, secondI){
    getrespons.init = initB;
    getrespons.scondTriger = secondI;

    return 'Getresonse Done';
}

global.facebookStart = function(initB, secondI){
    facebook.init = initB;
    facebook.scondTriger = secondI;

    return 'FB Pixel Done';
}



