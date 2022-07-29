

 new WOW().init();


 $(document).ready(function () {
  /* 모바일 사이트맵 nav */
  $(document).ready(function () {
   $('.m-menu > li').first().addClass("active").find('ul').show();
   $('.m-menu > li > a').click(function () {
    if (!$(this).hasClass("active")) {
     $('.m-menu > li > ul').slideUp();
     $(this).next().slideToggle();
     $('.m-menu > li > a').removeClass('active');
     $(this).addClass('active');
    }else {
     $('.m-menu > li > ul').slideUp();
     $('.m-menu > li > a').removeClass('active');
    }
   });
  });
  /* 모바일 메뉴 열리게 */
  $('.menu-btn').click(function(){
   $('.mobile-menu').toggle();
  })
 });














