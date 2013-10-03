if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i) || navigator.userAgent.match(/iPad/i))
    $('html').addClass('ios');

$(function() {
    var colors = ['ux', 'vg', 'cp', 'pr', 'cs'];
    var color = colors[Math.floor(Math.random() * colors.length)];
    if (color)
        $('body').removeClass('ux').addClass(color).addClass('colored');

    var photo_url = '/themes/onepage/images/content/';
    var photos = [
            'samp-1.jpg',
            'samp-2.jpg',
            'samp-3.jpg',
            'samp-4.jpg',
            'samp-5.jpg',
            'samp-6.jpg',
            'samp-7.jpg',
            'samp-8.jpg',
            'samp-9.jpg',
            'samp-10.jpg',
            'samp-11.jpg',
            'samp-12.jpg',
            'samp-13.jpg',
            'samp-14.jpg',
            'samp-15.jpg',
            'samp-16.jpg',
            'samp-17.jpg',
            'samp-18.jpg',
            'samp-19.jpg'
    ];

    /*$('#family .photo').each(function() {
        var i = Math.floor(Math.random() * photos.length);
        var photo = photos[i];

        if (photo) {
            $(this).find('img').attr('src', photo_url+photo);
            photos.splice(i, 1);
        }
    });*/
    function updateUI() {

        if ($(window).scrollTop() >= ($('#intro p').position().top - 30)) {
            if ($('html').hasClass('lt-ie9'))
                $('#intro').find('p, h1').fadeOut(300);
            else
                $('#intro').addClass('read');
        } else {
            if ($('html').hasClass('lt-ie9'))
                $('#intro').find('p, h1').fadeIn(300);
            else
                $('#intro').removeClass('read');
        }

        if ($(window).scrollTop() >= ($(document).height() - $(window).height())) {
            if ($('html').hasClass('lt-ie9'))
                $('.widget').fadeIn(300);
            else
                $('.widget').addClass('ready');
        } else {
            if ($('html').hasClass('lt-ie9'))
                $('.widget').fadeOut(300);
            else
                $('.widget').removeClass('ready');
        }

        if ($('.section-home').length && $(window).scrollTop() + $(window).height() >= $('#careers .button').offset().top) {
            $('#family').addClass('ready');
        }

    }

    $('#location > .widget').each(function() {
        var el = $(this).hide();
        var data = fb_data;
		if (data) {
		    if (data.cover && data.cover.source)
			$('.cover', el).css({ 'background-image': 'url(\"'+data.cover.source+'\")' });
		    if (data.picture)
		        $('.avatar', el).css({ 'background-image': 'url(\"'+data.picture+'\")' });
		    if (data.likes)
			$('.stats .likes', el).text(data.likes + ' likes');
		    if (data.were_here_count)
			$('.stats .here', el).text(data.were_here_count + ' were here');
		    if (data.location && data.location.street && data.location.city)
			$('.address', el).text(data.location.street+', '+data.location.city);
		    if (data.phone)
			$('.phone', el).text(data.phone);
		}
		el.show();

    });

    $(window).on('scroll', function(e) {
        updateUI();
    });

    $(document).on('click', '.toggler .toggle', function() {
        var toggler = $(this).parents('.toggler').first().toggleClass('toggled').find('.togglable').toggle();
        // work around transition/display bug http://code.google.com/p/chromium/issues/detail?id=121340
        setTimeout(function() { toggler.toggleClass('ready'); }, 1); //toggleClass('toggled');
        return false;
    });


    updateUI();
    $('#intro').removeClass('read');
    $('#jobs-list .togglable').hide();
});
