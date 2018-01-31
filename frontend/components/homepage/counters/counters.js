import "./counters.css";

/*************************
 counter
 *************************/
require("imports-loader?$=jquery!jquery-countto/jquery.countTo.js");
$('.timer').countTo();