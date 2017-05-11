
//jQuery time
function init_stepped_form(){
  var current_fs, next_fs, previous_fs; //fieldsets
  var left, opacity, scale; //fieldset properties which we will animate
  var animating; //flag to prevent quick multi-click glitches

  $('ul#progressbar li').on('click', function(){
    if(animating) return false;
    animating = true;
    var next_index = $(this).index();
    var current_index = $('ul#progressbar li.active:last').index();
    current_fs = $('form fieldset').eq(current_index);
    next_fs = $('form fieldset').eq(next_index);
    $('#progressbar li').removeClass('active');
    for(var i = 0; i <= next_index; i++)
      $('#progressbar li').eq(i).addClass('active');
    if (current_index < next_index) {
      next_fs.show();
      current_fs.animate({opacity: 0}, {
        step: function(now, mx) {
          scale = 1 - (1 - now) * 0.2;
          left = (now * 50)+"%";
          opacity = 1 - now;
          current_fs.css({
            'transform': 'scale('+scale+')',
            'position': 'absolute'
          });
          next_fs.css({'left': left, 'opacity': opacity});
        },
        duration: 800,
        complete: function(){
          current_fs.hide();
          animating = false;
          $('form fieldset').css({'position': 'relative', 'transform': 'scale(1)'});
        },
        easing: 'easeInOutBack'
      });
    }
    else if (current_index > next_index)
    {
      previous_fs = next_fs;
      previous_fs.css({'position': 'absolute','left': '0%'});
      previous_fs.show();
      current_fs.animate({opacity: 0}, {
        step: function(now, mx) {
          scale = 0.8 + (1 - now) * 0.2;
          left = ((1-now) * 50)+"%";
          opacity = 1 - now;
          current_fs.css({'left': left, 'position': 'relative'});
          previous_fs.css({'transform': 'scale('+scale+')', 'opacity': opacity});
        },
        duration: 800,
        complete: function(){
          current_fs.hide();
          animating = false;
          $('form fieldset').css({'position': 'relative', 'transform': 'scale(1)'});
        },
        easing: 'easeInOutBack'
      });
    }
  });

  $(".next").on('click', function(){
    if(animating) return false;
    animating = true;

    current_fs = $(this).parent();
    next_fs = $(this).parent().next();

    $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

    next_fs.show();
    current_fs.animate({opacity: 0}, {
      step: function(now, mx) {
        scale = 1 - (1 - now) * 0.2;
        left = (now * 50)+"%";
        opacity = 1 - now;
        current_fs.css({
          'transform': 'scale('+scale+')',
          'position': 'absolute'
        });
        next_fs.css({'left': left, 'opacity': opacity});
      },
      duration: 800,
      complete: function(){
        current_fs.hide();
        animating = false;
      },
      easing: 'easeInOutBack'
    });
  });

  $(".previous").click(function(){
    if(animating) return false;
    animating = true;

    current_fs = $(this).parent();
    previous_fs = $(this).parent().prev();

    $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

    previous_fs.show();
    current_fs.animate({opacity: 0}, {
      step: function(now, mx) {
        scale = 0.8 + (1 - now) * 0.2;
        left = ((1-now) * 50)+"%";
        opacity = 1 - now;
        current_fs.css({'left': left});
        previous_fs.css({'transform': 'scale('+scale+')', 'opacity': opacity});
      },
      duration: 800,
      start: function() {
        previous_fs.css({'position': 'absolute'});
      },
      complete: function(){
        current_fs.hide();
        animating = false;
        previous_fs.css({'position': 'relative'});
      },
      easing: 'easeInOutBack'
    });
  });
}
