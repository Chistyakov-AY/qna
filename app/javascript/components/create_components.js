import jquery from "jquery"
$('.answer-errors').html('<%= render 'shared/errors', resource: @answer %>');