$(document).ready(function(){
   $('.predictions_form').bind('submit',function(event){
       event.preventDefault();
       var predictions = [];
       $('.prediction').each(function(){
           var prediction = {};
           prediction.home_team = $(this).data('home-team');
           prediction.away_team = $(this).data('away-team');
           prediction.home_team_score = parseInt($(this).find('.home_team_score option:selected').text());
           prediction.away_team_score = parseInt($(this).find('.away_team_score option:selected').text());
           prediction.goal_scorer = $(this).find('.goal_scorer option:selected').text();
           prediction.additional_goal_scorer = $(this).find('.additional_goal_scorer option:selected').text();

           predictions.push(prediction);
       });

       var predictions_json = JSON.stringify(predictions);

       $.ajax({
           type:"POST",
           url:"/predictions",
           data:predictions_json
       }).done(function (predictions) {
               var error = false;

               for (var index = 0; index < predictions.length; index++) {
                   if (!predictions[index].valid) {
                       error = true;
                       $($($('.prediction_list li')[index]).find('select')).addClass('error');
                   }
                   else {
                       $($($('.prediction_list li')[index]).find('select')).removeClass('error');
                   }
               }

               if(error){
                   $('.error_message').css('display', 'block');
               }
               else {
                   $('.predictions_form').unbind('submit');
                   $('.predictions_form').submit();

               }
           });
    })
});