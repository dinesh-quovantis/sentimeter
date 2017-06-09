// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require Chart.bundle
//= require chartkick
//= require turbolinks
//= require_tree .

$(document).ready(function(){
   $('body').on('click' , '.tweet_status_buttons' , function(){
      $('.tweet-handler-block.right-detailed-panel').removeClass('empty-panel');
      $('.tweet-handler-block.right-detailed-panel').fadeIn('slow');
      $( this ).closest( ".tweet-item" ).addClass('active-mod');
   });
   var windowsHeight = $(window).height(),
   finalHeight = windowsHeight - 120;
   $('.login-wrapper').css('height',finalHeight +'px') ;
   console.log(finalHeight);

   $(window).scroll(function(){
     var sticky = $('.tweet-handler-header-block'),
         scrollTop = $(window).scrollTop(),
         footerTopPos = $('#footer').offset().top,
         rightPanel = $('.right-detailed-panel').offset().top + $('.right-detailed-panel').outerHeight(),
         fixedWidth = $('.left-tweet-panel').width();

     if (scrollTop >= 360){
        sticky.addClass('fixed');
        $('.right-detailed-panel').addClass('fixed');
        sticky.css('width',fixedWidth);
        $('.right-detailed-panel').css('width',fixedWidth);
     }
     else{
       sticky.removeClass('fixed');
        $('.right-detailed-panel').removeClass('fixed');
     };

      if(rightPanel >= footerTopPos) {
        $('.right-detailed-panel').css('position', 'static');
      };
    });
  });
